# Ruby Capstone Project - Ruby Linter
  
[![View Code](https://img.shields.io/badge/View%20-Code-green)]()
[![Github Issues](https://img.shields.io/badge/GitHub-Issues-orange)]()
[![GitHub Pull Requests](https://img.shields.io/badge/GitHub-Pull%20Requests-blue)]()

<br />
<p align="center">
  <a href="https://github.com/ldelbel/Ruby_capstone">
    <img src="images/microverse.png" alt="Logo" width="80" height="80">
  </a>

  <h2 align="center">Ruby Linter</h2>

  <h3 align="center">Capstone Project - Building my own Ruby Linter<h3>
  <p align="center">
    <a href="https://github.com/ldelbel/Ruby_capstone"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    -
    <a href="https://github.com/ldelbel/Ruby_capstone/issues">Report Bug</a>
    -
    <a href="https://github.com/ldelbel/Ruby_capstone/pulls">Request Feature</a>
    -
  </p>
</p>
    
## Content

<p align="center">
  <a href="#about">About</a> •
  <a href="#ins">Installing</a> •
  <a href="#testing">Testing</a> •
  <a href="#with">Built With</a> •
  <a href="#tested">Tested With</a> •
  <a href="#ldl">Live Demo</a> •
  <a href="#author">Author</a>
</p>

## About this Project <a name = "about"></a>

A Ruby Linters built on Ruby.

## This Ruby Linter includes the following actions

### Checks for trailing spaces

- Detects trailing spaces in the end of lines

#### good

```
  def developer|
    puts 'I drink coffee'|
  end|
```

#### bad

```
  def developer |
    puts 'I drink coffee' |
  end |
```

### Checks for indentation

- It detects wrong identation based on good practices

#### good

```
  class Dev
    def initialize(*args)
      @pref_stack = args[0]
      @experience = args[1]
    end
  end
```

#### bad

```
    class Dev
    def initialize(*args)
      @pref_stack = args[0]
      @experience = args[1]
     end
  end
```

### Check for multiple empty lines

- Checks for multiple empty lines in sequence and recommends to remove the exceeding 

#### good

```
  class Dev
    def initialize(*args)
      @pref_stack = args[0]
      @experience = args[1]
    end
  end

   def developer 
    puts 'I drink coffee' 
  end 
```

#### bad

```
    class Dev
    def initialize(*args)
      @pref_stack = args[0]
      @experience = args[1]
    end
  end



   def developer 
    puts 'I drink coffee' 
  end 
```

### Checks for closing end statements

- Checks for missing or exceeding end statements in the file

#### good

```
  class Dev
    def initialize(*args)
      @pref_stack = args[0]
      @experience = args[1]
    end
  end

   def developer 
    puts 'I drink coffee' 
  end 
```

#### bad

```
  class Dev
    def initialize(*args)
      @pref_stack = args[0]
      @experience = args[1]
    end
 
  def developer 
    puts 'I drink coffee' 
  end 
```


## 🔧 Built with<a name = "with"></a>

- Ruby 2.6.5

## 🔧 Tested with<a name = "tested"></a>
  
- RSpec 3.9

## 🔴 Live Demo <a name = "ldl"></a>

[![Run on Repl.it]()

## 🔨 Setup

- Fork the repo to your remote repository.
- Clone or download the repository to a local directory on your computer.

## 🛠 Installing <a name = "ins"></a>

- run npm install to install the dependencies for the project

To be able to test, do the following

- run bundle init to create a Gemfile
- add rspec gem in your Gemfile
- run bundle install to install the gems

## 🛠 Running the Linter on a Ruby File<a name = "ins"></a>

To run the Linter on a file, follow these steps:

- Go to Ruby_capstone/bin
 - run ruby main.rb <target_file.rb_path>

Remember to type the path relative to where main.rb is.

## 🛠 Testing <a name = "testing"></a>

- run bundle exec rspec

## ✒️  Author <a name = "author"></a>

👤 **Lucas Delbel**

- Github: [@ldelbel](https://github.com/ldelbel)
- Twitter: [@delbel_lucas](https://twitter.com/delbel_lucas)
- Linkedin: [lucasdelbel](https://www.linkedin.com/in/lucasdelbel/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/ldelbel/Ruby_capstone/issues).


## 👍 Show your support

Give a ⭐️ if you like this project!

## :clap: Acknowledgements

[BetterSpecs for RSpec good practices](http://www.betterspecs.org/br/#contexts)<br>
[RSpec Documentation Repo](https://github.com/rspec/rspec)

