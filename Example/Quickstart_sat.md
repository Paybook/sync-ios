##QUICKSTART SAT

### Requerimientos

1. Algunas credenciales de acceso al SAT (RFC y CIEC)
2. Xcode 7.3+
3. Gestor de dependencias CocoaPods ($ gem install cocoapods)


### Introducción

A lo largo de este tutorial te enseñaremos como consumir el API Rest de Paybook por medio de la librería de Paybook. Al terminar este tutorial habrás podido crear nuevos usuarios en Paybook, sincronizar algunas instituciones de estos usuarios y visualizar las transacciones sincronizadas.

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


####2. Ejecutamos el Script:
Este tutorial está basado en el controlador [Quickstar_sat_ViewController](https://github.com/Paybook/sync-ios/blob/master/Example/PaybookSync/Quickstart_sat_ViewController.swift) por lo que puedes descargar el archivo y configurarla como la clase del View Controller inicial, para probarla solo tines que configurar los valores YOUR_API_KEY, YOUR_RFC, YOUR_CIEC y ejecutarlo en tu equipo:


A continuación explicaremos detalladamente la lógica del script que acabas de ejecutar.

####3. Importamos paybook
El primer paso es importar la librería y algunas dependencias:

```
import UIKit
import Paybook
```

####4. Configuramos la librería
Una vez importada la librería tenemos que configurarla, para esto asignaremos el API KEY de Paybook dentro del metodo viewDidLoad de la clase.

```
override func viewDidLoad() {
super.viewDidLoad()

Paybook.api_key = "YOUR_API_KEY"

}
```

####5. Creamos un usuario:
Una vez configurada la librería, el primer paso será crear un usuario, este usuario será, por ejemplo, aquel del cual queremos obtener sus facturas del SAT.
Para esto crearemos una función "createUser" y por medio de una funcion completionHandler que recive el usuario ya creado lo guardaremos dentro de una variable de la clase, para usarlo posteriormente:

**Importante**: todo usuario estará ligado al API KEY con el que configuraste la librería (paso 4)

```
func createUser(){

_ = User(username: "MY_USER", id_user: nil, completionHandler: {
    user_response, error in
    if user_response != nil{
        // Asignamos el objeto user_response a la variable user
        self.user = user_response!
        print("User : \(user_response?.name)")
        
    }else{
        print("No se pudo crear el usuario: \(error?.message)")
    }
})

}
```
En la función completionHandler puedes inyectar tu propio codigo para trabajar con el usuario creado.

####6. Consultamos los usuarios ligados a nuestra API KEY:
Para verificar que el usuario creado en el paso 5 se haya creado corréctamente podemos consultar la lista de usuarios ligados a nuestra API KEY, esto lo podremos hacer por medio de la siguiente función.

```
func getUsers(){
    User.get(){
        response,error in
    
        if response != nil {
            print("\nUsers: ")
            for user in response!{
                print("\(user.name)")
            }
        }
        self.createSession()
    }
}
```

####7. Creamos una nueva sesión:
Para sincronizar las facturas del SAT primero tenemos que crear una sesión, la sesión estará ligada al usuario y tiene un proceso de expiración de 5 minutos después de que ésta ha estado inactiva. Para crear una sesión:

```
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


####8. Consultamos el catálogo de instituciones que podemos sincronizar y extraemos el SAT:
Paybook tiene un catálogo de instituciones que podemos sincronizar por usuario:

![Instituciones](https://github.com/Paybook/sync-py/blob/master/sites.png "Instituciones")

A continuación consultaremos este catálogo y seleccionaremos el sitio del SAT para sincronizar las facturas del usuario que hemos creado en el paso 5:

```
func getCatalogueSite(){
    Catalogues.get_sites(self.session, id_user: nil, is_test: nil, completionHandler: {
        sites_array, error in

        if sites_array != nil{

            print("\nCatalago de Sites:")
            for site in sites_array!{

                if site.name == "CIEC" {
                    print ("SAT site: \(site.name) \(site.id_site)")
                    self.site = site
                }else{
                    print(site.name)
                }
                
            }

        }

    })
}
```

####9. Configuramos nuestras credenciales del SAT:
Una vez que hemos obtenido el sitio del SAT del catálogo de institiciones, configuraremos las credenciales de nuestro usuario (estas credenciales son las que el usuario utiliza para acceder al portal del SAT).

```
func createCredential(){
    let data = [
    "rfc" : "YOUR_RFC",
    "password" : "YOUR_CIEC"
    ]

    _ = Credentials(session: self.session, id_user: nil, id_site: site.id_site, credentials: data, completionHandler: {
        credential_response , error in
    })
}
```

####10. Una vez creada una credencial es necesario estar monitorendo el estatus de sincronización. Cada vez que registamos unas credenciales Paybook inicia un Job (proceso) que se encargará de validar esas credenciales y posteriormente sincronizar las transacciones. Este Job se puede representar como una maquina de estados:

![Job Estatus](https://github.com/Paybook/sync-py/blob/master/normal.png "Job Estatus")

Una vez registradas las credenciales se obtiene el primer estado (Código 100), posteriormente una vez que el Job ha empezado se obtiene el segundo estado (Código 101). Después de aquí, en caso de que las credenciales sean válidas, prosiguen los estados 202, 201 o 200. Estos indican que la sincronización está en proceso (código 201), que no se encontraron transacciones (código 202), o bien, la sincronización ha terminado (código 200). La librería proporciona un método para consultar el estado actual del Job. Este método se puede ejecutar constantemente hasta que se obtenga el estado requerido por el usuario, para este ejemplo especifico consultamos el estado hasta que se obtenga un código 200, es decir, que la sincronización haya terminado:

Para esto agregaremos el siguiente codigo en nuestra función completionHandler:

```
if credential_response != nil {

self.credential = credential_response
print("\nCheck Status:")
self.timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(self.check_status), userInfo: nil, repeats: true)


}else{
print("No se pudo crear las credenciales: \(error?.message)")
}

