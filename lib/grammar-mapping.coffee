# Mapping between Atom grammar and Pygments languages.
# http://pygments.org/docs/lexers/
# Interresting syntax comparisons: https://en.wikipedia.org/wiki/Comment_(computer_programming)

module.exports =
  "Babel ES6 JavaScript": "JavaScript"
  "CMake Listfile": "CMake"
  "CoffeeScript (Literate)": "CoffeeScript"
  "EEx": "Elixir"
  "Git Commit Message": null
  "Git Config": null
  "Git Rebase Message": null
  "HTML (EEx)": "HTML"
  "HTML (Mustache)": "Mustache"
  "HTML (Rails)": "HTML"
  "HTML (Ruby - ERB)": "HTML"
  "Hyperlink": null
  "JavaScript (Rails)": "JavaScript"
  "JavaServer Pages": null
  "Java Properties": null
  "JUnit Test Report": "XML"
  "Property List (XML)": "XML"
  "Regular Expressions (JavaScript)": "JavaScript"
  "Regular Expressions (Python)": null
  "Ruby Haml": "HAML"
  "Ruby on Rails": "Ruby"
  "Ruby on Rails (RJS)": "Ruby"
  "Shell Script": "Bash"
  "SQL (Rails)": "SQL"
  "Strings File": null

  # Known to not be in this version of pygments
  # Trying to use best equivalent
  "Elm": "Ada" # not atom native
  "Gemfile": "Ruby"
  "GitHub Markdown": null
  "Processing": "CPP" # not atom native
  "TypeScript": "JavaScript"
  "Unix Shell": "Bash" # not atom native
  "Cisco IOS" : "JAVA" # does not exist at all (atom and pyments)
