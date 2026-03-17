// Server.java
//
// Use this sample code to handle webhook events in your integration.
//
// Using Maven:
// 1) Paste this code into a new file (src/main/java/com/stripe/sample/Server.java)
//
// 2) Create a pom.xml file. You can quickly copy one from an official Stripe Sample.
//   curl https://raw.githubusercontent.com/stripe-samples/accept-a-payment/8e94e50e68072c344f12b02f65a6240e1c656d4a/custom-payment-flow/server/java/pom.xml -o pom.xml
//
// 3) Build and run the server on http://localhost:4242
//   mvn compile
//   mvn exec:java -Dexec.mainClass=com.stripe.sample.Server

package com.stripe.sample;

import static spark.Spark.post;
import static spark.Spark.port;
import com.google.gson.JsonSyntaxException;
import com.stripe.Stripe;
import com.stripe.exception.SignatureVerificationException;
import com.stripe.model.*;
import com.stripe.net.Webhook;

public class Server {
    public static void main(String[] args) {
        
        // This is your Stripe CLI webhook secret for testing your endpoint locally.
        String endpointSecret = "whsec_2b507287dab5d622f2b6e039e1f33e872c4f314d84103286d16d4eb587798790";

        port(4242);

        post("/webhook", (request, response) -> {
            String payload = request.body();
            String sigHeader = request.headers("Stripe-Signature");
            Event event = null;

            try {
                event = Webhook.constructEvent(
                    payload, sigHeader, endpointSecret
                );
            } catch (JsonSyntaxException e) {
                // Invalid payload
                response.status(400);
                return "";
            } catch (SignatureVerificationException e) {
                // Invalid signature
                response.status(400);
                return "";
            }

            // Deserialize the nested object inside the event
            EventDataObjectDeserializer dataObjectDeserializer = event.getDataObjectDeserializer();
            StripeObject stripeObject = null;
            if (dataObjectDeserializer.getObject().isPresent()) {
                stripeObject = dataObjectDeserializer.getObject().get();
            } else {
                // Deserialization failed, probably due to an API version mismatch.
                // Refer to the Javadoc documentation on `EventDataObjectDeserializer` for
                // instructions on how to handle this case, or return an error here.
            }
            // Handle the event
            switch (event.getType()) {
              case "checkout.session.async_payment_failed": {
                // Then define and call a function to handle the event checkout.session.async_payment_failed
                break;
              }
              case "checkout.session.async_payment_succeeded": {
                // Then define and call a function to handle the event checkout.session.async_payment_succeeded
                break;
              }
              case "checkout.session.completed": {
                // Then define and call a function to handle the event checkout.session.completed
                break;
              }
              case "checkout.session.expired": {
                // Then define and call a function to handle the event checkout.session.expired
                break;
              }
              // ... handle other event types
              default:
                System.out.println("Unhandled event type: " + event.getType());
            }

            response.status(200);
            return "";
        });
    }
}