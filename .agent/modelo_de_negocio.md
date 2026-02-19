# Proveedor del servicio de creación de menús 3D

┌─────────────────────────────────────────────────────────────────┐
│                        ACTORES DEL SISTEMA                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. ADMIN (Tú)                                                  │
│     - Creas modelos 3D para clientes                            │
│     - Gestionas menús de cada restaurante                       │
│     - Generas QR codes                                          │
│     - Cobras suscripciones                                      │
│                                                                 │
│  2. CLIENTES (Restaurantes)                                     │
│     - Ven sus menús en app móvil                                │
│     - Colocan tablets/dispositivos en mesas                     │
│     - Pagan suscripción mensual                                 │
│                                                                 │
│  3. USUARIOS FINALES (Comensales)                               │
│     - Escanean QR                                               │
│     - Ven platillos en AR                                       │
│     - No pagan, no se registran                                 │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    APLICACIÓN PRINCIPAL (Rails 8)               │
│                    Panel de Administración                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              DASHBOARD ADMIN (Tú)                        │  │
│  │                                                          │  │
│  │  /admin/clients                                          │  │
│  │  ├── Lista de clientes (restaurantes)                    │  │
│  │  ├── Estado de suscripción de cada uno                   │  │
│  │  └── [Nuevo Cliente]                                     │  │
│  │                                                          │  │
│  │  /admin/clients/:id/menus                                │  │
│  │  ├── Crear menú para cliente                             │  │
│  │  ├── Agregar platillos                                   │  │
│  │  ├── Subir video → Luma AI → 3D                         │  │
│  │  └── Generar QR codes                                    │  │
│  │                                                          │  │
│  │  /admin/clients/:id/qr-codes                             │  │
│  │  ├── Ver todos los QR del cliente                        │  │
│  │  └── Descargar PDF printable                             │  │
│  │                                                          │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              API para APP MÓVIL CLIENTE                   │  │
│  │                                                          │  │
│  │  GET /api/v1/my_menus                                    │  │
│  │  ├── Autenticación con token del cliente                 │  │
│  │  └── Retorna menús del restaurante                       │  │
│  │                                                          │  │
│  │  GET /api/v1/menus/:id                                   │  │
│  │  └── Detalle del menú con platillos                      │  │
│  │                                                          │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              PÁGINA PÚBLICA (Comensal)                    │  │
│  │                                                          │  │
│  │  /v/:client_slug/d/:dish_id                              │  │
│  │  ├── Página con Model Viewer                             │  │
│  │  ├── Sin autenticación                                   │  │
│  │  └── Acceso vía QR code                                  │  │
│  │                                                          │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    APP MÓVIL CLIENTE (Fase 2)                   │
│                    React Native o Flutter                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Login con código de cliente                                    │
│     │                                                           │
│     ▼                                                           │
│  Ver mis menús                                                  │
│     │                                                           │
│     ▼                                                           │
│  Seleccionar menú para mostrar en tablet/pantalla               │
│     │                                                           │
│     ▼                                                           │
│  Mostrar QR code grande para que comensales escaneen            │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
