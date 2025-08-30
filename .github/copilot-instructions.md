git# AI Coding Agent Instructions - User Stories Helper

## Architecture Overview
This is a **single-page application (SPA)** built as an MVP for user story creation and validation. The entire application lives in `index.html` using a vanilla HTML + CDN approach with no build process.

**Tech Stack:**
- **Alpine.js 3.x** - Reactive component framework via CDN
- **Tailwind CSS** - Utility-first CSS via CDN with custom config
- **Flowbite 3.1.2** - Component library for consistent UI patterns
- **Inter font** - Typography loaded from Google Fonts

## Core Application Patterns

### Alpine.js Component Structure
The main Alpine component is registered as `Alpine.data('app', ...)` and contains:
- **Data model**: `story` object with persona/action/benefit structure following user story format
- **State management**: `checks` object for INVEST criteria validation
- **Persistence**: Auto-save to localStorage on input changes via `@input="saveLocal()"`
- **Reactivity**: All UI updates through x-model bindings and computed properties

Key methods to understand:
- `userStoryLine()` - Generates the "Como X, eu quero Y para Z" format
- `generateHappyPath()` - Auto-creates Gherkin scenarios from story data
- `gherkinBlock()` - Formats acceptance criteria as Gherkin syntax

### Dark Mode Implementation (Critical)
**Two-phase initialization** to prevent FOUC:
1. **Inline script** (before Alpine) - Immediately applies dark mode class
2. **Alpine initialization** - Syncs with the pre-applied state

```javascript
// Phase 1: Immediate application
window.__darkModeState = isDark;
document.documentElement.classList.add('dark');

// Phase 2: Alpine sync
isDarkMode: window.__darkModeState || false
```

### State Persistence Strategy
- **Auto-save**: All form inputs trigger `saveLocal()` via `@input` directive
- **Storage key**: `'user-stories-helper-v1'` for main data, `'user-stories-dark-mode'` for theme
- **Error handling**: Try-catch around localStorage operations with user notifications

## Development Workflow

### Local Development
```bash
make serve    # Starts Python server on localhost:3000
```
**Important**: Use `make serve` not direct Python commands - the Makefile sets correct binding.

### Styling Conventions
- **Flowbite-first**: Use Flowbite components before custom CSS
- **Card structure**: `max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700 w-full max-w-none`
- **Form inputs**: Standard Flowbite classes with proper dark mode variants

### Script Loading Order (Critical)
```html
1. Dark mode inline script (immediate)
2. Tailwind config with Flowbite integration  
3. Alpine.js component registration
4. Flowbite JavaScript initialization
5. Alpine.js framework load (deferred)
```

## Domain-Specific Patterns

### User Story Validation
- **INVEST criteria**: Interactive checklist with popover explanations
- **Ambiguity linting**: Scans for vague terms like "rápido", "eficiente" with specific suggestions
- **Gherkin scenarios**: Given/When/Then structure with color-coded inputs

### Content Generation
- **Auto-title**: Generates from action + benefit if title is empty
- **Happy path**: Creates basic scenario from story components
- **Markdown export**: Structured format with metadata and Gherkin blocks

## File Structure & Key Locations
- `index.html` - Entire application (912 lines)
- `Makefile` - Simple development server commands
- Flowbite components documentation: https://flowbite.com/docs/

## Common Tasks
- **Add new form fields**: Follow Flowbite input patterns with proper IDs and dark mode classes
- **Modify validation**: Update `ambiguousTerms` array and `suggestionFor()` mapping
- **UI components**: Use Flowbite card/button/input patterns consistently
- **State changes**: Always call `saveLocal()` for persistence

## Critical Dependencies
- CDN reliability: All external resources are CDN-hosted
- localStorage availability: App gracefully degrades if storage fails
- Modern browser APIs: Uses `crypto.randomUUID()` with fallback for older browsers