```

Este sección de codigo va a inicializar un NSTimer que se encargara de de ejecutar la función "checkStatus" cada 3 segundos hasta que la credencial termine su proceso de sincronización.


```
if credential_response != nil {

self.credential = credential_response
print("\nCheck Status:")
self.timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(self.checkStatus), userInfo: nil, repeats: true)


}else{
print("No se pudo crear las credenciales: \(error?.message)")
}

```

####11. Consultamos las facturas sincronizadas:
Una vez que ya hemos checado el estado de la sincronización y hemos verificado que ha terminado (código 200) podemos consultar las facturas sincronizadas, pra eso utlizaremos la función "getTransactions" la cual ejecutara lo siguiente:
```
Transaction.get(self.session, id_user: nil, completionHandler: {
    transaction_array, error in
    if transaction_array != nil {
        print("\nTransactions: ")
        for transaction in transaction_array! {
            print("$\(transaction.amount), \(transaction.description) ")
        }
    self.getAttachments()
    }else{
        print("Problemas al consultar las transacciones: \(error?.message)")    
    }

})
```

####12. Consultamos la información de archivos adjuntos:
Podemos también consultar los archivos adjuntos a estas facturas como lo hacemos en la función "getAttachments", recordemos que por cada factura el SAT tiene una archivo XML y un archivo PDF:
```
Attachments.get(session, id_user: nil, completionHandler: {
    attachments_array, error in
    
    if attachments_array != nil {
        print("\nAttachments: ")
        for attachment in attachments_array! {
            print("Attachment type : \(attachment.id_attachment_type), id_transaction: \(attachment.id_transaction) ")
        }
    }else{
        print("Problemas al consultar los attachments: \(error?.message)")
    }
})
```

¡Felicidades! has terminado con este tutorial. 

### Siguientes Pasos

- Revisar el tutorial de como sincronizar una institución bancaria con credenciales simples (usuario y contraseña) [aquí](https://github.com/Paybook/sync-ios/blob/master/Example/Quickstart_normal_bank.md)

- Revisar el tutorial de como sincronizar una institución bancaria con token [aquí](https://github.com/Paybook/sync-ios/blob/master/Example/Quickstart_token_bank.md)

- Puedes consultar y analizar la documentación completa de la librería [aquí](https://github.com/Paybook/sync-ios)

- Puedes consultar y analizar la documentación del API REST [aquí](https://www.paybook.com/sync/docs#api-Overview)

- Acceder a nuestro proyecto en Github y checar todos los recursos que Paybook tiene para ti [aquí](https://github.com/Paybook)

























