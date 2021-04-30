# Rails Routing Basics

## Learning Goals

- Understand the flow of data in a Rails app
- Map routes to controller actions
- Generate a controller
- Send JSON data as a response

## Setup

Fork and clone this repo, then run:

```sh
bundle install
rails db:migrate db:seed
```

This will download all the dependencies for our app and set up the database.

## Routing

How does your application know what code to run when it receives a request? This
is where routing comes in.

Before we dive into the code and routing configurations, it helps to know how
HTTP works at a high level. Below is the flow that takes place when a user
attempts to go to a page on a Rails application:

1. A client sends a request to the server (this could be: a user entering a URL
   in a browser; a JavaScript application using `fetch`; etc)
2. That request is sent to the server where the application's router interprets
   the request and sends a message to the controller mapped to that route
3. The controller communicates uses the model to access data from the database
4. The controller then uses that data to render a view (HTML or JSON)
5. The server returns a HTTP response, which contains the HTML or JSON data

## Creating a Route

Let's try this out in our application. We'll continue using our Cheese Shop app
as an example. Our goal will be to create an endpoint for our application that
will return a list of all our cheeses as JSON data.

To begin, start up the Rails server with `rails s` and go to
[`http://localhost:3000/cheeses`](http://localhost:3000/cheeses). As you will
see, this throws a routing error: `No route matches [GET] "/cheeses"`. To fix
this, we'll need to add a route.

Start by opening the `config/routes.rb` file and adding the following route
inside of the `draw` block:

```rb
get 'cheeses', to: 'cheeses#index'
```

Let's look at the components that make up this route code:

- **HTTP verb**: in this case we're using the `get` HTTP verb.
- **Path**: `'cheeses'` represents the path in the URL bar that the route will be
  mapped to.
- **Controller Action**: `'cheeses#index'` tells the Rails routing system that
  this route should be passed through the `CheesesController`'s `index` action.
  If the term `action` sounds foreign, actions are just Rails-speak for an
  instance method in a controller. So in the `CheesesController` will be a method
  called `index` that gets called when a user goes to `/cheeses`.

Now go back to
[`http://localhost:3000/cheeses`](http://localhost:3000/cheeses), and refresh
the page. You should now see that the error message has changed. It's no longer
complaining about not having a route; it should now say:
`uninitialized constant CheesesController`.

Let's fix this by creating a new controller for our cheeses. You can generate a controller using a Rails generator, just like with a model:

```sh
rails g controller Cheeses
```

Notice the naming convention we're following: for a `Cheese` model, we need a
`Cheeses` controller. **Model names are always singular, and controller names
are plural**. These conventions are important to keep in mind!

This will create a blank controller file `/app/controllers/cheese_controller.rb`
that we can use to map to the routing file. Since there are a number of methods
built into the Rails controller system, you will also want the controller to
inherit from the application controller. The new file should have code that
looks like this:

```rb
class CheesesController < ApplicationController
end
```

The standard naming convention for controllers is the name of the controller followed by the word `Controller`.

If you refresh the browser now, you will see a new error:
`The action 'index' could not be found for CheesesController`. This means that
it found our controller (woot!) but couldn't find the action `index` in that
controller (womp womp).

We're making good progress (even though we're using EDD - error driven
development), and it's good to see each of the errors so that when you encounter
these in your real world projects you will know how to fix them. This current
error is fixed by adding the following method in the `CheesesController`:

```rb
def index
end
```

In this method, our goal is to send back a list of all our cheeses as JSON data.
To help accomplish our goal, let's do a bit of debugging in our controller action
using `byebug`:

```rb
def index
  byebug
end
```

> If you haven't encountered `byebug` before, it's a way to add _breakpoints_ to
> our Rails code so we can _pause the execution of our code_ and experiment. It
> functions similarly to `binding.pry`.

Visit [`http://localhost:3000/cheeses`](http://localhost:3000/cheeses) in the
browser again, and check your terminal: you should be in the `byebug` session now!
That means you can run any code that you'd be able to add inside this method, and
see what you have access.

From your `byebug` session, run:

```rb
cheeses = Cheese.all
```

This will create a new `cheeses` variable with all the cheese data from the database!

To see how to return a response with this cheese data, you can also run:

```rb
render json: cheeses
```

Now that we've seen how that code will run in `byebug`, let's add it to the
controller action:

```rb
def index
  cheeses = Cheese.all
  render json: cheeses
end
```

Visit [`http://localhost:3000/cheeses`](http://localhost:3000/cheeses) in the
browser one more time. Now you should see the JSON data being returned!

Try experimenting by adding more routes and controller actions, and see what
other responses you can set up by changing how you are accessing data from the
database (like using the `.order` or `.limit` methods from Active Record).

## Summary

In summary, you should now have a firm understanding of how to implement basic routing in your application for static pages. As a review, the process is below:

1. The server receives an HTTP request from the client
2. The application processes the request through the `routes.rb` file
3. The route file maps the request through whichever controller method is called
4. The controller then uses the model to access data from the database, and
   sends that data back in the response

## Resources

- [link 1](example.com)
- [link 2](example.com)
