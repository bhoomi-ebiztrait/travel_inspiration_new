

class FlightDomesticModel {
  FlightDomesticModel({

    this.domesticOnwardFlights,
    this.domesticReturnFlights,
    this.providersCount,
    this.responseStatus,
    this.message,
    this.searchId,
  });


  List<DomesticOnwardFlight> domesticOnwardFlights;
  List<dynamic> domesticReturnFlights;
  int providersCount;
  int responseStatus;
  String message;
  String searchId;

  factory FlightDomesticModel.fromJson(Map<String, dynamic> json) => FlightDomesticModel(
    domesticOnwardFlights: List<DomesticOnwardFlight>.from(json["DomesticOnwardFlights"].map((x) => DomesticOnwardFlight.fromJson(x))),
    domesticReturnFlights: List<dynamic>.from(json["DomesticReturnFlights"].map((x) => x)),
    providersCount: json["ProvidersCount"],
    responseStatus: json["ResponseStatus"],
    message: json["Message"],
    searchId: json["SearchID"],
  );

  Map<String, dynamic> toJson() => {
    "DomesticOnwardFlights": List<dynamic>.from(domesticOnwardFlights.map((x) => x.toJson())),
    "DomesticReturnFlights": List<dynamic>.from(domesticReturnFlights.map((x) => x)),
    "ProvidersCount": providersCount,
    "ResponseStatus": responseStatus,
    "Message": message,
    "SearchID": searchId,
  };
}

class DomesticOnwardFlight {
  DomesticOnwardFlight({
    this.fareDetails,
    this.flightSegments,
    this.originDestinationoptionId,
    this.intOnward,
    this.intReturn,
    this.intMulti,
    this.requestDetails,
    this.provider,
    this.partnerId,
    this.affiliateId,
    this.flightUId,
    this.isGstMandatory,
    this.airlineRemark,
    this.isLcc,
    this.isHoldAllowed,
    this.validatingCarrier,
  });

  FareDetails fareDetails;
  List<FlightSegment> flightSegments;
  OriginDestinationoptionId originDestinationoptionId;
  dynamic intOnward;
  dynamic intReturn;
  dynamic intMulti;
  RequestDetails requestDetails;
  String provider;
  dynamic partnerId;
  dynamic affiliateId;
  String flightUId;
  bool isGstMandatory;
  String airlineRemark;
  bool isLcc;
  bool isHoldAllowed;
  dynamic validatingCarrier;

  factory DomesticOnwardFlight.fromJson(Map<String, dynamic> json) => DomesticOnwardFlight(
    fareDetails: FareDetails.fromJson(json["FareDetails"]),
    flightSegments: List<FlightSegment>.from(json["FlightSegments"].map((x) => FlightSegment.fromJson(x))),
    originDestinationoptionId: OriginDestinationoptionId.fromJson(json["OriginDestinationoptionId"]),
    intOnward: json["IntOnward"],
    intReturn: json["IntReturn"],
    intMulti: json["IntMulti"],
    requestDetails: RequestDetails.fromJson(json["RequestDetails"]),
    provider: json["Provider"],
    partnerId: json["PartnerId"],
    affiliateId: json["AffiliateId"],
    flightUId: json["FlightUId"],
    isGstMandatory: json["IsGSTMandatory"],
    airlineRemark: json["AirlineRemark"],
    isLcc: json["IsLCC"],
    isHoldAllowed: json["IsHoldAllowed"],
    validatingCarrier: json["validatingCarrier"],
  );

  Map<String, dynamic> toJson() => {
    "FareDetails": fareDetails.toJson(),
    "FlightSegments": List<dynamic>.from(flightSegments.map((x) => x.toJson())),
    "OriginDestinationoptionId": originDestinationoptionId.toJson(),
    "IntOnward": intOnward,
    "IntReturn": intReturn,
    "IntMulti": intMulti,
    "RequestDetails": requestDetails.toJson(),
    "Provider": provider,
    "PartnerId": partnerId,
    "AffiliateId": affiliateId,
    "FlightUId": flightUId,
    "IsGSTMandatory": isGstMandatory,
    "AirlineRemark": airlineRemark,
    "IsLCC": isLcc,
    "IsHoldAllowed": isHoldAllowed,
    "validatingCarrier": validatingCarrier,
  };
}

