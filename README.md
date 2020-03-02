# Building in Layers

We want to build our software in layers. Remember the sentence:

> Do Fun Things with Big Loud Wildebeests

The layers are: 

- Data (do). The modules with the corresponding structs. Our core files are in in `lib/game` 
- Functional Core (fun). A functional core. 
- Tests (things). We run as many tests as possible in the functional core. 
- Boundaries (big). All process machinery, including OTP and tainted user input, are in the boundaries. Our boundaries will go in `lib/master_web/game_live.ex`. 
- Lifecycle (loud). Liveview will manage all OTP and lifecycle for us.
- Workers (wildebeests). Database repos, workers, or other processes our application might need. We won't need workers. 

# Using Elixir to Solve a Nontrivial Problem

In short, this lab is about deisign, and how to build software in chunks that are easy to deploy in units and build in pieces. We will use the same strategies in the upcoming book by James Gray and Bruce Tate, tentatively called Designing Elixir Systems with OTP. 

## The Sandbox

Rather than have you work with the entire Elixir language, we'll deal with a small portion at a time. Before each exercise, we'll let you see a list of functions you can use to solve the problem. We don't want to solve the problem for you, but we do want you to focus on using Elixir and your tools rather than playing "Where's Waldo" to find the magic function you need to solve an exercise. 

## The Problem

We will give you a single problem, but let you solve it in pieces. You'll start each lab with a working code base and you'll build on that code base to make tests pass, one at a time. 

## Turning Red Ligths Green

Our labs are test-driven. You will activate one test at a time, and run tests to make sure your program does what it should. This is a good way to learn, and it's a small step from learning to code in this way to writing your own tests and solving business problems. 

# Why do conference trainings?

This is a small cross section of our one day LiveView course. You'll see we just scratch the surface. 

# Build the data layer

We're going to start with the right data. You'll play the MasterMind game in class to understand the rules. We want to create a data layer that: 

- allows us to represent the intermediate state for a game
- gives us a place to collect functions for our module. 

MasterMind is a game with these rules. 

- The computer will make a secret code called an `answer`
- The humans will guess codes we'll call `guesses`
- The computer will provide hints based on guesses called `scores`
- The humans win if they guess the code in 10 tries. 

Try out the game [mastermind](https://www.webgamesonline.com/mastermind/). 

In the first lab, we'll create the data layer for the game `Board`, and for a single `Score`. 

## 1. Create a module called `Board`.  

The board should have:

- a four-digit `answer` we'll represent as a `String` with a default of `1234`
- a list of `guesses` with a default of `[]`. 

Along the way, we'll need a `score` for each guess. 

## 2. Create a module called `Score`. 

The score should have: 

- a count of red pegs called `reds`. 
- a count of white pegs called `whites`. 

Run your tests, making changes until they pass.

# Phoenix

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Run tests: 

  * mix test
  
Run IEx with game

  * iex -S mix