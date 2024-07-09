You can transfer funds to a vendor by creating a Linked Account using APIs.
How to Create Linked Accounts
Below are the steps to integrate Route:
Create a Linked Account:

Create a Linked Account using the API. A unique account_id will be assigned to the created account.
2. Create a Stakeholder:
You should now create a stakeholder using the account_id. A unique stakeholder_id will be assigned to the created stakeholder account.
3. Request a Product Configuration:
Now that both Linked Account and stakeholder are created, you should request a Route product configuration.
4. Update a Product Configuration:
You should now trigger the update product configuration API with the bank account details of the Linked Account. The configuration will be activated if the information review is successful.
Know more about LInked Account Onboarding.


Create 
curl --location 'https://api.razorpay.com/v2/accounts' \
--header 'Content-type: application/json' \
--data-raw '{
   "email":"gaurav.kumar@example.com",
   "phone":"9000090000",
   "type":"route",
   "reference_id":"124124",
   "legal_business_name":"Acme Corp",
   "business_type":"partnership",
   "contact_name":"Gaurav Kumar",
   "profile":{
      "category":"healthcare",
      "subcategory":"clinic",
      "addresses":{
         "registered":{
            "street1":"507, Koramangala 1st block",
            "street2":"MG Road",
            "city":"Bengaluru",
            "state":"KARNATAKA",
            "postal_code":"560034",
            "country":"IN"
         }
      }
   },
   "legal_info":{
      "pan":"AAACL1234C",
      "gst":"18AABCU9603R1ZM"
   }
}'

update
curl --location 'https://api.razorpay.com/v2/accounts' \
--header 'Content-type: application/json' \
--data-raw '{
   "email":"gaurav.kumar@example.com",
   "phone":"9000090000",
   "type":"route",
   "reference_id":"124124",
   "legal_business_name":"Acme Corp",
   "business_type":"partnership",
   "contact_name":"Gaurav Kumar",
   "profile":{
      "category":"healthcare",
      "subcategory":"clinic",
      "addresses":{
         "registered":{
            "street1":"507, Koramangala 1st block",
            "street2":"MG Road",
            "city":"Bengaluru",
            "state":"KARNATAKA",
            "postal_code":"560034",
            "country":"IN"
         }
      }
   },
   "legal_info":{
      "pan":"AAACL1234C",
      "gst":"18AABCU9603R1ZM"
   }
}'

fetch
curl --location 'https://api.razorpay.com/v2/accounts/acc_GLGeLkU2JUeyDZ'


#Stake holders
curl --location 'https://api.razorpay.com/v2/accounts/acc_GLGeLkU2JUeyDZ/stakeholders' \
--header 'Content-type: application/json' \
--data '{
   "name":"Gaurav Kumar",
   "addresses":{
      "residential":{
         "street":"506, Koramangala 1st block",
         "city":"Bengaluru",
         "state":"Karnataka",
         "postal_code":"560034",
         "country":"IN"
      }
   },
   "kyc":{
      "pan":"AVOPB1111K"
   },
   "notes":{
      "random_key_by_partner":"random_value"
   }
}'
curl --location --request PATCH 'https://api.razorpay.com/v2/accounts/acc_GLGeLkU2JUeyDZ/stakeholders/sth_GOQ4Eftlz62TSL' \
--header 'Content-type: application/json' \
--data '{
   "addresses":{
      "residential":{
         "street":"507, Koramangala 1st block",
         "city":"Bangalore",
         "state":"Karnataka",
         "postal_code":"560035",
         "country":"IN"
      }
   },
   "kyc":{
      "pan":"AVOPB1111J"
   }
}'

request a product config
curl --location 'https://api.razorpay.com/v2/accounts/acc_HQVlm3bnPmccC0/products' \
--header 'Content-Type: application/json' \
--data '{
   "product_name":"route",
   "tnc_accepted":true
}'

update a product config
curl --location --request PATCH 'https://api.razorpay.com/v2/accounts/acc_HQVlm3bnPmccC0/products/acc_prd_HEgNpywUFctQ9e/' \
--header 'Content-Type: application/json' \
--data '{
   "settlements":{
      "account_number":"1234567890",
      "ifsc_code":"HDFC0000317",
      "beneficiary_name":"Gaurav Kumar"
   },
   "tnc_accepted":true
}'

fetch a product config
curl --location 'https://api.razorpay.com/v2/accounts/acc_HQVlm3bnPmccC0/products/acc_prd_HEgNpywUFctQ9e/'