package com.example.helloworld;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;

@SpringBootApplication
//@JsonAutoDetect(fieldVisibility = Visibility.ANY)
public class HelloworldApplication {

  @Value("")
  String name;

  class Dashboard
  {
    int ID;
    String title;
    String description;


    public Dashboard(int id)
    {
      this.ID=id;
      this.title = "Title" + id;
      this.description= "Description" + id;

    }
    public int getID(){
      return ID;
    }
    public String getDescription() {
      return description;
    }
    public String getTitle() {
      return title;
    }
  }

  class Response {
    String response;
    List <Dashboard> results;

   Response(String response, List <Dashboard> results) {
    this.response=response;
    this.results=results;
   }

    public String getResponse() {
      return response;
    }
    public List <Dashboard> getResult() {
      return results;
    }
  }

  @RestController
  class HelloworldController {

    int count;
    public HelloworldController()
    {
      count=0;
    }

    @GetMapping("/")
    String hello() {
      return "Hello " + name + "!";
    }

    @GetMapping("/object")
    Dashboard getDashboard() {
      return new Dashboard(count++);
    }

    @GetMapping("/objects")
    Response getDashboards() {
      ArrayList <Dashboard> list=new ArrayList<>();

      for(int i=0;i<10;i++)
        list.add(new Dashboard(i));

      return new Response("Success", list);
    }

  }

  public static void main(String[] args) {
    SpringApplication.run(HelloworldApplication.class, args);
  }
}
