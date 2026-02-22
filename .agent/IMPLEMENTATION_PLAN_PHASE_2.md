# Implementation Plan: AR Menu SaaS - Phase 2 (3D Experience & Public Views)

This document outlines the detailed stages for Phase 2 (Experiencia 3D y Visualización Pública). Following the development guidelines, each stage will be implemented incrementally with a strict Red-Green-Refactor TDD cycle.

## Stage 1: Public Routing and Controllers
Goal: Establish the friendly, mobile-first public-facing URLs accessible via QR codes.
Success Criteria:
- Route `/v/:client_slug` correctly maps to the public menu view (`Public::MenusController#show`).
- Route `/v/:client_slug/d/:dish_id` correctly maps to the public 3D dish view (`Public::DishesController#show`).
- RSpec Request tests verify public access works without authentication.
- If a client or dish isn't found or isn't visible, it safely returns a 404.
Status: Not Started

## Stage 2: Mobile-First Menu View
Goal: Build the public UI where diners will see the categorized list of dishes.
Success Criteria:
- `Public::Menus#show` renders the client's menu, grouped by categories.
- Tailwind CSS is used to create a premium, mobile-first, and highly responsive UI.
- Dishes display their `photo` and basic details (price, description).
- Dishes that have a `model_3d` attached show an "AR/3D" badge or button linking to the viewer.
Status: Not Started

## Stage 3: Google Model Viewer Integration
Goal: Integrate the Google `<model-viewer>` web component to render the 3D assets directly in the browser.
Success Criteria:
- `@google/model-viewer` library is imported and configured (via Importmaps or standard JS).
- `Public::Dishes#show` displays the 3D model using the `<model-viewer>` tag.
- The component dynamically loads the `Dish.model_3d` ActiveStorage attachment (using `.glb` format).
- RSpec System tests (or manual verification) confirm the 3D canvas is rendered.
Status: Not Started

## Stage 4: Admin 3D Preview
Goal: Allow restaurant administrators to preview their uploaded 3D models from the admin panel before generating QRs.
Success Criteria:
- The `Admin::Dishes#show` UI (or the `#edit` page) includes a preview section.
- Admin users can interact with the 3D model exactly as the end-user would.
Status: Not Started

> [!NOTE]
> All code will be written using TDD (RSpec -> Implementation -> View -> Refactor). We will start by creating a new Git branch `feature/public-routing`.
