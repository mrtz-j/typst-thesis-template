#import "modules/metadata.typ": *
#import "proposal_template.typ": *

#show: project.with(
  title: title,
  subtitle: subtitle,
  degree: degree,
  program: program,
  author: author,
  advisor: advisor,
  submissionDate: submissionDate,
)

#set heading(numbering: none)
#align(center, heading("Fault-Tolerant Distributed Declerative Programs"))
#v(1em)
#align(center, text(14pt, "INF-3981 Master thesis for Moritz Jörg"))
#align(center, text(14pt, "Advisor: Weihai Yu"))

#set heading(numbering: "1")
= Introduction

We generate and consume data all over our computing devices, which can be online
or offline at times. Ideally, the data are stored on the most appropriate
devices and we are able to access the data even when the devices are offline.

Data is typically managed by a database management system and accessed through
programs in a data manipulation and query language. SQL and Datalog are examples
of declarative data manipulation and query languages.

The systems that process the data should have high availability and low latency
in the face of in the face of server and network failures. With the ability to
recover without the running system to ensure minimal loss of performance and
correctness. and accuracy.

= Problem definition

// TODO: Remove this block
// #rect(
//   width: 100%,
//   radius: 10%,
//   stroke: 0.5pt,
//   fill: yellow,
// )[
//   *Problem definition*

//   - What is/are the problem(s)?
//   - Identify the actors and use these to describe how the problem negatively
//   influences them.
//   - Do not present solutions or alternatives yet!
//   - Present the negative consequences in detail
// ]

We are currently designing PRAD @QayyumY-sac2022, an extension to Datalog, where
we can turn a normal Datalog program into a distributed one, such that the data
can be partitioned and replicated at specified devices. The data are always
accessible at the specified devices, even when they are offline. The programs
are eventually consistent. That is, when the devices are connected, the results
that the distributed program generates, will eventually be equivalent to the
ones that a normal non-distributed program does.

One of the key design goals of PRAD is fault tolerance through replication. When
a replica is down, a PRAD program can continue to run, but the replication
degree decreases and so does the number of site-crashes the program can
tolerate.

= Methodology

// TODO: Remove this block
// #rect(width: 100%, radius: 10%, stroke: 0.5pt, fill: yellow)[
//   *Methodology*

//   - Introduce the reader to the general setting
//   - What is the environment?
//   - What are the tools in use?
// ]

In the thesis we will be applying the Software engineering principles and
practices, which form the backbone of any robust development process. Focusing
on efficiency, maintainability, and reliability throughout the software
lifecycle. The semester will be diveded into sprints, each containing certain milestones as
shown in @schedule.

// = Motivation

// TODO: Remove this block
// #rect(
//   width: 100%,
//   radius: 10%,
//   stroke: 0.5pt,
//   fill: yellow,
// )[
//   *Thesis Motivation*

//   - Outline why it is important to solve the problem
//   - Again use the actors to present your solution, but don't be to specific
//   - Be visionary!
//   - If applicable, motivate with existing research, previous work
// ]
// #pagebreak(weak: true)

= Objective

// TODO: Remove this block
// #rect(width: 100%, radius: 10%, stroke: 0.5pt, fill: yellow)[
//   *Thesis Objective*

//   - What are the main goals of your thesis?
// ]

In this Master thesis, Jörg will work on repairing PRAD programs at runtime to
maintain the fault-tolerance degrees.

= Schedule <schedule>

// TODO: Remove this block
// #rect(
//   width: 100%,
//   radius: 10%,
//   stroke: 0.5pt,
//   fill: yellow,
// )[
//   *Thesis Schedule*

//   - When will the thesis Start (Always 15th of Month)
//   - Create a rough plan for your thesis (separate the time in sprints with a length
//   of 2-4 Weeks)
//   - Each sprint should contain several work items - Again keep it high-level and
//   make to keep your plan realistic
//   - Make sure the work-items are measurable and deliverable
//   - No writing related tasks! (e.g. ”Write Analysis Chapter”)
// ]

The following schedule roughly outlines the work items for the thesis. It will
start on January 8th, 2024 and last for 6 months, until June 3th 2024.

#v(1em)

- *January 2024*: Initial design and implementation.
- *February 2024*: Implementation and testing.
- *March 2024*: Evaluation and refinement.
- *April 2024*: Evaluation and reporting.
- *May 2024*: Finalzing and reporting.
