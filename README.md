# Building in Layers

We want to build our software in layers. Remember the sentence:

> Do Fun Things with Big Loud Wildebeests

The layers are: 

- Data (do). The modules with the corresponding structs. Our core files are in in `lib/game` 
- *Functional Core (fun). A functional core.*
- Tests (things). We run as many tests as possible in the functional core. 
- Boundaries (big). All process machinery, including OTP and tainted user input, are in the boundaries. Our boundaries will go in `lib/master_web/game_live.ex`. 
- Lifecycle (loud). Liveview will manage all OTP and lifecycle for us.
- Workers (wildebeests). Database repos, workers, or other processes our application might need. We won't need workers. 

# Universe for Labs 2 and 3 

Here's your lab 2 universe. 

## Both Labs

Both labs can make use of these techniques. 

### Creating New Structs

When you're working with structs, you'd create a new one like this: 

```elixir
  %Game{
    field: "value"
  }
```

But if you're actually working in the `Game` module, it's better to refer to the module using a special reserved word: `__MODULE__`. So if you're creating a function to return a new struct, your code would look like this: 

```elixir
def new() do
  %__MODULE__{
    field: "value"
  }
end
```

See https://hexdocs.pm/elixir/Kernel.SpecialForms.html for details. (I googled Elixir __MODULE__)


# Lab 2: Computing Scores

When you're computing scores for your mastermind game, you'll work with three data structures. 

- The `answer` is the actual correct code. 
- The `guess` is a user's attempt to guess the correct code. 
- The `score`  (see below)

## Lab 2: Computing the Score

In this lab, you'll compute the score of a turn. A score is the number of reds and whites. A red is the correct number (or peg) in the correct location; a white peg is a correct number in the wrong location; a miss is an incorrect location. Each number from the guess will be either a red, a white, or nothing. It can't be more than one. 

## List Subtraction

In the game, you'll find it useful to subtract one list from another. For example: 


```elixir
  [1, 2, 3, 4] -- [1, 2]
  -> [3, 4]
```

And: 

```elixir
  [1, 1, 1, 2] -- [1, 2]
  -> [1, 1]
```


You can use this list subtraction to find the number of misses in your lab. 

### Enum Functions

These are a few Enum functions that will help you. 

- `Enum.filter(list, fn)` will return all items of the list that return true for fn. For example, `Enum.filter([1, 2, 3], Integer.is_even/1)` would return `[2]`.
- Enum.zip(list1, list2) will make a list of tuples from the first elements, second elements, etc. So `Enum.zip([1, 2, 3], [:a, :b, :c])` would give you [{1, :a}, {2, :b}, {3, :c}]
- `Enum.count(list)` counts the elements in `list`. `length` does the same thing.
- `Enum.count(list, filter_fn/1)` counts the elements in `list` that returns true for the function.
- `length(list)` returns the length of a list. 

Find more at https://hexdocs.pm/elixir/Enum.html (I googled for Elixir Enum)

### Pattern Matching Function Heads

Optional function arguments look like 

```
def function(optional \\ :default) do
  optional
end
```

For that code, calling `optional()` returns `:default` but calling `optional(:provided)` returns `:provided`.


Functions with a different number of arguments are different. Arguments that begin with an underscore are ignored. 

If you have two functions with the same number of arguments, look at the function head. Elixir will take the first function head that matches the structure. 

For example, you might have this function: 

```elixir
def blank?(nil) do
  true
end

def blank?("") do
  true
end

def blank?(_other) do
  false
end
```

You can write a function that matches a pattern in your function head. For example, you'll need to write a function to determine if two elements of a tuple match. Here's a function that converts a two-tuple to a list: 

```elixir
def convert({x, y}) do
  [x, y]
end
```


You can use a similar technique to determine if two elements match. 

### Binding Variables, and Testing For Equality

Use `==` to test for equality. 

Use `=` to bind the variables on the left to the statement on the right. A couple of examples: 

```elixir
magic_number = 42
{x, y} = point
%Person{first_name: first_name} = %Person{first_name: "José", last_name: "Valim"}
```


# Lab 3: Advancing the Game

## Working With the Game 

These techniques will help with Lab 3.

### Functions

Define an Elixir fuction like this: 

```elixir
defmodule Score do
  def compute_score(arg1, arg2) do
    
  end
end
``` 

You can make the function private with `defp` like this: 

```elixir
  ...
  
  def compute_score(arg1, arg2) do
    help_compute_score()
  end
  
  defp help_compute_score() do
  end
  ...
end
``` 

You can make an argument optional like this: 

```elixir
  def def say( something \\ "hi") do
    IO.puts something
  end
end
``` 

### Enum Functions

These are a few Enum functions that will help you. 

- `Enum.take(list, n)` will take the first n elements of a list
- `Enum.sort(list)` will sort a list
- `Enum.shuffle(list)` will sort the list in a random order
- `Enum.map(list, fn)` will collect the results of calling fn(item) for every item in the list.



Find more at https://hexdocs.pm/elixir/Enum.html (I googled for Elixir Enum)

### Ranges

Often in the mastermind game you might want a shorthand for all the possible guesses, and that's a list of numbers from 1-6. You can do that with a range `(1..6)`

### Pipes

In Elixir, you can string functions together when you're transforming from one form to the next. 

So if you're starting with a list and you want to sort them and look at the first five, you'd do this: 

```elixir
  list
  |> Enum.sort
  |> Enum.take(4)
```

## Making a List of Random Numbers (includes spoilers)

You will want to combine some of the functions above in a pipe. I recommend using shuffle rather than building a list of 6 distinct random numbers, but both approaches work. 

One way to solve the problem is to make a list of numbers from 1-6, shuffle them, and take four. 

