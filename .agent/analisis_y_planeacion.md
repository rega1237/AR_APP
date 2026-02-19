# Análisis del Modelo de Negocio y Plan de Desarrollo: AR Menu SaaS

Este documento detalla el análisis del modelo de negocio para el servicio de menús 3D en Realidad Aumentada (AR) y establece una hoja de ruta estratégica para su implementación.

---

## 1. Análisis del Modelo de Negocio

El proyecto se posiciona como un **SaaS (Software as a Service) B2B2C**, donde el valor principal radica en mejorar la experiencia del comensal y optimizar la presentación de productos para el restaurante.

### Actores y Flujo de Valor
1.  **Admin (SaaS Provider):** Controla el ecosistema, gestiona la infraestructura técnica (3D/IA) y la monetización.
2.  **Clientes (Restaurantes):** Usuarios que buscan diferenciarse. Pagan una suscripción por la gestión de sus activos 3D y la facilidad de despliegue.
3.  **Usuarios Finales (Comensales):** Consumidores directos del contenido digital. Beneficio: "Lo que ves es lo que recibes".

### Componentes Críticos del Ecosistema
*   **Rails 8 Admin:** El "cerebro" donde ocurre la gestión de datos, seguridad y generación de QR.
*   **Pipeline 3D (Luma AI):** La pieza tecnológica que convierte video en modelos 3D, eliminando la barrera de creación manual.
*   **Model Viewer (Página Pública):** Interfaz ligera y universal para el acceso inmediato vía AR.

---

## 2. Plan de Desarrollo por Fases

Se propone un desarrollo incremental para validar la tecnología rápidamente antes de escalar.

### Fase 1: Cimientos y Gestión de Clientes (MVP Backend)
*   **Funcionalidad:**
    *   Arquitectura base en Rails 8.
    *   Gestión de Clientes (Restaurantes) y Suscripciones básicas.
    *   Jerarquía de datos: `Cliente` -> `Menús` -> `Platillos`.
    *   Generación de tokens de autenticación para API.
*   **Fin:** Establecer la estructura de datos sólida y el panel administrativo para el control total del negocio.

### Fase 2: Experiencia 3D y Visualización Pública
*   **Funcionalidad:**
    *   Implementación de `Google Model Viewer` en la vista pública.
    *   Subida y almacenamiento de modelos 3D (`.glb` / `.usdz`).
    *   Rutas amigables para QR (`/v/:client_slug/d/:dish_id`).
    *   Dashboard administrativo para previsualizar modelos.
*   **Fin:** Lograr el "Wow Factor" funcional. Que el comensal ya pueda ver un platillo en su mesa desde su navegador.

### Fase 3: Automatización de Contenido y Monetización
*   **Funcionalidad:**
    *   Integración (API o manual asistida) con Luma AI para convertir videos en 3D.
    *   Generador de PDF para QRs imprimibles con marca blanca.
    *   Integración de pasarela de pagos (Stripe) para suscripciones recurrentes.
*   **Fin:** Escalar el negocio. Automatizar la creación de activos y asegurar el flujo de ingresos.

### Fase 4: Ecosistema Móvil del Cliente (App Tablet/Móvil)
*   **Funcionalidad:**
    *   App en Flutter o React Native.
    *   Modo "Kiosco": Mostrar el menú actual y el QR de gran tamaño para las mesas.
    *   Sincronización en tiempo real con el backend de Rails.
*   **Fin:** Profesionalizar la herramienta en el punto de venta. Reducir la dependencia de QRs estáticos y facilitar cambios de menú dinámicos.

---

## 3. Consideraciones Técnicas y de Diseño
*   **Estética Premium:** La página de visualización debe ser minimalista y rápida.
*   **SEO:** Slugs descriptivos para los restaurantes.
*   **Escalabilidad:** Almacenamiento eficiente de modelos 3D (Cloud Storage).

---

> [!TIP]
> **Próximo Paso:** Una vez aprobadas las fases, podemos iniciar con la arquitectura de la Fase 1 creando los modelos de datos base.
