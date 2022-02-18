class FlightModel {

  List<FlightOnword> flightOnword;
  List<FlightReturn> flightReturn;

  FlightModel({this.flightOnword, this.flightReturn});

  FlightModel.fromJson(Map<String, dynamic> json) {
    if (json['FlightOnword'] != null) {
      flightOnword = <FlightOnword>[];
      json['FlightOnword'].forEach((v) {
        flightOnword.add(new FlightOnword.fromJson(v));
      });
    }
    if (json['FlightReturn'] != null) {
      flightReturn = <FlightReturn>[];
      json['FlightReturn'].forEach((v) {
        flightReturn.add(new FlightReturn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.flightOnword != null) {
      data['FlightOnword'] = this.flightOnword.map((v) => v.toJson()).toList();
    }
    if (this.flightReturn != null) {
      data['FlightReturn'] = this.flightReturn.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FlightOnword {
  IntOnward intOnward;
  RequestDetails requestDetails;
  dynamic fare;

  FlightOnword({this.intOnward, this.requestDetails, this.fare});

  FlightOnword.fromJson(Map<String, dynamic> json) {
    intOnward = json['IntOnward'] != null
        ? new IntOnward.fromJson(json['IntOnward'])
        : null;
    requestDetails = json['RequestDetails'] != null
        ? new RequestDetails.fromJson(json['RequestDetails'])
        : null;
    fare = json['Fare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.intOnward != null) {
      data['IntOnward'] = this.intOnward.toJson();
    }
    if (this.requestDetails != null) {
      data['RequestDetails'] = this.requestDetails.toJson();
    }
    data['Fare'] = this.fare;
    return data;
  }
}

class IntOnward {
  List<FlightSegments> flightSegments;

  IntOnward({this.flightSegments});

  IntOnward.fromJson(Map<String, dynamic> json) {
    if (json['FlightSegments'] != null) {
      flightSegments = <FlightSegments>[];
      json['FlightSegments'].forEach((v) {
        flightSegments.add(new FlightSegments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.flightSegments != null) {
      data['FlightSegments'] =
          this.flightSegments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FlightSegments {
  // String? airEquipType;
  String arrivalAirportCode;
  String arrivalDateTime;
  bool intOnwardSelect;
  bool outwardSelect;

  // String? arrivalDateTimeZone;
  String departureAirportCode;
  String departureDateTime;

  // String? departureDateTimeZone;
  String duration;
  String flightNumber;

  // String? operatingAirlineCode;
  // String? operatingAirlineFlightNumber;
  // String? rPH;
  String stopQuantity;
  String airLineName;

  // Null? airportTax;
  // String? imageFileName;
  String imagePath;
  String viaFlight;

  // String? discount;
  // String? airportTaxChild;
  // String? airportTaxInfant;
  // String? adultTaxBreakup;
  // String? childTaxBreakup;
  // String? infantTaxBreakup;
  // String? ocTax;
  // BookingClass? bookingClass;
  // BookingClassFare? bookingClassFare;
  String intNumStops;

  // String? intOperatingAirlineName;
  String intArrivalAirportName;
  String intDepartureAirportName;

  // String? intMarketingAirlineCode;
  // Null? intLinkSellAgrmnt;
  // String? intConx;
  // String? intAirpChg;
  // String? intInsideAvailOption;
  // String? intGenTrafRestriction;
  // Null? intDaysOperates;
  // Null? intJourneyTime;
  // Null? intEndDate;
  // String? intStartTerminal;
  // String? intEndTerminal;
  // Null? intFltTm;
  // Null? intLSAInd;
  // String? intMile;
  // Null? cabin;
  // Null? itineraryNumber;
  // BaggageAllowed? baggageAllowed;
  // Null? paxWiseBaggageAllowed;
  // String? accumulatedDuration;
  // String? groundTime;

  FlightSegments({
    // this.airEquipType,
    this.arrivalAirportCode,
    this.arrivalDateTime,
    this.intOnwardSelect = false,
    this.outwardSelect = false,
    // this.arrivalDateTimeZone,
    this.departureAirportCode,
    this.departureDateTime,
    // this.departureDateTimeZone,
    this.duration,
    this.flightNumber,
    // this.operatingAirlineCode,
    // this.operatingAirlineFlightNumber,
    // this.rPH,
    this.stopQuantity,
    this.airLineName,
    // this.airportTax,
    // this.imageFileName,
    this.imagePath,
    this.viaFlight,
    /*this.discount,
        this.airportTaxChild,
        this.airportTaxInfant,
        this.adultTaxBreakup,
        this.childTaxBreakup,
        this.infantTaxBreakup,
        this.ocTax,
        this.bookingClass,
        this.bookingClassFare,*/
    this.intNumStops,
    // this.intOperatingAirlineName,
    this.intArrivalAirportName,
    this.intDepartureAirportName,
    /* this.intMarketingAirlineCode,
        this.intLinkSellAgrmnt,
        this.intConx,
        this.intAirpChg,
        this.intInsideAvailOption,
        this.intGenTrafRestriction,
        this.intDaysOperates,
        this.intJourneyTime,
        this.intEndDate,
        this.intStartTerminal,
        this.intEndTerminal,
        this.intFltTm,
        this.intLSAInd,
        this.intMile,
        this.cabin,
        this.itineraryNumber,
        this.baggageAllowed,
        this.paxWiseBaggageAllowed,
        this.accumulatedDuration,
        this.groundTime*/
  });

  FlightSegments.fromJson(Map<String, dynamic> json) {
    // airEquipType = json['AirEquipType'];
    arrivalAirportCode = json['ArrivalAirportCode'];
    arrivalDateTime = json['ArrivalDateTime'];
    // arrivalDateTimeZone = json['ArrivalDateTimeZone'];
    departureAirportCode = json['DepartureAirportCode'];
    departureDateTime = json['DepartureDateTime'];
    // departureDateTimeZone = json['DepartureDateTimeZone'];
    duration = json['Duration'];
    flightNumber = json['FlightNumber'];
    // operatingAirlineCode = json['OperatingAirlineCode'];
    // operatingAirlineFlightNumber = json['OperatingAirlineFlightNumber'];
    // rPH = json['RPH'];
    stopQuantity = json['StopQuantity'];
    airLineName = json['AirLineName'];
    // airportTax = json['AirportTax'];
    // imageFileName = json['ImageFileName'];
    imagePath = json['ImagePath'];
    viaFlight = json['ViaFlight'];
    /* discount = json['Discount'];
    airportTaxChild = json['AirportTaxChild'];
    airportTaxInfant = json['AirportTaxInfant'];
    adultTaxBreakup = json['AdultTaxBreakup'];
    childTaxBreakup = json['ChildTaxBreakup'];
    infantTaxBreakup = json['InfantTaxBreakup'];
    ocTax = json['OcTax'];
    bookingClass = json['BookingClass'] != null
        ? new BookingClass.fromJson(json['BookingClass'])
        : null;
    bookingClassFare = json['BookingClassFare'] != null
        ? new BookingClassFare.fromJson(json['BookingClassFare'])
        : null;*/
    intNumStops = json['IntNumStops'];
    // intOperatingAirlineName = json['IntOperatingAirlineName'];
    intArrivalAirportName = json['IntArrivalAirportName'];
    intDepartureAirportName = json['IntDepartureAirportName'];
    // intMarketingAirlineCode = json['IntMarketingAirlineCode'];
    // intLinkSellAgrmnt = json['IntLinkSellAgrmnt'];
    // intConx = json['IntConx'];
    // intAirpChg = json['IntAirpChg'];
    /*intInsideAvailOption = json['IntInsideAvailOption'];
    intGenTrafRestriction = json['IntGenTrafRestriction'];
    intDaysOperates = json['IntDaysOperates'];
    intJourneyTime = json['IntJourneyTime'];
    intEndDate = json['IntEndDate'];
    intStartTerminal = json['IntStartTerminal'];
    intEndTerminal = json['IntEndTerminal'];
    intFltTm = json['IntFltTm'];
    intLSAInd = json['IntLSAInd'];
    intMile = json['IntMile'];
    cabin = json['Cabin'];
    itineraryNumber = json['itineraryNumber'];
    baggageAllowed = json['BaggageAllowed'] != null
        ? new BaggageAllowed.fromJson(json['BaggageAllowed'])
        : null;
    paxWiseBaggageAllowed = json['PaxWiseBaggageAllowed'];
    accumulatedDuration = json['AccumulatedDuration'];
    groundTime = json['GroundTime'];*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['AirEquipType'] = this.airEquipType;
    data['ArrivalAirportCode'] = this.arrivalAirportCode;
    data['ArrivalDateTime'] = this.arrivalDateTime;
    // data['ArrivalDateTimeZone'] = this.arrivalDateTimeZone;
    data['DepartureAirportCode'] = this.departureAirportCode;
    data['DepartureDateTime'] = this.departureDateTime;
    // data['DepartureDateTimeZone'] = this.departureDateTimeZone;
    data['Duration'] = this.duration;
    data['FlightNumber'] = this.flightNumber;
    // data['OperatingAirlineCode'] = this.operatingAirlineCode;
    // data['OperatingAirlineFlightNumber'] = this.operatingAirlineFlightNumber;
    // data['RPH'] = this.rPH;
    data['StopQuantity'] = this.stopQuantity;
    data['AirLineName'] = this.airLineName;
    // data['AirportTax'] = this.airportTax;
    // data['ImageFileName'] = this.imageFileName;
    data['ImagePath'] = this.imagePath;
    data['ViaFlight'] = this.viaFlight;
    // data['Discount'] = this.discount;
    /*data['AirportTaxChild'] = this.airportTaxChild;
    data['AirportTaxInfant'] = this.airportTaxInfant;
    data['AdultTaxBreakup'] = this.adultTaxBreakup;
    data['ChildTaxBreakup'] = this.childTaxBreakup;
    data['InfantTaxBreakup'] = this.infantTaxBreakup;
    data['OcTax'] = this.ocTax;
    if (this.bookingClass != null) {
      data['BookingClass'] = this.bookingClass!.toJson();
    }
    if (this.bookingClassFare != null) {
      data['BookingClassFare'] = this.bookingClassFare!.toJson();
    }*/
    data['IntNumStops'] = this.intNumStops;
    // data['IntOperatingAirlineName'] = this.intOperatingAirlineName;
    data['IntArrivalAirportName'] = this.intArrivalAirportName;
    data['IntDepartureAirportName'] = this.intDepartureAirportName;
    /*data['IntMarketingAirlineCode'] = this.intMarketingAirlineCode;
    data['IntLinkSellAgrmnt'] = this.intLinkSellAgrmnt;
    data['IntConx'] = this.intConx;
    data['IntAirpChg'] = this.intAirpChg;
    data['IntInsideAvailOption'] = this.intInsideAvailOption;
    data['IntGenTrafRestriction'] = this.intGenTrafRestriction;
    data['IntDaysOperates'] = this.intDaysOperates;
    data['IntJourneyTime'] = this.intJourneyTime;
    data['IntEndDate'] = this.intEndDate;
    data['IntStartTerminal'] = this.intStartTerminal;
    data['IntEndTerminal'] = this.intEndTerminal;
    data['IntFltTm'] = this.intFltTm;
    data['IntLSAInd'] = this.intLSAInd;
    data['IntMile'] = this.intMile;
    data['Cabin'] = this.cabin;
    data['itineraryNumber'] = this.itineraryNumber;
    if (this.baggageAllowed != null) {
      data['BaggageAllowed'] = this.baggageAllowed!.toJson();
    }
    data['PaxWiseBaggageAllowed'] = this.paxWiseBaggageAllowed;
    data['AccumulatedDuration'] = this.accumulatedDuration;
    data['GroundTime'] = this.groundTime;*/
    return data;
  }
}

class RequestDetails {
  String travelClass;
  String mode;
  String source;
  String destination;
  String adults;
  String children;
  String infants;
  String departDate;
  String returnDate;
  // Null? multiCityearch;

  RequestDetails(
      {this.travelClass,
        this.mode,
        this.source,
        this.destination,
        this.adults,
        this.children,
        this.infants,
        this.departDate,
        this.returnDate,
        // this.multiCityearch
      });

  RequestDetails.fromJson(Map<String, dynamic> json) {
    travelClass = json['TravelClass'];
    mode = json['Mode'];
    source = json['Source'];
    destination = json['Destination'];
    adults = json['Adults'];
    children = json['Children'];
    infants = json['Infants'];
    departDate = json['DepartDate'];
    returnDate = json['ReturnDate'];
    // multiCityearch = json['MultiCityearch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TravelClass'] = this.travelClass;
    data['Mode'] = this.mode;
    data['Source'] = this.source;
    data['Destination'] = this.destination;
    data['Adults'] = this.adults;
    data['Children'] = this.children;
    data['Infants'] = this.infants;
    data['DepartDate'] = this.departDate;
    data['ReturnDate'] = this.returnDate;
    // data['MultiCityearch'] = this.multiCityearch;
    return data;
  }
}

class FlightReturn {
  IntOnward intReturn;

  FlightReturn({this.intReturn});

  FlightReturn.fromJson(Map<String, dynamic> json) {
    intReturn = json['IntReturn'] != null
        ? new IntOnward.fromJson(json['IntReturn'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.intReturn != null) {
      data['IntReturn'] = this.intReturn.toJson();
    }
    return data;
  }
}