class FareDetails {
  FareDetails({
    this.chargeableFares,
    this.nonchargeableFares,
    this.fareBreakUp,
    this.ocTax,
    this.partnerFee,
    this.plbEarned,
    this.tdsOnPlb,
    this.bonus,
    this.totalFare,
    this.responseStatus,
    this.status,
    this.isGstMandatory,
    this.message,
    this.requiredFields,
  });

  ChargeableFares chargeableFares;
  NonchargeableFares nonchargeableFares;
  FareBreakUp fareBreakUp;
  int ocTax;
  int partnerFee;
  int plbEarned;
  int tdsOnPlb;
  int bonus;
  int totalFare;
  int responseStatus;
  int status;
  bool isGstMandatory;
  dynamic message;
  dynamic requiredFields;

  factory FareDetails.fromJson(Map<String, dynamic> json) => FareDetails(
    chargeableFares: ChargeableFares.fromJson(json["ChargeableFares"]),
    nonchargeableFares: NonchargeableFares.fromJson(json["NonchargeableFares"]),
    fareBreakUp: FareBreakUp.fromJson(json["FareBreakUp"]),
    ocTax: json["OCTax"],
    partnerFee: json["PartnerFee"],
    plbEarned: json["PLBEarned"],
    tdsOnPlb: json["TdsOnPLB"],
    bonus: json["Bonus"],
    totalFare: json["TotalFare"],
    responseStatus: json["ResponseStatus"],
    status: json["Status"],
    isGstMandatory: json["IsGSTMandatory"],
    message: json["Message"],
    requiredFields: json["RequiredFields"],
  );

  Map<String, dynamic> toJson() => {
    "ChargeableFares": chargeableFares.toJson(),
    "NonchargeableFares": nonchargeableFares.toJson(),
    "FareBreakUp": fareBreakUp.toJson(),
    "OCTax": ocTax,
    "PartnerFee": partnerFee,
    "PLBEarned": plbEarned,
    "TdsOnPLB": tdsOnPlb,
    "Bonus": bonus,
    "TotalFare": totalFare,
    "ResponseStatus": responseStatus,
    "Status": status,
    "IsGSTMandatory": isGstMandatory,
    "Message": message,
    "RequiredFields": requiredFields,
  };
}

class ChargeableFares {
  ChargeableFares({
    this.actualBaseFare,
    this.tax,
    this.sTax,
    this.sCharge,
    this.tDiscount,
    this.tPartnerCommission,
    this.netFare,
    this.conveniencefee,
    this.conveniencefeeType,
    this.partnerFareDatails,
  });

  int actualBaseFare;
  int tax;
  int sTax;
  int sCharge;
  int tDiscount;
  int tPartnerCommission;
  int netFare;
  int conveniencefee;
  int conveniencefeeType;
  PartnerFareDatails partnerFareDatails;

  factory ChargeableFares.fromJson(Map<String, dynamic> json) => ChargeableFares(
    actualBaseFare: json["ActualBaseFare"],
    tax: json["Tax"],
    sTax: json["STax"],
    sCharge: json["SCharge"],
    tDiscount: json["TDiscount"],
    tPartnerCommission: json["TPartnerCommission"],
    netFare: json["NetFare"],
    conveniencefee: json["Conveniencefee"],
    conveniencefeeType: json["ConveniencefeeType"],
    partnerFareDatails: PartnerFareDatails.fromJson(json["PartnerFareDatails"]),
  );

  Map<String, dynamic> toJson() => {
    "ActualBaseFare": actualBaseFare,
    "Tax": tax,
    "STax": sTax,
    "SCharge": sCharge,
    "TDiscount": tDiscount,
    "TPartnerCommission": tPartnerCommission,
    "NetFare": netFare,
    "Conveniencefee": conveniencefee,
    "ConveniencefeeType": conveniencefeeType,
    "PartnerFareDatails": partnerFareDatails.toJson(),
  };
}

