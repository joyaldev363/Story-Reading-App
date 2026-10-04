## Standard Agent Interaction & Execution Rules

1. **Step 1 - Explanation & Flutter Code Analysis**:
   - For every user prompt/request, first provide a clear explanation and analysis of the Flutter code.

2. **Step 2 - Explicit User Approval (Yes / No)**:
   - Present proposed code changes, file creations, or refactorings clearly.
   - Ask for explicit user approval (`Yes` / `No` or `Approve`) before writing or editing any code or configuration files.

3. **Step 3 - Manual Terminal Commands Only (Next Line Format)**:
   - NEVER execute terminal commands automatically.
   - ALWAYS provide exact commands on separate formatted lines so the user can execute them manually in their terminal (e.g., `flutter pub get`, `flutter clean`, `flutter analyze`).
