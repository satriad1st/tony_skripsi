## Setup
Our setup will be pretty simple. If you're already familiar with NodeJS, go ahead and setup your project and include Express, Request and Cheerio as your dependencies.

Begin by downloading the repo and npm install

With that setup, let's take a look at what we'll be creating. In this tutorial, we will make a single request to IMDB and get:

* name of a movie
* release year
* IMDB community rating

Once we compile this information, we will save it to a JSON file on our computer. Please see the code examples below for our setup. For this tutorial we will not have a front-end user interface and will rely on our command window to guide us.


## Our Application
Our web scraper is going to be very minimalistic. The basic flow will be as follows:

* Launch web server
* Visit a URL on our server that activates the web scraper
* The scraper will make a request to the website we want to scrape
* The request will capture the HTML of the website and pass it along to our server
* We will traverse the DOM and extract the information we want
* Next, we will format the extracted data into a format we need
* Finally, we will save this formatted data into a JSON file on our machine

## Formatting and Extracting
Now that we have the data extracted, let's format it and save it to our project folder. We have been storing our extracted data to a variable called json. Let's save the data in this variable to our project folder. You'll notice earlier that we required the fs library. If you didn't know what this was for, this library gives us access to our computer's file system. Take a look at the code below to see how we write files to the file system.

With this code in place you are set to scrape and save the scraped data. Let's start up our node server, navigate to http://localhost:8081/scrape and see what happens.

* If everything went smoothly your browser should display a message telling you to check your command prompt.
* When you check your command prompt you should see a message saying that your file was successfully written and that you should check your project folder.
* Once you get to your project folder you should see a new file created called output.json.
* Opening this file, will give you a nicely formatted JSON document that will have the extracted data.
