## CircleCI Setup
### Troubleshooting
- the default workflow expects a job named `build` though I could not find that in the documentation.
  - to include multiple jobs or name the default job something else, need to add a `workflows` section where you specify the jobs below where you defined all the jobs. 
- each job in workflow starts out with a brand new workspace from scratch unless you add the `persist_to_workspace` step to the job and `attach_workspace` to the next job

### Adding a Status Badge
Follow CircleCI's (instructions)[https://circleci.com/docs/2.0/status-badges/]. Note, you'll have to create a new API token in CirleCI scoped to 'status' in CircleCI if it's a private GitHub repository.
