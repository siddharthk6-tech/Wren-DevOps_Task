# Task 1 – Software Lifecycle Workflow

## 📄 Description
This task demonstrates a **Software Development Lifecycle (SDLC)** workflow covering key stages: **Ideate → Plan → Code → Build → Test → Deploy → Monitor**.

Two diagrams are provided:

- **Simple SDLC**: High-level overview of the lifecycle stages.
- **Detailed SDLC**: Includes branching strategies, CI/CD pipeline, artifact management, pre-production and production release gates, and monitoring.

The workflow illustrates typical DevOps practices including automated builds, quality checks, artifact storage, deployment pipelines, and feedback loops.

## Tools Used
- [Draw.io](https://app.diagrams.net) – for creating editable workflow diagrams.

## Output
- `Wren_K-software lifecycle.drawio.xml' – load directly in Draw.io to visualize the workflow.

## Key Steps in Diagram
1. Developer commits code to **Git/SVN**.
2. **CI pipeline** triggers build and unit testing.
3. Code quality analysis with tools like **SonarQube, Fortify, Coverity** etc.
4. Artifacts are stored in **artifact repositories** (e.g., Nexus).
5. Deployment triggered to **Test/Staging environments**.
6. **Integration and acceptance testing** performed.
7. Deploy to **Pre-Production and Production**.
8. **Monitoring and feedback** to improve future releases.