class PartnerFareDatails {
  PartnerFareDatails({
    this.netFares,
    this.commission,
    this.commissionType,
  });

  String netFares;
  String commission;
  int commissionType;

  factory PartnerFareDatails.fromJson(Map<String, dynamic> json) => PartnerFareDatails(
    netFares: json["NetFares"],
    commission: json["Commission"],
    commissionType: json["CommissionType"],
  );

  Map<String, dynamic> toJson() => {
    "NetFares": netFares,
    "Commission": commission,
    "CommissionType": commissionType,
  };
}

class FareBreakUp {
  FareBreakUp({
    this.fareAry,
  });

  List<FareAry> fareAry;

  factory FareBreakUp.fromJson(Map<String, dynamic> json) => FareBreakUp(
    fareAry: List<FareAry>.from(json["FareAry"].map((x) => FareAry.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "FareAry": List<dynamic>.from(fareAry.map((x) => x.toJson())),
  };
}

class FareAry {
  FareAry({
    this.intPassengerType,
    this.intBaseFare,
    this.intPassengerCount,
    this.intTax,
    this.intYqTax,
    this.intTaxDataArray,
    this.otherCharges,
  });

  String intPassengerType;
  int intBaseFare;
  int intPassengerCount;
  int intTax;
  int intYqTax;
  List<IntTaxDataArray> intTaxDataArray;
  List<OtherCharge> otherCharges;

  factory FareAry.fromJson(Map<String, dynamic> json) => FareAry(
    intPassengerType: json["IntPassengerType"],
    intBaseFare: json["IntBaseFare"],
    intPassengerCount: json["IntPassengerCount"],
    intTax: json["IntTax"],
    intYqTax: json["IntYQTax"],
    intTaxDataArray: List<IntTaxDataArray>.from(json["IntTaxDataArray"].map((x) => IntTaxDataArray.fromJson(x))),
    otherCharges: List<OtherCharge>.from(json["OtherCharges"].map((x) => OtherCharge.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "IntPassengerType": intPassengerType,
    "IntBaseFare": intBaseFare,
    "IntPassengerCount": intPassengerCount,
    "IntTax": intTax,
    "IntYQTax": intYqTax,
    "IntTaxDataArray": List<dynamic>.from(intTaxDataArray.map((x) => x.toJson())),
    "OtherCharges": List<dynamic>.from(otherCharges.map((x) => x.toJson())),
  };
}

class IntTaxDataArray {
  IntTaxDataArray({
    this.intCountry,
    this.intAmount,
  });

  IntCountry intCountry;
  int intAmount;

  factory IntTaxDataArray.fromJson(Map<String, dynamic> json) => IntTaxDataArray(
    intCountry: intCountryValues.map[json["IntCountry"]],
    intAmount: json["IntAmount"],
  );

  Map<String, dynamic> toJson() => {
    "IntCountry": intCountryValues.reverse[intCountry],
    "IntAmount": intAmount,
  };
}

enum IntCountry { INDIA }

final intCountryValues = EnumValues({
  "India": IntCountry.INDIA
});

class OtherCharge {
  OtherCharge({
    this.amount,
    this.chargeCode,
    this.chargeType,
  });

  int amount;
  dynamic chargeCode;
  String chargeType;

  factory OtherCharge.fromJson(Map<String, dynamic> json) => OtherCharge(
    amount: json["Amount"],
    chargeCode: json["ChargeCode"],
    chargeType: json["ChargeType"],
  );

  Map<String, dynamic> toJson() => {
    "Amount": amount,
    "ChargeCode": chargeCode,
    "ChargeType": chargeType,
  };
}

class NonchargeableFares {
  NonchargeableFares({
    this.tCharge,
    this.tMarkup,
    this.tSdiscount,
  });

  int tCharge;
  int tMarkup;
  int tSdiscount;

  factory NonchargeableFares.fromJson(Map<String, dynamic> json) => NonchargeableFares(
    tCharge: json["TCharge"],
    tMarkup: json["TMarkup"],
    tSdiscount: json["TSdiscount"],
  );

  Map<String, dynamic> toJson() => {
    "TCharge": tCharge,
    "TMarkup": tMarkup,
    "TSdiscount": tSdiscount,
  };
}

class FlightSegment {
  FlightSegment({
    this.airEquipType,
    this.arrivalAirportCode,
    this.arrivalDateTime,
    this.arrivalDateTimeZone,
    this.departureAirportCode,
    this.departureDateTime,
    this.departureDateTimeZone,
    this.duration,
    this.flightNumber,
    this.operatingAirlineCode,
    this.operatingAirlineFlightNumber,
    this.rph,
    this.stopQuantity,
    this.airLineName,
    this.airportTax,
    this.imageFileName,
    this.imagePath,
    this.viaFlight,
    this.discount,
    this.airportTaxChild,
    this.airportTaxInfant,
    this.adultTaxBreakup,
    this.childTaxBreakup,
    this.infantTaxBreakup,
    this.ocTax,
    this.bookingClass,
    this.bookingClassFare,
    this.intNumStops,
    this.intOperatingAirlineName,
    this.intArrivalAirportName,
    this.intDepartureAirportName,
    this.intMarketingAirlineCode,
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
    this.intLsaInd,
    this.intMile,
    this.cabin,
    this.itineraryNumber,
    this.baggageAllowed,
    this.paxWiseBaggageAllowed,
    this.accumulatedDuration,
    this.groundTime,
  });

  String airEquipType;
  Destination arrivalAirportCode;
  DateTime arrivalDateTime;
  String arrivalDateTimeZone;
  Source departureAirportCode;
  DateTime departureDateTime;
  String departureDateTimeZone;
  String duration;
  String flightNumber;
  ImageFileName operatingAirlineCode;
  String operatingAirlineFlightNumber;
  String rph;
  String stopQuantity;
  AirLineName airLineName;
  dynamic airportTax;
  ImageFileName imageFileName;
  ImagePath imagePath;
  String viaFlight;
  String discount;
  String airportTaxChild;
  String airportTaxInfant;
  String adultTaxBreakup;
  String childTaxBreakup;
  String infantTaxBreakup;
  String ocTax;
  BookingClass bookingClass;
  BookingClassFare bookingClassFare;
  String intNumStops;
  ImageFileName intOperatingAirlineName;
  IntArrivalAirportName intArrivalAirportName;
  IntDepartureAirportName intDepartureAirportName;
  ImageFileName intMarketingAirlineCode;
  dynamic intLinkSellAgrmnt;
  String intConx;
  String intAirpChg;
  String intInsideAvailOption;
  String intGenTrafRestriction;
  dynamic intDaysOperates;
  dynamic intJourneyTime;
  dynamic intEndDate;
  String intStartTerminal;
  String intEndTerminal;
  dynamic intFltTm;
  dynamic intLsaInd;
  String intMile;
  dynamic cabin;
  dynamic itineraryNumber;
  BaggageAllowed baggageAllowed;
  dynamic paxWiseBaggageAllowed;
  String accumulatedDuration;
  GroundTime groundTime;

  factory FlightSegment.fromJson(Map<String, dynamic> json) => FlightSegment(
    airEquipType: json["AirEquipType"],
    arrivalAirportCode: destinationValues.map[json["ArrivalAirportCode"]],
    arrivalDateTime: DateTime.parse(json["ArrivalDateTime"]),
    arrivalDateTimeZone: json["ArrivalDateTimeZone"],
    departureAirportCode: sourceValues.map[json["DepartureAirportCode"]],
    departureDateTime: DateTime.parse(json["DepartureDateTime"]),
    departureDateTimeZone: json["DepartureDateTimeZone"],
    duration: json["Duration"],
    flightNumber: json["FlightNumber"],
    operatingAirlineCode: imageFileNameValues.map[json["OperatingAirlineCode"]],
    operatingAirlineFlightNumber: json["OperatingAirlineFlightNumber"],
    rph: json["RPH"],
    stopQuantity: json["StopQuantity"],
    airLineName: airLineNameValues.map[json["AirLineName"]],
    airportTax: json["AirportTax"],
    imageFileName: imageFileNameValues.map[json["ImageFileName"]],
    imagePath: imagePathValues.map[json["ImagePath"]],
    viaFlight: json["ViaFlight"],
    discount: json["Discount"],
    airportTaxChild: json["AirportTaxChild"],
    airportTaxInfant: json["AirportTaxInfant"],
    adultTaxBreakup: json["AdultTaxBreakup"],
    childTaxBreakup: json["ChildTaxBreakup"],
    infantTaxBreakup: json["InfantTaxBreakup"],
    ocTax: json["OcTax"],
    bookingClass: BookingClass.fromJson(json["BookingClass"]),
    bookingClassFare: BookingClassFare.fromJson(json["BookingClassFare"]),
    intNumStops: json["IntNumStops"],
    intOperatingAirlineName: imageFileNameValues.map[json["IntOperatingAirlineName"]],
    intArrivalAirportName: intArrivalAirportNameValues.map[json["IntArrivalAirportName"]],
    intDepartureAirportName: intDepartureAirportNameValues.map[json["IntDepartureAirportName"]],
    intMarketingAirlineCode: imageFileNameValues.map[json["IntMarketingAirlineCode"]],
    intLinkSellAgrmnt: json["IntLinkSellAgrmnt"],
    intConx: json["IntConx"],
    intAirpChg: json["IntAirpChg"],
    intInsideAvailOption: json["IntInsideAvailOption"],
    intGenTrafRestriction: json["IntGenTrafRestriction"],
    intDaysOperates: json["IntDaysOperates"],
    intJourneyTime: json["IntJourneyTime"],
    intEndDate: json["IntEndDate"],
    intStartTerminal: json["IntStartTerminal"],
    intEndTerminal: json["IntEndTerminal"],
    intFltTm: json["IntFltTm"],
    intLsaInd: json["IntLSAInd"],
    intMile: json["IntMile"],
    cabin: json["Cabin"],
    itineraryNumber: json["itineraryNumber"],
    baggageAllowed: BaggageAllowed.fromJson(json["BaggageAllowed"]),
    paxWiseBaggageAllowed: json["PaxWiseBaggageAllowed"],
    accumulatedDuration: json["AccumulatedDuration"],
    groundTime: groundTimeValues.map[json["GroundTime"]],
  );

  Map<String, dynamic> toJson() => {
    "AirEquipType": airEquipType,
    "ArrivalAirportCode": destinationValues.reverse[arrivalAirportCode],
    "ArrivalDateTime": arrivalDateTime.toIso8601String(),
    "ArrivalDateTimeZone": arrivalDateTimeZone,
    "DepartureAirportCode": sourceValues.reverse[departureAirportCode],
    "DepartureDateTime": departureDateTime.toIso8601String(),
    "DepartureDateTimeZone": departureDateTimeZone,
    "Duration": duration,
    "FlightNumber": flightNumber,
    "OperatingAirlineCode": imageFileNameValues.reverse[operatingAirlineCode],
    "OperatingAirlineFlightNumber": operatingAirlineFlightNumber,
    "RPH": rph,
    "StopQuantity": stopQuantity,
    "AirLineName": airLineNameValues.reverse[airLineName],
    "AirportTax": airportTax,
    "ImageFileName": imageFileNameValues.reverse[imageFileName],
    "ImagePath": imagePathValues.reverse[imagePath],
    "ViaFlight": viaFlight,
    "Discount": discount,
    "AirportTaxChild": airportTaxChild,
    "AirportTaxInfant": airportTaxInfant,
    "AdultTaxBreakup": adultTaxBreakup,
    "ChildTaxBreakup": childTaxBreakup,
    "InfantTaxBreakup": infantTaxBreakup,
    "OcTax": ocTax,
    "BookingClass": bookingClass.toJson(),
    "BookingClassFare": bookingClassFare.toJson(),
    "IntNumStops": intNumStops,
    "IntOperatingAirlineName": imageFileNameValues.reverse[intOperatingAirlineName],
    "IntArrivalAirportName": intArrivalAirportNameValues.reverse[intArrivalAirportName],
    "IntDepartureAirportName": intDepartureAirportNameValues.reverse[intDepartureAirportName],
    "IntMarketingAirlineCode": imageFileNameValues.reverse[intMarketingAirlineCode],
    "IntLinkSellAgrmnt": intLinkSellAgrmnt,
    "IntConx": intConx,
    "IntAirpChg": intAirpChg,
    "IntInsideAvailOption": intInsideAvailOption,
    "IntGenTrafRestriction": intGenTrafRestriction,
    "IntDaysOperates": intDaysOperates,
    "IntJourneyTime": intJourneyTime,
    "IntEndDate": intEndDate,
    "IntStartTerminal": intStartTerminal,
    "IntEndTerminal": intEndTerminal,
    "IntFltTm": intFltTm,
    "IntLSAInd": intLsaInd,
    "IntMile": intMile,
    "Cabin": cabin,
    "itineraryNumber": itineraryNumber,
    "BaggageAllowed": baggageAllowed.toJson(),
    "PaxWiseBaggageAllowed": paxWiseBaggageAllowed,
    "AccumulatedDuration": accumulatedDuration,
    "GroundTime": groundTimeValues.reverse[groundTime],
  };
}

enum AirLineName { VISTARA }

final airLineNameValues = EnumValues({
  "Vistara": AirLineName.VISTARA
});

enum Destination { DEL, PNQ }

final destinationValues = EnumValues({
  "DEL": Destination.DEL,
  "PNQ": Destination.PNQ
});

class BaggageAllowed {
  BaggageAllowed({
    this.checkInBaggage,
    this.handBaggage,
  });

  CheckInBaggage checkInBaggage;
  String handBaggage;

  factory BaggageAllowed.fromJson(Map<String, dynamic> json) => BaggageAllowed(
    checkInBaggage: checkInBaggageValues.map[json["CheckInBaggage"]],
    handBaggage: json["HandBaggage"],
  );

  Map<String, dynamic> toJson() => {
    "CheckInBaggage": checkInBaggageValues.reverse[checkInBaggage],
    "HandBaggage": handBaggage,
  };
}

enum CheckInBaggage { THE_20_KG }

final checkInBaggageValues = EnumValues({
  "20 KG": CheckInBaggage.THE_20_KG
});

class BookingClass {
  BookingClass({
    this.availability,
    this.resBookDesigCode,
    this.intBic,
  });

  String availability;
  String resBookDesigCode;
  String intBic;

  factory BookingClass.fromJson(Map<String, dynamic> json) => BookingClass(
    availability: json["Availability"],
    resBookDesigCode: json["ResBookDesigCode"],
    intBic: json["IntBIC"],
  );

  Map<String, dynamic> toJson() => {
    "Availability": availability,
    "ResBookDesigCode": resBookDesigCode,
    "IntBIC": intBic,
  };
}

class BookingClassFare {
  BookingClassFare({
    this.adultFare,
    this.bookingclass,
    this.classType,
    this.farebasiscode,
    this.rule,
    this.adultCommission,
    this.childCommission,
    this.commissionOnTCharge,
    this.childFare,
    this.infantFare,
  });

  String adultFare;
  String bookingclass;
  ClassType classType;
  Farebasiscode farebasiscode;
  Rule rule;
  String adultCommission;
  String childCommission;
  String commissionOnTCharge;
  String childFare;
  String infantFare;

  factory BookingClassFare.fromJson(Map<String, dynamic> json) => BookingClassFare(
    adultFare: json["AdultFare"],
    bookingclass: json["Bookingclass"],
    classType: classTypeValues.map[json["ClassType"]],
    farebasiscode: farebasiscodeValues.map[json["Farebasiscode"]],
    rule: ruleValues.map[json["Rule"]],
    adultCommission: json["AdultCommission"],
    childCommission: json["ChildCommission"],
    commissionOnTCharge: json["CommissionOnTCharge"],
    childFare: json["ChildFare"],
    infantFare: json["InfantFare"],
  );

  Map<String, dynamic> toJson() => {
    "AdultFare": adultFare,
    "Bookingclass": bookingclass,
    "ClassType": classTypeValues.reverse[classType],
    "Farebasiscode": farebasiscodeValues.reverse[farebasiscode],
    "Rule": ruleValues.reverse[rule],
    "AdultCommission": adultCommission,
    "ChildCommission": childCommission,
    "CommissionOnTCharge": commissionOnTCharge,
    "ChildFare": childFare,
    "InfantFare": infantFare,
  };
}

enum ClassType { U }

final classTypeValues = EnumValues({
  "U": ClassType.U
});

enum Farebasiscode { UL1_PPV }

final farebasiscodeValues = EnumValues({
  "UL1PPV": Farebasiscode.UL1_PPV
});

enum Rule { NON_REFUNDABLE }

final ruleValues = EnumValues({
  "Non Refundable": Rule.NON_REFUNDABLE
});

enum Source { AMD, DEL }

final sourceValues = EnumValues({
  "AMD": Source.AMD,
  "DEL": Source.DEL
});

enum GroundTime { THE_0000_HRS }

final groundTimeValues = EnumValues({
  "00:00 hrs": GroundTime.THE_0000_HRS
});

enum ImageFileName { UK }

final imageFileNameValues = EnumValues({
  "UK": ImageFileName.UK
});

enum ImagePath { IMAGES_AIRLINE_LOGOS_UK_PNG }

final imagePathValues = EnumValues({
  "/Images/airline_logos/UK.png": ImagePath.IMAGES_AIRLINE_LOGOS_UK_PNG
});

enum IntArrivalAirportName { DELHI, PUNE }

final intArrivalAirportNameValues = EnumValues({
  "Delhi": IntArrivalAirportName.DELHI,
  "Pune": IntArrivalAirportName.PUNE
});

enum IntDepartureAirportName { AHMEDABAD, DELHI }

final intDepartureAirportNameValues = EnumValues({
  "Ahmedabad": IntDepartureAirportName.AHMEDABAD,
  "Delhi": IntDepartureAirportName.DELHI
});

class OriginDestinationoptionId {
  OriginDestinationoptionId({
    this.id,
    this.key,
  });

  String id;
  String key;

  factory OriginDestinationoptionId.fromJson(Map<String, dynamic> json) => OriginDestinationoptionId(
    id: json["Id"],
    key: json["Key"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Key": key,
  };
}

class RequestDetails {
  RequestDetails({
    this.travelClass,
    this.mode,
    this.source,
    this.destination,
    this.adults,
    this.children,
    this.infants,
    this.departDate,
    this.returnDate,
    this.multiCityearch,
  });

  dynamic travelClass;
  String mode;
  Source source;
  Destination destination;
  String adults;
  String children;
  String infants;
  DateTime departDate;
  DateTime returnDate;
  dynamic multiCityearch;

  factory RequestDetails.fromJson(Map<String, dynamic> json) => RequestDetails(
    travelClass: json["TravelClass"],
    mode: json["Mode"],
    source: sourceValues.map[json["Source"]],
    destination: destinationValues.map[json["Destination"]],
    adults: json["Adults"],
    children: json["Children"],
    infants: json["Infants"],
    departDate: DateTime.parse(json["DepartDate"]),
    returnDate: DateTime.parse(json["ReturnDate"]),
    multiCityearch: json["MultiCityearch"],
  );

  Map<String, dynamic> toJson() => {
    "TravelClass": travelClass,
    "Mode": mode,
    "Source": sourceValues.reverse[source],
    "Destination": destinationValues.reverse[destination],
    "Adults": adults,
    "Children": children,
    "Infants": infants,
    "DepartDate": departDate.toIso8601String(),
    "ReturnDate": returnDate.toIso8601String(),
    "MultiCityearch": multiCityearch,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
