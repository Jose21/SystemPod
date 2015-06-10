/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.app.ses;

/*
 * Copyright 2014-2014 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */
import com.amazonaws.AmazonClientException;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.simpleemail.AmazonSimpleEmailServiceClient;
import com.amazonaws.services.simpleemail.model.Body;
import com.amazonaws.services.simpleemail.model.Content;
import com.amazonaws.services.simpleemail.model.Destination;
import com.amazonaws.services.simpleemail.model.Message;
import com.amazonaws.services.simpleemail.model.SendEmailRequest;


public class AmazonSES {

    static final String FROM = "sgcon@nuuptech.com";  // Replace with your "From" address. This address must be verified.
    //static final String TO = "kokoro.miramar@gmail.com"; // Replace with a "To" address. If you have not yet requested
    // production access, this address must be verified.
    //static final String BODY = "This email was sent through Amazon SES by using the AWS SDK for Java.";
    //static final String SUBJECT = "Amazon SES test (AWS SDK for Java)";

    /*
     * Before running the code:
     *      Fill in your AWS access credentials in the provided credentials
     *      file template, and be sure to move the file to the default location
     *      (~/.aws/credentials) where the sample code will load the
     *      credentials from.
     *      https://console.aws.amazon.com/iam/home?#security_credential
     *
     * WANRNING:
     *      To avoid accidental leakage of your credentials, DO NOT keep
     *      the credentials file in your source directory.
     */
    public void sendMail(String TO, String USUARIO2, String SUBJECT, String CONTENIDO, String FOLIO, String USERCREATE, String NOMBRE) {

        // Construct an object to contain the recipient address.
        Destination destination = new Destination().withToAddresses(new String[]{TO});

        // Create the subject and body of the message.
        Content subject = new Content().withData(SUBJECT);

        Content htmlContent = new Content().withData(" <body bgcolor=\"#FFFFFF\">\n"
                + "    <!-- HEADER -->\n"
                + "        <table class=\"head-wrap\" bgcolor=\"red\">\n"
                + "            <tr>\n"
                + "                <td></td>\n"
                + "                <td class=\"header container\" >\n"
                + "                    <div class=\"content\">\n"
                + "                        <table bgcolor=\"red\">\n"
                + "                            <tr>\n"
                + "                                <td style=\"font-size: x-large; color:white;\">\n"
                + "                                    S G C o n\n"
                + "                                </td>\n"
                + "                                <td style=\"text-align: right; color:white; fon\">\n"
                + "                                    Notificaciones\n"
                + "                                </td>\n"
                + "                            </tr>\n"
                + "                        </table>\n"
                + "                    </div>\n"
                + "                </td>\n"
                + "                <td></td>\n"
                + "            </tr>\n"
                + "        </table><!-- /HEADER -->\n"
                + "        <!-- BODY -->\n"
                + "        <table class=\"body-wrap\">\n"
                + "            <tr>\n"
                + "                <td></td>\n"
                + "                <td class=\"container\" bgcolor=\"#FFFFFF\">\n"
                + "                    <div class=\"content\">\n"
                + "                        <table>\n"
                + "                            <tr>\n"
                + "                                <td>\n"
                + "                                    <h3>Hola, " + USUARIO2 + "</h3>\n"
                + "                                    <p class=\"callout\">\n"
                + "                                        " + CONTENIDO + "\n"
                + "                                    </p>\n"
                + "                                    <p>\n"
                + "                                        <table style=\"font-size: medium\">\n"
                + "                                            <tr>\n"
                + "                                                <td>Folio: " + FOLIO + "</td>\n"
                + "                                            </tr>\n"
                + "                                            <tr>\n"
                + "                                                <td>" + USERCREATE + "</td>\n"
                + "                                            </tr>\n"
                + "                                            <tr>\n"
                + "                                                <td>" + NOMBRE + "</td>\n"
                + "                                            </tr>\n"
                + "                                        </table>\n"
                + "                                    </p> <br/>\n"
                + "                                     <table>\n"
                + "                                         <tr>\n"
                + "                                             <td>\n"
                + "                                                 <p>\n"
                + "                                                     <a href=\"http://www.sgcon-infonavit.com\" class=\"soc-btn fb\">Ir a la aplicación</a> \n"
                + "                                                 </p>\n"
                + "                                             </td>\n"
                + "                                         </tr>\n"
                + "                                     </table\n"
                + "                                </td>\n"
                + "                            </tr>\n"
                + "                        </table>\n"
                + "                    </div>\n"
                + "                </td>\n"
                + "                <td></td>\n"
                + "            </tr>\n"
                + "        </table>\n"
                + "    </body>");

        Body body = new Body().withHtml(htmlContent);

        // Create a message with the specified subject and body.
        Message message = new Message().withSubject(subject).withBody(body);

        // Assemble the email.
        SendEmailRequest request = new SendEmailRequest().withSource(FROM).withDestination(destination).withMessage(message);

        try {
            System.out.println("Attempting to send an email through Amazon SES by using the AWS SDK for Java...");

            /*
             * The ProfileCredentialsProvider will return your [default]
             * credential profile by reading from the credentials file located at
             * (~/.aws/credentials).
             *
             * TransferManager manages a pool of threads, so we create a
             * single instance and share it throughout our application.
             */
            /*AWSCredentials credentials = null;
             try {
             credentials = new ProfileCredentialsProvider().getCredentials();
             } catch (Exception e) {
             throw new AmazonClientException(
             "Cannot load the credentials from the credential profiles file. "
             + "Please make sure that your credentials file is at the correct "
             + "location (~/.aws/credentials), and is in valid format.",
             e);
             }*/
            AWSCredentials awsCreds = new BasicAWSCredentials("AKIAJFO4NNHIPNTB4ZCQ", "VjYeQ9+xj3HAcLBSxxxbHTo6jy2ft0wF6tgWZXmA");
            // Instantiate an Amazon SES client, which will make the service call with the supplied AWS credentials.
            //AmazonSimpleEmailServiceClient client = new AmazonSimpleEmailServiceClient(credentials);
            AmazonSimpleEmailServiceClient client = new AmazonSimpleEmailServiceClient(awsCreds);

            // Choose the AWS region of the Amazon SES endpoint you want to connect to. Note that your production
            // access status, sending limits, and Amazon SES identity-related settings are specific to a given
            // AWS region, so be sure to select an AWS region in which you set up Amazon SES. Here, we are using
            // the US East (N. Virginia) region. Examples of other regions that Amazon SES supports are US_WEST_2
            // and EU_WEST_1. For a complete list, see http://docs.aws.amazon.com/ses/latest/DeveloperGuide/regions.html
            Region REGION = Region.getRegion(Regions.US_WEST_2);
            client.setRegion(REGION);

            // Send the email.
            client.sendEmail(request);
            System.out.println("Email sent!");

        } catch (Exception ex) {
            System.out.println("The email was not sent.");
            System.out.println("Error message: " + ex.getMessage());
        }
    }

