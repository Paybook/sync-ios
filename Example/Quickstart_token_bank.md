
##QUICKSTART BANCO CON TOKEN

A lo largo de este tutorial te enseñaremos como sincronizar una institución bancaria con token, es decir, aquella que además de requerir una autenticación (usuario y contraseña) solicita un token, ejemplos de estas instituciones pueden ser Banorte o BBVA Bancomer. En el tutorial asumiremos que ya hemos creado usuarios y por tanto tenemos usuarios ligados a nuestra API KEY, también asumiremos que hemos instalado la librería de python y hecho las configuraciones pertinentes. Si tienes dudas acerca de esto te recomendamos que antes de tomar este tutorial consultes el [Quickstart para sincronizar al SAT](https://github.com/Paybook/sync-ios/blob/master/Example/Quickstart_sat.md) ya que aquí se abordan los temas de creación de usuarios y sesiones.  

### Requerimientos

1. Haber consultado el tutorial [Quickstart General](https://github.com/Paybook/sync-ios/blob/master/Example/Quickstart_sat.md)
2. Tener credenciales de alguna institución bancaria del catálogo de Paybook que solicite token


##Ejecución:

Este tutorial está basado en el script [Quickstart_token_bank_ViewController.swift](https://github.com/Paybook/sync-ios/blob/master/Example/PaybookSync/Quickstart_token_bank_ViewController.swift) por lo que puedes descargar el archivo, configurar los valores YOUR_API_KEY, YOUR_BANK_USERNAME y YOUR_BANK_PASSWORD, asignarlo como la clase de tu view controller y ejecutarlo en tu equipo. Es recomendable tener el token a la mano puesto que el script eventualmente lo solicitará:

Una vez que has ejecutado el archivo podemos continuar analizando el código.

####1. Importar y asignar API key
El primer paso para utilizar nuestra libreria es importarla ya asignarle tu API key esto se lleva acabo en el metodo de la clase viewDidLoad para que se ejecute inmeditamente de haber cragado nuestro ViewContrller.

```
override func viewDidLoad() {
    super.viewDidLoad()
    Paybook.api_key = "YOUR_API_KEY"
}
```

####2. Obtenemos un usuario e iniciamos sesión:
Para realizar la mayoría de las acciones en Paybook es necesario tener un usuario e iniciar una sesión, por lo tanto crearemos una función "getUsers" que se ejecutara en el viewDidLoad despues de haber asignado nuestra API key y que hara una consulta de nuestra lista de usuarios y seleccionaremos el usuario con el que deseamos trabajar. Una vez que tenemos al usuario iniciamos sesión con éste.


```
func getUsers(){
    User.get(){
        response,error in
        if response != nil {
            self.user = response![0]
            print("User: \(self.user.name) \(self.user.id_user)")
            self.createSession()
        }
    }
}

func createSession(){
    self.session = Session(id_user: self.user.id_user, completionHandler: {
    session_response, error in
        if session_response != nil {
            self.session = session_response
            self.getCatalogueSite()
        }else{
            print("No se pudo crear la session: \(error?.message)")
        }
    })
}

```

####3. Consultamos el catálogo de las instituciones de Paybook:
Recordemos que Paybook tiene un catálogo de instituciones que podemos seleccionar para sincronizar nuestros usuarios. A continuación consultaremos este catálogo, por medio de la función "getCatalogueSite" que utiliza nuestra clase Catalogues y hace un "get_sites":

```
func getCatalogueSite(){
    Catalogues.get_sites(self.session, id_user: nil, is_test: nil, completionHandler: {
    sites_array, error in

    if sites_array != nil{
        print("\nCatalago de Sites:")
        for site in sites_array!{
            if site.name == "SuperNET Particulares" {
                print ("* Bank site: \(site.name) \(site.id_site)")
                self.site = site
            }else{
                print(site.name)
            }
        }

        if self.site != nil{
            self.createCredential()
        }
    }

    })
}
```

El catálogo muestra las siguienes instituciones:

1. AfirmeNet
2. Personal
3. BancaNet Personal
4. eBanRegio
5. Banorte Personal
6. CIEC
7. Banorte en su empresa
8. BancaNet Empresarial
9. Banca Personal
10. Corporativo
11. Banco Azteca
12. American Express México
13. SuperNET Particulares
14. ScotiaWeb
15. Empresas
16. InbuRed

Para efectos de este tutorial seleccionaremos **Banorte en su empresa** pero tu puedes seleccionar la institución de la cual tienes credenciales y token.


####4. Registramos las credenciales:

A continuación registraremos las credenciales de nuestro banco, es decir, el usuario y contraseña que nos proporcionó el banco para acceder a sus servicios en línea:

```
func createCredential(){
let dataCredentials = [
    "username" : "BANK_USERNAME",
    "password" : "BANK_PASSWORD"
]

_ = Credentials(session: self.session, id_user: nil, id_site: site.id_site, credentials: dataCredentials, completionHandler: {
    credential_response , error in
        if credential_response != nil {
            self.credential = credential_response
            print("\nCheck Status:")
            self.timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(self.checkStatus), userInfo: nil, repeats: true)
        }else{
            print("No se pudo crear las credenciales: \(error?.message)")
        }

    })
}
```
####5. Checamos el estatus

Una vez que has registrado las credenciales de una institución bancaria para un usuario en Paybook el siguiente paso consiste en checar el estatus de las credenciales, el estatus será una lista con los diferentes estados por los que las credenciales han pasado, el último será el estado actual. A continuación se describen los diferentes estados de las credenciales:

## Códigos:

| Código         | Descripción                                |                                
| -------------- | ---------------------------------------- | ------------------------------------ |
| 100 | Credenciales registradas   | 
| 101 | Validando credenciales  | 
| 401      | Credenciales inválidas    |
| 410      | Esperando token   |
| 102      | La institución se está sincronizando    |
| 200      | La institución ha sido sincronizada    | 

## Maquina de estados exitosos:

![Success](https://github.com/Paybook/sync-py/blob/master/token.png "Success")

## Maquina de estados de error:

![Errores](https://github.com/Paybook/sync-py/blob/master/error.png "Errores")

**Importante** El código 401 se puede presentar múltiples veces en caso de que la autenticación con la institución bancaria requiera múltiples pasos e.g. usuario, contraseña (primera autenticación) y además token (segunda autenticación). Entonces al código 401 únicamente le puede preceder un código 100 (después de introducir usuario y password), o bien, un código 401 (después de haber introducido un token). El código 405 indica que el acceso a la cuenta bancaria está bloqueado y, por otro lado, el código 406 indica que hay una sesión iniciada en esa cuenta por lo que Paybook no puede conectarse.

El estatus se analisza en la siguiente parte de codigo:

```
if credential_response != nil {
    self.credential = credential_response
    print("\nCheck Status:")
    self.timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(self.checkStatus), userInfo: nil, repeats: true)
}else{
    print("No se pudo crear las credenciales: \(error?.message)")
}
```



####6. Checar status:

La instrucción anterior establece un NSTimer que ejecutara la función "checkStatus" cada 3 segundos y en esta función se analizará el codigo de estado en que se encuentran las credenciales una vez que regrese el codigo 410 podemos proseguir a enviar el token:

```
func checkStatus(){

credential.get_status(self.session, id_user: nil, completionHandler: {
    response, error in
    if response != nil{

        let status = response![response!.count-1]

        switch status["code"] as! Int{
        case 100,101,102:
            print("Processing...\(status["code"])")
            break
        case 200,201,202,203:
            print("Success...\(status["code"])")
            self.timer.invalidate()
            self.getTransactions()
            break
        case 401,405,406,411:
            print("User Error \(status["code"])")
            self.timer.invalidate()
            break
        case 410:
            print("Waiting for two-fa \(status["code"])")
            self.timer.invalidate()
            break
        case 500,501,504,505:
            print("System Error \(status["code"])")
            self.timer.invalidate()
            break
        default :
            break
        }
    }else{
        print("Fail: \(error?.message)")
    }
})
}
```

**Importante:** En este paso también se debe contemplar que en vez de un código 410 (esperando token) se puede obtener un código 401 (credenciales inválidas) lo que implica que se deben registrar las credenciales correctas, por lo que el bucle se puede módificar para agregar esta lógica.

####6. Enviar token bancario
Ahora hay que ingresar el valor del token, el cual lo podemos solicitar por medio de un UITextField que podemos agregar a nuestro ViewController en nuestro Main.storyboard o el archivo .xib de nuestro ViewController. En este ejemplo tambien agregaremos un boton con un IBAction que se encargue de enviar el token cuando lo presionemos:

```
    @IBOutlet weak var tokenInput: UITextField!

    @IBAction func sendToken(sender: AnyObject) {
        let params : [String:String] = ["Banorte en su empresa": tokenInput.text!]
        self.credential.set_twofa(self.session, id_user: nil, params: params, completionHandler: {
        response, error in
        if response != nil && response == true{
            self.timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(self.checkStatus), userInfo: nil, repeats: true)
        }else{
            print("\(error?.message)")
        }
        })

    }
```
Para realizar el envio se utliza el metodo de la clase Credentials ".set_twofa" el cual recibe el parametro que falta de enviar en forma de un Dictionary. En caso de de que la respuesta se un true iniciaremos el mismo proceso de checar el estatus de la credencial hasta esperar que la sincronización termine correctamente.


Es importante checar el código 401 que indica que el token introducido es incorrecto, por lo que se puede programar una rutina para pedir el token nuevamente:


**Importante:** No olvides enlazar tu @IBOutlet y @IBAction con el UITextField y UIButton de tu ViewController ya sea en tu archivo ".xib" o ".storyboard".

####7. Consultamos las transacciones de la institución bancaria:

Una vez que la sincronización ha terminado podemos consultar las transacciones y desplegar información de ellas:

```
func getTransactions(){
    Transaction.get(self.session, id_user: nil, completionHandler: {
        transaction_array, error in
        if transaction_array != nil {
            print("\nTransactions: ")
            for transaction in transaction_array! {
                print("\(transaction.description), $\(transaction.amount) ")
            }
        }else{
            print("Problemas al consultar las transacciones: \(error?.message)")
        }
    })
}
```

¡Felicidades! has terminado con este tutorial.

###Siguientes Pasos

- Puedes consultar y analizar la documentación completa de la librería [aquí](https://github.com/Paybook/sync-ios/blob/master/README.md)

- Puedes consultar y analizar la documentación del API REST [aquí](https://www.paybook.com/sync/docs#api-Overview)

- Acceder a nuestro proyecto en Github y checar todos los recursos que Paybook tiene para ti [aquí](https://github.com/Paybook)




