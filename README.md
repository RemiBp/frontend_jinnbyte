# CHOICE – Frontend  
*A new interface for navigating your city.*

---

## Overview

CHOICE is a mobile application designed to make local discovery intuitive and effortless.  
Instead of endless scrolling and guesswork, CHOICE brings together:

- 🗺️ an interactive, real-time **map** of the city,  
- 🤖 an **AI copilot** that understands mood, context, constraints and intent,  
- 👫 a **social layer** showing where your friends are going and what people recommend,  
- 🏪 a **producer space** for restaurants, cultural venues, wellness spots and local businesses,  
- 🔗 and a dedicated **backend** providing structured data, recommendations and AI inference.

This repository contains the **Flutter frontend** powering the CHOICE user and producer experience.

Backend repository:  
➡️ https://github.com/RemiBp/backend_jinnbyte  

Both communicate through REST/JSON endpoints and a shared model structure.

---

## Product intent

CHOICE aims to reinvent how people decide *where to go*.

Traditional apps show lists or ratings. CHOICE combines context, human signals and AI to create a fluid, expressive interface:

> The city is alive — CHOICE surfaces what matters now.

Users can see what’s happening, explore intelligently, ask the AI for personalised suggestions, and navigate places with context.  
Producers can manage their presence, publish updates, and reach people in a fair and transparent way.

---

## Project structure

```
lib/
 ├─ screens/
 │   ├─ customer/
 │   │   ├─ maps/                 # Map & Location, geolocation, filters, bottom sheets
 │   │   ├─ explore/              # Category browsing, listings, discovery
 │   │   ├─ restaurant/           # Restaurant details, menus, ambiance
 │   │   ├─ wellness/             # Wellness places and details
 │   │   ├─ leisure/              # Events, activities, outings
 │   │   ├─ ai_copilot/           # AI conversational assistant
 │   │   ├─ chat/                 # Messaging (1-on-1, group chats)
 │   │   └─ profile/              # User profile & settings
 │   │
 │   ├─ producers/                # Producer dashboard, place management, analytics
 │   └─ auth/                     # Login, signup, session flow
 │
 ├─ models/                       # Dart data models (User, Place, Event, Producer…)
 ├─ services/                     # API calls, data fetching, storage, geolocation
 ├─ widgets/                      # Reusable UI components
 ├─ theme/                        # Colors, typography, spacing
 ├─ utils/                        # Utility helpers
 └─ main.dart                     # Application entrypoint
```

The architecture is intentionally clean, scalable, and aligned with the product roadmap.

---

## Key features

### 🗺️ Map & Location  

The map is the primary entry point of the experience:

- real-time place markers  
- category filters:
  - Friends  
  - Restaurants  
  - Wellness  
  - Leisure  
  - Events  
- bottom sheets anchored to map position  
- card carousel linked to location  
- contextual transitions to details  

Upcoming:
- city heatmaps (activity, trends, popularity)
- AI-filtered map views

---

### 🔍 Explore & Search

Structured exploration through:

- lists by category  
- “near you” and “recommended for you” collections  
- keyword search  
- tag-based filtering  
- upcoming: AI-powered search refinement  

---

### 📄 Place & Event Details

Each place has a rich, structured profile:

- photos  
- ambiance & tags  
- opening hours  
- price indicators  
- detailed attributes  
- friend presence  
- events linked to the venue  
- contextual actions (“Navigate”, “Book”, “Share”, etc.)

---

### 🤖 AI Copilot

The conversational interface to CHOICE:

- understands natural-language prompts  
- filters results by mood, budget, distance, group size  
- links answers directly to:
  - map
  - lists
  - details  
- supports multi-choice suggestions  
- future: multi-step planning & coordinated outings  

---

### 💬 Social Interactions

CHOICE integrates lightweight but meaningful social signals:

- posts related to places  
- reactions  
- comments  
- attendance indicators  
- shareable experiences  
- optional messaging  

---

### 🏪 Producer Space

For local businesses:

- producer login  
- place profile management  
- publish posts / events / updates  
- see visibility metrics (views, saves, interactions)  
- subscription tiers (planned)  
- mobile-first design of the dashboard  

---

### 🔐 Auth & Profile

- login / signup  
- user preferences  
- profile details  
- notifications  
- session persistence  

---

## Backend connection

The frontend communicates with the backend through:

- REST endpoints  
- JSON models shared across the stack  
- user/producer authentication tokens  
- controlled error and state handling  

Backend responsibilities:

- business logic  
- place & event data  
- social interactions  
- AI inference (OpenAI / Mistral / Claude)  
- producer management  
- storage (MongoDB)

The frontend is intentionally minimal in logic:  
**it surfaces what the backend decides and what the user needs.**

---

## Project status

CHOICE is under active development:

- core navigation and screens are implemented  
- AI copilot is functional and expanding  
- producer mode is partially built  
- social and messaging foundations exist  
- UI/UX refinements are ongoing  
- advanced AI and real-time features are planned  

A stable backbone is now in place for rapid iteration.

---

## Local development

```bash
git clone https://github.com/RemiBp/frontend_jinnbyte
cd frontend_jinnbyte
flutter pub get
flutter run
```

Requirements:

- Flutter installed  
- backend running locally or remotely  
- correct API base URLs  

---

## Contributing

The codebase follows simple principles:

- clear folder structure  
- predictable state management  
- minimal side-effects  
- reusable and readable components  
- separation between customer and producer domains  

Pull requests should respect this architecture.

---

## Vision

CHOICE is not another map, not another social feed, and not another directory.  
It is an attempt to build **a living interface on top of cities**:

- more intelligent (AI),  
- more human (friends, social signals),  
- more fair (producer empowerment),  
- and more immediate (map-first, context-first).

This repository is where that interface comes to life.
