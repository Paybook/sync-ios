# Paybook iOS Library V1.3.3

Esta es la librería de Paybook para iOS. Mediante esta librería usted puede implementar el API REST de Paybook de manera rapida y sencilla a través de sus clases y métodos.

### Requerimientos

1. Xcode 8.1+
2. Gestor de dependencias CocoaPods ($ gem install cocoapods)

### Instalación

Para integrar Paybook en tu proyecto Xcode usando [CocoaPods](https://cocoapods.org), lo primero que tenemos que hacer es instalar la libreria de Paybook, para eso nos dirigiremos al directorio de mi proyecto por medio de la terminal, estando ahí ejecutaremos el siguiente comando para crear nuestro pod file:

```
$ pod init
```

**Importante: ** La ejecución del comando anterior requiere que tengas instalado cocoapods en tu equipo.

El siguiente paso es editar nuestro pod file para agregar nuestras dependencias, utiliza el siguiente comando para abrir tu pod file en Xcode:

```
$ open -a Xcode Podfile
```

Reemplaza el contenido de tu pod file con el siguiente codigo:

```swift
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target 'YOUR_PROJECT_NAME' do
use_frameworks!
pod 'Paybook', '~> 1.3.3'
end
```

**Importante:** Para tener soporte con las diferentes versiones de Swift verifique que version de Paybook devera agregar en su Pod File:

- Swift 2.2-   ->   Paybook 1.1.1
- Swift 2.3    ->   Paybook 1.2.0
- Swift 3.0+   ->   Paybook 1.3.3



## Quickstart:

Antes de consultar la documentación puedes tomar alguno de nuestros tutoriales:

- [Quickstart para sincronizar al SAT](https://github.com/Paybook/sync-ios/blob/master/Example/Quickstart_sat.md)

- [Quickstart para sincronizar una cuenta bancaria con credenciales sencillas (usuario y contraseña)](https://github.com/Paybook/sync-ios/blob/master/Example/Quickstart_normal_bank.md)

- [Quickstart para sincronizar una cuenta bancaria con token (usuario y contraseña)](https://github.com/Paybook/sync-ios/blob/master/Example/Quickstart_token_bank.md)

## Recordatorios:

- Puedes consultar la documentación del API REST [aquí](https://www.paybook.com/sync/docs#api-Overview)
- Puedes consultar todos los recursos que tenemos para ti [aquí](https://github.com/Paybook)

## Documentación:

Cada método está documentado tomando como base la siguiente estructura:

```
method_type returned_value_type x = class_or_instance.get(attr1:attr1_type,...,attrn:attrN_type)
```

1. method_type: indica si el método es estático, en caso de no estar indica que el método es de instancia, o bien, es un constructor.
2. returned_value_type: indica el tipo de dato regresado por el método
3. x: es una representación del valor retornado por el método
4. class_or_instance: es la Clase o una instancia de la clase que contiene el método a ejecutar
5. attrX: es el nombre del atributo X
6. attrX_type: es el tipo de dato del atributo X

**Importante:** Todos los metodos necesitan un medio de auntentificación ya sea por medio del id_user o una session y regresan valores por medio de una función completionHandler que recibe el tipo de dato a retornar en caso de que el request sea exitoso o un error en caso de fallar e.g:
``` swift
Account.get([mySession], id_user: nil, completionHandler: {
    response, error in
    print("\(response), \(error)")
})
```

### Accounts

Estructura de los atributos de la clase:

| Account         |                                  
| -------------- | 
| + str id_account <br> + str id_external <br> + str id_user <br> + str id_credential <br> + str id_site <br> + str id_site_organization <br> + str name <br> + str number <br> + float balance <br> + str site <br> + int dt_refresh  |

Descripción de los métodos de la clase:

| Action         | REST API ENDPOINT                                 | LIBRARY METHOD                                  |
| -------------- | ---------------------------------------- | ------------------------------------ |
| Requests accounts of a user | GET https://sync.paybook.com/v1/accounts | ```static NSArray [Account] = Account.get(session:Session?,id_user:String?,completionHandler:(([Account]?, PaybookError?)->())?)```          |

### Attachments

Estructura de los atributos de la clase:

| Attachments         |                                  
| -------------- | 
| + str id_account <br> + str id_external <br> + str id_user <br> + str id_attachment_type <br> + str id_transaction <br> + str file <br> + str extra <br> + str url <br> + int dt_refresh |

Descripción de los métodos de la clase:

| Action         | REST API ENDPOINT                                 | LIBRARY METHOD                                  |
| -------------- | ---------------------------------------- | ------------------------------------ |
| Requests attachments | GET https://sync.paybook.com/v1/attachments <br> GET https://sync.paybook.com/v1/attachments/:id_attachment <br> GET https://sync.paybook.com/v1/attachments/:id_attachment/extra | ```static NSArray [Attachment] = Attachment.get(session:Session?,id_user:String?,completionHandler:(([Attachments]?,PaybookError?)->())?)```          |
| Request the number of attachments | GET https://sync.paybook.com/v1/attachments/counts | ```static int attachments_count = Attachment.get_count(session:Session?,id_user:String?,completionHandler:((Int?,PaybookError?)->())?)```          |

### Catalogues

Estructuras de la clase:

| Account_type         | Attachment_type | Country |                                 
| -------------- | -------------- | -------------- | 
| + str id_account_type <br> + str name | + str id_attachment_type <br> + str name | + str id_country <br> + str name <br> + str code |

| Site         | Credential_structure | Site_organization |                                 
| -------------- | -------------- | -------------- | 
| + str id_site <br> + str id_site_organization <br> + str id_site_organization_type <br> + str name <br> + list credentials | + str name <br> + str type <br> + str label <br> + bool required <br> + str username | + str id_site_organization <br> + str id_site_organization_type <br> + str id_country <br> + str name <br> + str avatar <br> + str small_cover <br> + str cover |

Descripción de los métodos de la clase:

| Action         | REST API ENDPOINT                                 | LIBRARY METHOD                                  |
| -------------- | ---------------------------------------- | ------------------------------------ |
| Request account types | GET https://sync.paybook.com/v1/catalogues/account_types   | ```static NSArray [Account_type] = Catalogues.get_account_types(session:Session?,id_user:String?,completionHandler:(([Account_type]?, PaybookError?)->())?)```          |
| Request attachment types | GET https://sync.paybook.com/v1/catalogues/attachment_types   | ```static NSArray [Attachment_type] = Catalogues.get_attachment_types(session:Session?,id_user:String?,completionHandler:(([Attachment_type]?,PaybookError?)->())?)```          |
| Request available countries | GET https://sync.paybook.com/v1/catalogues/countries   | ```static NSArray [Country] = Catalogues.get_countries(session:Session?,id_user:String?,completionHandler:(([Country]?,PaybookError?)->())?)```          |
| Request available sites | GET https://sync.paybook.com/v1/catalogues/sites   | ```static NSArray [Site] = Catalogues.get_sites(session:Session?,id_user:String?,completionHandler:(([Site]?,PaybookError?)->())?)```          |
| Request site organizations | GET https://sync.paybook.com/v1/catalogues/site_organizations   | ```static NSArray [Site_organization] = Catalogues.get_site_organizations(session:Session?,id_user:String?,completionHandler:(([Site_organization]?,PaybookError?)->())?)```          |

### Credentials

Estructura de los atributos de la clase:

| Credentials         |                                  
| -------------- | 
| + str id_site <br> + str id_credential <br> + str username <br> + str id_site_organization <br> + str id_site_organization_type <br> + str ws <br> + str status <br> + str twofa <br> |

Descripción de los métodos de la clase:

| Action         | REST API ENDPOINT                                 | LIBRARY METHOD                                  |
| -------------- | ---------------------------------------- | ------------------------------------ |
| Creates or updates credentials | POST https://sync.paybook.com/v1/credentials | ```Credentials credentials = Credential(session:Session?,id_user:String?,id_site:String,credentials:NSDictionary,completionHandler:((Credentials?,PaybookError?)->())?)```          |
| Deletes credentials | DELETE https://sync.paybook.com/v1/credentials/:id_credential | ```static Bool deleted Credentials.delete(session:Session?,id_user:String?,id_credential:String,completionHandler:((Bool?,PaybookError?)->())?)```          |
| Request status | GET status_url | ```list [NSDictionary] = credentials.get_status(session:Session?,id_user:String?,completionHandler:(([NSDictionary]?,PaybookError?)->())?)```          |
| Set twofa | POST twofa_url | ```bool twofa_set = credentials.set_twofa(session:Session?,id_user:String?,params:NSDictionary,completionHandler:((Bool?,PaybookError?)->())?)```          |
| Request register credentials | GET https://sync.paybook.com/v1/credentials | ```static list [Credentials] = Credentials.get(session:Session?,id_user:String?,completionHandler:(([Credentials]?,PaybookError?)->())?)```          |


### Sessions

Estructura de los atributos de la clase:

| Sessions         |                                  
| -------------- | 
| + User user <br> + str token   |

Descripción de los métodos de la clase:


| Action         | REST API ENDPOINT                                 | LIBRARY METHOD                                  |
| -------------- | ---------------------------------------- | ------------------------------------ |
| Creates a session | POST https://sync.paybook.com/v1/sessions   | ```Session session = Session(id_user:String,completionHandler:((Session?,PaybookError?)->())?)```          |
| Verify a session | GET https://sync.paybook.com/v1/sessions/:token/verify | ```NSDictionary verified = session.verify(completionHandler:((NSDictionary?, PaybookError?)->())?)```                  |
| Deletes a session     | DELETE https://sync.paybook.com/v1/sessions/:token    | ```static Bool deleted = Session.delete(token:String,completionHandler:((Bool?,PaybookError?)->())?)```|


### Transactions

Estructura de los atributos de la clase:

| Transactions         |                                  
| -------------- | 
| + str id_transaction <br> + str id_user <br> + str id_external <br> + str id_site <br> + str id_site_organization <br> + str id_site_organization_type <br> + str id_account <br> + str id_account_type <br> + str is_disable <br> + str description <br> + float amount <br> + int dt_transaction <br> + int dt_refresh   |

Descripción de los métodos de la clase:


| Action         | REST API ENDPOINT                                 | LIBRARY METHOD                                  |
| -------------- | ---------------------------------------- | ------------------------------------ |
| Requests number of transactions | GET https://sync.paybook.com/v1/transactions/count | ```static int transactions_count = Transaction.get_count(session :Session,id_user:String?,completionHandler:((Int?, PaybookError?)->())?)```          |
| Requests transactions | GET https://sync.paybook.com/v1/transactions | ```static NSArray [Transaction] = Transaction.get(session:Session?,id_user:String?,completionHandler:(([Transaction]?,PaybookError?)->())?)```          |

### User

Estructura de los atributos de la clase:

| User         |                                  
| -------------- | 
| + str name <br> + str id_user <br> + str id_external <br> + int dt_create <br> + int dt_modify   |

Descripción de los métodos de la clase:


| Action         | REST API ENDPOINT                                 | LIBRARY METHOD                                 |
| -------------- | ---------------------------------------- | ------------------------------------ |
| Creates a user | POST https://sync.paybook.com/v1/users   | ```User user = User(username:String,completionHandler:((User?,PaybookError?)->())?)```          |
| Deletes a user | DELETE https://sync.paybook.com/v1/users | ```static Bool deleted = User.delete(id_user:String,completionHandler: ((Bool?, PaybookError?)->())?)```                  |
| Get users      | GET https://sync.paybook.com/v1/users    | ```static NSArray [User] = User.get(completionHandler:(([User]?,PaybookError?)->())?)```|








