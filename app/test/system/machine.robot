*** Settings ***
Documentation  API Testing in Robot Framework
Library  RequestsLibrary
Library  Collections

*** Variables ***
${URL}    127.0.0.1
${PORT}    5000
${BASE_URL}  http://${URL}:${PORT}

*** Test Cases ***
Do a GET Request and validate the response code and response body
    [documentation]  This test case verifies that the response code of the GET Request should be 200,
    ...  the response body contains the 'title' key with value as 'London',
    ...  and the response body contains the key 'location_type'.
    [tags]  Smoke
    Create Session  mysession  ${BASE_URL}  verify=true
    ${response}=  GET On Session  mysession  /
    Status Should Be  200  ${response}  #Check Status as 200

    ${response2}=  GET On Session  mysession  /machines
        Status Should Be  200  ${response2}  #Check Status as 200



*** Keywords ***

api testing robot framework test script
    user     khagu