    public void sendMailDos(String TO, String USUARIO2, String SUBJECT, String CONTENIDO, String LISTA) {

        System.out.println("Si imprime la llamada del la clase  djscnlskdncfksdlncfñksdclñdsncewldn");

        //operaciones con el json       
        // Construct an object to contain the recipient address.
        Destination destination = new Destination().withToAddresses(new String[]{TO});

        // Create the subject and body of the message.
        Content subject = new Content().withData(SUBJECT);

        Content htmlContent = new Content().withData(" <body bgcolor=\"#FFFFFF\">\n"
                + "    <!-- HEADER -->\n"
                + "        <table class=\"head-wrap\" bgcolor=\"red\">\n"
                + "            <tr>\n"
                + "                <td></td>\n"
                + "                <td class=\"header container\" >\n"
                + "                    <div class=\"content\">\n"
                + "                        <table bgcolor=\"red\">\n"
                + "                            <tr>\n"
                + "                                <td style=\"font-size: x-large; color:white;\">\n"
                + "                                    S G C o n\n"
                + "                                </td>\n"
                + "                                <td style=\"text-align: right; color:white; fon\">\n"
                + "                                    Notificaciones\n"
                + "                                </td>\n"
                + "                            </tr>\n"
                + "                        </table>\n"
                + "                    </div>\n"
                + "                </td>\n"
                + "                <td></td>\n"
                + "            </tr>\n"
                + "        </table><!-- /HEADER -->\n"
                + "        <!-- BODY -->\n"
                + "        <table class=\"body-wrap\">\n"
                + "            <tr>\n"
                + "                <td></td>\n"
                + "                <td class=\"container\" bgcolor=\"#FFFFFF\">\n"
                + "                    <div class=\"content\">\n"
                + "                        <table>\n"
                + "                            <tr>\n"
                + "                                <td>\n"
                + "                                    <h3>Hola, " + USUARIO2 + "</h3>\n"
                + "                                    <p class=\"callout\">\n"
                + "                                        " + CONTENIDO + "\n"
                + "                                    </p>\n"
                + "                                    <p>\n"
                + "                                        <table style=\"font-size: medium\">\n"
                + "                                            <tr>\n"
                + "                                                <td>Folio: " + LISTA + "</td>\n"
                + "                                            </tr>\n"
                + "                                        </table>\n"
                + "                                    </p> <br/>\n"
                + "                                     <table>\n"
                + "                                         <tr>\n"
                + "                                             <td>\n"
                + "                                                 <p>\n"
                + "                                                     <a href=\"http://www.sgcon-infonavit.com\" class=\"soc-btn fb\">Ir a la aplicación</a> \n"
                + "                                                 </p>\n"
                + "                                             </td>\n"
                + "                                         </tr>\n"
                + "                                     </table\n"
                + "                                </td>\n"
                + "                            </tr>\n"
                + "                        </table>\n"
                + "                    </div>\n"
                + "                </td>\n"
                + "                <td></td>\n"
                + "            </tr>\n"
                + "        </table>\n"
                + "    </body>");

        Body body = new Body().withHtml(htmlContent);

        // Create a message with the specified subject and body.
        Message message = new Message().withSubject(subject).withBody(body);

        // Assemble the email.
        SendEmailRequest request = new SendEmailRequest().withSource(FROM).withDestination(destination).withMessage(message);

        try {
            System.out.println("Attempting to send an email through Amazon SES by using the AWS SDK for Java...");

            /*
             * The ProfileCredentialsProvider will return your [default]
             * credential profile by reading from the credentials file located at
             * (~/.aws/credentials).
             *
             * TransferManager manages a pool of threads, so we create a
             * single instance and share it throughout our application.
             */
            /*AWSCredentials credentials = null;
             try {
             credentials = new ProfileCredentialsProvider().getCredentials();
             } catch (Exception e) {
             throw new AmazonClientException(
             "Cannot load the credentials from the credential profiles file. "
             + "Please make sure that your credentials file is at the correct "
             + "location (~/.aws/credentials), and is in valid format.",
             e);
             }*/
            AWSCredentials awsCreds = new BasicAWSCredentials("AKIAJFO4NNHIPNTB4ZCQ", "VjYeQ9+xj3HAcLBSxxxbHTo6jy2ft0wF6tgWZXmA");
            // Instantiate an Amazon SES client, which will make the service call with the supplied AWS credentials.
            //AmazonSimpleEmailServiceClient client = new AmazonSimpleEmailServiceClient(credentials);
            AmazonSimpleEmailServiceClient client = new AmazonSimpleEmailServiceClient(awsCreds);

            // Choose the AWS region of the Amazon SES endpoint you want to connect to. Note that your production
            // access status, sending limits, and Amazon SES identity-related settings are specific to a given
            // AWS region, so be sure to select an AWS region in which you set up Amazon SES. Here, we are using
            // the US East (N. Virginia) region. Examples of other regions that Amazon SES supports are US_WEST_2
            // and EU_WEST_1. For a complete list, see http://docs.aws.amazon.com/ses/latest/DeveloperGuide/regions.html
            Region REGION = Region.getRegion(Regions.US_WEST_2);
            client.setRegion(REGION);

            // Send the email.
            client.sendEmail(request);
            System.out.println("Email sent!");

        } catch (Exception ex) {
            System.out.println("The email was not sent.");
            System.out.println("Error message: " + ex.getMessage());
        }
    }
}
