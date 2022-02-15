// Agent sample_agent in project helloworld

/* Initial beliefs and rules */

sell(apple).

/* Initial goals */

!start.

/* Plans */

+!start
   <- .print("hello world.");
      .df_subscribe(iamhere);
      .df_subscribe(sell(apple));
      .print("subscribed").

+!buy
   <- .df_search(sell(orange),L);
      .print("orange sellers ", L);
      for (.member(A,L)) {
          .send(A,askOne,price(orange,_),price(_,P),2000);
          //.print("Price of ",A," is ",P);
          .printf("%20s = %5.2f",A,P);
      }
   .

+provider(marcos,"iamhere")
   <- .send(marcos, tell, hi);
      .broadcast(tell,hello);
      !buy;
   .

+provider(A,S) <- .print(A, " is provider of ",S).

+hello[source(A)] <- .print("I received hello from ",A).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
