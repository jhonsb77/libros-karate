Feature: Crear, actualizar y eliminar (ejecucion por tags especificos)


  @crearEspecifico
  Scenario Outline: Crear libro
    Given url "https://restful-booker.herokuapp.com/booking"
    And request { "firstname" : "#(firstname)", "lastname" : "#(lastname)", "totalprice" : "#(totalprice)", "depositpaid" : "#(depositpaid)", "bookingdates" : { "checkin" : "#(checkin)", "checkout" : "#(checkout)" }, "additionalneeds" : "#(additionalneeds)" }
    And header Accept = 'application/json'
    When method post
    Then status 200
    And match $.booking.firstname == firstname
    And def id = $.bookingid
    Examples:
    | firstname | lastname  | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
    | Pedro     | Gutierrez | 100        | true        | 2023-03-01 | 2023-04-01 | Comics          |
    | Javier    | Jaramillo | 356        | true        | 2023-03-15 | 2023-04-15 | Terror          |

  @consultarEspecifico
  Scenario Outline: Consultar los libros creados
    Given url "https://restful-booker.herokuapp.com/booking/"+id
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match $.firstname == firstname
    Examples:
     | firstname |
     | Pedro     |
     | Javier    |

  @actualizarEspecifico
  Scenario Outline: Actualizar los libros creados
    * call read("books.feature@token")
    Given url "https://restful-booker.herokuapp.com/booking/"+id
    And request { "firstname" : "#(firstnameAct)", "lastname" : "#(lastnameAct)", "totalprice" : "#(totalpriceAct)", "depositpaid" : "#(depositpaidAct)", "bookingdates" : { "checkin" : "#(checkinAct)", "checkout" : "#(checkoutAct)" }, "additionalneeds" : "#(additionalneedsAct)" }
    And header Accept = 'application/json'
    And header token = token
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    When method put
    Then status 200
    And match $.firstname == firstnameAct
    Examples:
      | firstnameAct | lastnameAct  | totalpriceAct | depositpaidAct | checkinAct    | checkoutAct   | additionalneedsAct |
      | Pedro        | Gutierrez    | 100           | true           | 2023-03-01    | 2023-04-01    | Comics             |
      | Javier       | Mora         | 356           | true           | 2023-06-20    | 2023-07-20    | Terror             |

  @eliminar
  Scenario: Eliminar libros
    * call read("books.feature@token")
    Given url "https://restful-booker.herokuapp.com/booking/"+id
    And header token = token
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    When method delete
    Then status 201
    And assert response.equals('Created')