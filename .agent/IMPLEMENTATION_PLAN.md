# Implementation Plan: AR Menu SaaS - Phase 1

This document outlines the detailed stages for Phase 1 (Cimientos y Gestión de Clientes). Following the development guidelines, each stage will be implemented incrementally with a strict Red-Green-Refactor TDD cycle.

## Stage 1: Setup and Base Configuration
Goal: Initialize the Rails 8 application, configure PostgreSQL, Tailwind CSS, and set up the testing framework (RSpec).
Success Criteria:
- Application starts successfully (`rails s`)
- Database can be created and migrated
- Automated test suite (RSpec) runs (with 0 failures)
- Linter configured (Rubocop) with 0 offenses
Status: Complete

## Stage 2: Admin Authentication (Rails 8 Native Auth)
Goal: Generate and configure Rails 8 native authentication for securing the administration panel.
Success Criteria:
- Failing RSpec tests for authentication are written and then pass
- Admin layout is isolated with basic Tailwind CSS styling
- Admin users can sign in, sign out, and access restricted `/admin` routes
Status: Not Started

## Stage 3: Core Client Model
Goal: Implement the `Client` model (Restaurants) with its base attributes and validations.
Success Criteria:
- Failing RSpec tests for `Client` validations (presence of name, valid email, unique slug) are written and go green
- Active Storage is configured for attaching a logo
- `Admin::ClientsController` allows CRUD operations with proper form inputs
Status: Not Started

## Stage 4: Menus, Categories, and Dishes Models
Goal: Establish the relational structure where Clients have Menus, Menus have Categories, and Categories have Dishes.
Success Criteria:
- RSpec Unit tests verify all `has_many` and `belongs_to` associations
- RSpec Unit tests verify validations (e.g., Dish price must be positive)
- Active Storage is attached to `Dish` for photo and `.glb`/`.usdz` 3D model
Status: Not Started

## Stage 5: Nested Admin Controllers
Goal: Complete the UI for admins to manage the nested resources (Menus, Categories, Dishes).
Success Criteria:
- RSpec Feature/System tests prove an admin can create a menu for a client, add a category, and upload a dish
- Views use Tailwind CSS and keep the UI clean
- No N+1 queries in list views
Status: Not Started

> [!NOTE]
> Una vez aprobadas estas 5 etapas, pasaremos a la fase de Ejecución (Execution) para la Etapa 1. Todos los pasos incluirán pruebas automatizadas (TDD) antes de implementarse, según las reglas del proyecto.
