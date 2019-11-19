# Welcome!

We're so glad you're thinking about contributing to a [open source project of the U.S. government](https://code.gov/)! If you're unsure about anything, just ask -- or submit the issue or pull request anyway. The worst that can happen is you'll be politely asked to change something. We love all friendly contributions.

We encourage you to read this project's CONTRIBUTING policy (you are here), its [LICENSE](LICENSE.md), and its [README](README.md).

## Policies

We want to ensure a welcoming environment for all of our projects. Our staff follow the [TTS Code of Conduct](https://18f.gsa.gov/code-of-conduct/) and all contributors should do the same.

We adhere to the [18F Open Source Policy](https://github.com/18f/open-source-policy). If you have any questions, just [shoot us an email](mailto:18f@gsa.gov).

## Public domain

This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0 dedication. By submitting a pull request or issue, you are agreeing to comply with this waiver of copyright interest.


## Team principles


### Release Engineering

Data.gov follows the four principles of modern [Release
Engineering](https://en.wikipedia.org/wiki/Release_engineering):

* **Identifiability** Being able to identify all of the source, tools,
  environment, and other components that make up a particular release.
* **Reproducibility** The ability to integrate source, third party components,
  data, and deployment externals of a software system in order to guarantee
  operational stability.
* **Consistency** The mission to provide a stable framework for development,
  deployment, audit, and accountability for software components.
* **Agility** The ongoing research into what are the repercussions of modern
  software engineering practices on the productivity in the software cycle, i.e.
  continuous integration.


### Application development

Additionally, Data.gov is made up of several applications. We strive to maintain
independence of these applications from the underlying Platform.

- Applications follow the [Twelve-Factor Methodology](https://12factor.net).
- The Platform exposes services to applications.
- Deployment of each Application is independent from the deployment of the Platform.


## Sprint rituals

We follow two week sprints with the following rituals.

- Biweekly standup (Alternate Mondays and every Thursday)
- Sprint planning (first Monday of the sprint)
- Sprint review (end of the sprint)
- Sprint retrospective (once every two sprints)


## Story lifecycle

**Stories** represent tactical increments of individually-valuable work
deliverable by the team within a single iteration... often an isolated change in
functionality aimed at achieving a goal for a particular kind of stakeholder,
whether customer, user, or operator/admin. Stories are tracked on the [Kanban
Board](https://app.zenhub.com/workspaces/datagov-multi-tenant-ckan-5cf12b601437ff1e943f0aa2/board?repos=153296282)
and progress through these columns.

- New issues
- Icebox
- Backlog
- Needs spec
- Upcoming sprint
- Current sprint
- Blocked
- In progress
- QA
- Closed


### Definition of "Done"

An agile "Definition of Done" (DoD) captures the team's agreed-upon standards
for how we get work done at a consistent level of quality. Having a DoD ensures
that non-functional requirements (NFRs) don't have to be re-litigated for every
piece of work taken on, cards can be focused on just the relevant details, and
new team members aren't surprised by assumed expectations of their colleagues.

At our sprint reviews, we demo work that has reached the "Done" column and is of
interest to our users or teammates.


#### Column exit criteria

Our DoD is broken up into a set of statements that should be true
for each card before it moves to the next column on the board.

Before advancing a card from one column to the next on the board, it should meet
the "exit criteria" for the current column, which are listed below.


### Columns


#### New issues

New issues that need to be triaged.


##### Exit criteria

- Relevant points from any discussion in the comments is captured in the initial
  post.
- Decision is made to move to the Backlog or Icebox columns, or close.


#### Icebox

Work that has been de-prioritized.


##### Exit criteria

- When reviewing priorities, we may pull items out of the Icebox.
- Items move to Product backlog for grooming.


#### Backlog

Work that we are planning on doing but haven't groomed or scheduled.


##### Exit criteria

- Indicate the intended benefit and who the story is for in the "as a ..., I want
  ..., so that ..." form.


#### Needs spec

Work that needs grooming before we can schedule it.


##### Exit criteria

- Acceptance criteria is defined.
- If necessary, the story includes a security testing plan and any tasks from
  that plan are included as acceptance criteria.
- Level of effort has been estimated and set in terms of story points.


#### Upcoming sprint

Work we are queuing up for the next sprint. Work in this column should be
well-defined and ready to begin work.


#### Exit criteria

- During sprint planning, work is reviewed with the team and any questions or
  clarifications are made.
- No info or assistance is needed from outside the team to start work and likely
  finish it.


#### Current sprint

Work that we are planning for the current sprint, waiting for a team member to
pick it up.


##### Exit criteria

- There's capacity available to work on the story (e.g., this column is a buffer
  of shovel-ready work).


#### Blocked

Work that has been started but is blocked by an external party and needs
occasional nudging to get it unblocked.


##### Exit criteria

- Third-party blocker has been removed, the story can move to Sprint backlog or
  In progress.


#### In progress (WIP limit: 2/person)

Work that is currently in progress.


##### Exit criteria

- Acceptance criteria are demonstrably met.
- Relevant tasks complete, irrelevant checklists removed or captured on a new
  story.
- Follows documented coding conventions.
- Automated tests have been added and are included in Continuous Integration.
- Pair-programmed or peer-reviewed (e.g., use pull-requests).
- Test coverage exists and overall coverage hasn't been reduced.
- User-facing and internal operation docs have been updated.
- Demoable to other people in their own time (e.g. user acceptance testing (UAT)
  environment, published branch).
- Any deployment is repeatable (e.g., at least documented to increase bus factor
  beyond one) and if possible automated via CI/CD.
- If the deployment is difficult to automate, then a story for making it automated is created at the top of New Issues.
- The deployment must follow our Configuration Management plan. If not possible,
  contact the Program Management team to modify the story or discuss how to
  update the Configuration Management plan.


#### QA

Work is ready for QA.

##### Exit criteria

- Reviewer asserts the Acceptance Criteria
- Any issues or questions are raised and discussed. If low effort can be done to
  resolve, the story should move to In Progress or Current Sprint. Otherwise,
  additional issues are created in New.


#### Closed

Task has been applied to production and is considered done and should be
reviewed with the team as part of the Sprint Review.


##### Exit criteria

- The work is user-visible and announceable at any time.
- The work has been demoed at the Sprint Review.
- GitHub issue is marked Closed.
