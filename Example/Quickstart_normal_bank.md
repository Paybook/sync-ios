##QUICKSTART NORMAL BANK

### Requerimientos

1. Tener credenciales de alguna institución bancaria que cuente con autenticación simple (usuario y contraseña)
2. Xcode 7.3+
3. Gestor de dependencias CocoaPods ($ gem install cocoapods)


### Introducción

A lo largo de este tutorial te enseñaremos como sincronizar una institución bancaria normal, es decir, aquella que solo requiere una autenticación (usuario y contraseña), ejemplos de estas instituciones pueden ser Banamex o Santander. En el tutorial asumiremos que ya hemos creado usuarios y por tanto tenemos usuarios ligados a nuestra API KEY, también asumiremos que hemos instalado la librería de python y hecho las configuraciones pertinentes. Si tienes dudas acerca de esto te recomendamos que antes de tomar este tutorial consultes el Quickstart para sincronizar al SAT ya que aquí se abordan los temas de creación de usuarios y sesiones.

La documentación completa de la librería la puedes consultar [aquí](https://github.com/Paybook/sync-ios/blob/master/README.md) 

##En la consola:

####1. Instalamos la librería de Paybook y dependencias:

Para consumir el API de Paybook lo primero que tenemos que hacer es instalar la libreria de Paybook haciendo uso de Cocoapods, para eso nos dirigiremos al directorio de mi proyecto por medio de la terminal, estando ahi ejecutaremos el siguiente comando para crear nuestro pod file:

```
$ pod init
```

**Importante: ** Es posible que la ejecución del comando anterior requiere que tengas instalado cocoapods en tu equipo.

El siguiente paso es editar nuestro pod file para agregar nuestras dependencias, usa el siguiente comando para abrir tu pod file en Xcode:

```
$ open -a Xcode Podfile
```

Reemplaza el contenido de tu pod file con el siguiente codigo:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target 'TestPods' do
    use_frameworks!
    pod 'Paybook', '~> 1.0.6'
end
```

Ejecuta el siguiente comando en la terminal:

```
$ pod install
```


##Ejecución:

Este tutorial está basado en el script [Quickstar_sat_ViewController.swift](https://github.com/Paybook/sync-ios/blob/master/Example/PaybookSync/Quickstart_normal_bank_ViewController.swift) por lo que puedes descargar el archivo, configurar los valores YOUR_API_KEY, YOUR_BANK_USERNAME y YOUR_BANK_PASSWORD, asignarlo como la clase de tu view controller y ejecutarlo en tu equipo:

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
}```

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

Para efectos de este tutorial seleccionaremos **SuperNET Particulares (Santander)** pero tu puedes seleccionar la institución de la cual tienes credenciales.


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

| Código         | Descripción                                |                                
| -------------- | ---------------------------------------- | ------------------------------------ |
| 100 | Credenciales registradas   | 
| 101 | Validando credenciales  | 
| 401      | Credenciales inválidas    |
| 102      | La institución se está sincronizando    |
| 200      | La institución ha sido sincronizada    | 

El status se analisza en la siguiente parte de codigo:

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

La instrucción anterior establece un NSTimer que ejecutara la función "checkStatus" cada 3 segundos y en esta función se analizará el codigo de estado en que se encuentran las credenciales una vez que regrese algun codigo que nos diga que el proceso de sincronización termino, invalidara el NSTimer y continuara con lo siguiente:

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

- Revisar el tutorial de como sincronizar una institución bancaria con token [aquí](https://github.com/Paybook/sync-ios/blob/master/Example/Quickstart_token_bank.md)

- Puedes consultar y analizar la documentación completa de la librearía [aquí](https://github.com/Paybook/sync-ios/blob/master/README.md)

- Puedes consultar y analizar la documentación del API REST [aquí](https://www.paybook.com/sync/docs#api-Overview)

- Acceder a nuestro proyecto en Github y checar todos los recursos que Paybook tiene para ti [aquí](https://github.com/Paybook)





















