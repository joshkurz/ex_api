// Generated by CoffeeScript 1.3.3
(function() {
  var Contact, ContactLang, ContactRelated, ContactRelatedTitle, Email, Event, Lang, Net, Note, ObjectId, Phone, Place, Schema, URL, User, lastMod, mongoose, placeTypes, schema, schemaName, schemas;

  mongoose = require('mongoose');

  lastMod = require("./lastmod");

  Schema = mongoose.Schema;

  ObjectId = Schema.ObjectId;

  schemas = [];

  if (1) {
    schemaName = 'Event';
    schema = Event = new Schema({
      type: {
        type: String,
        "enum": ['l', 'e', 't', 'a'],
        doc: "l=log, e=event, t=todo, a=anniverary"
      },
      tags: {
        type: [String],
        doc: "DS=Discussion, CALL, wedding, hired, etc"
      },
      y: Number,
      ym: Number,
      ymd: Number,
      is: {
        type: String,
        "enum": ['a', 'b', 'c']
      },
      date: Date,
      note: String
    });
    schema.plugin(lastMod);
    exports[schemaName] = mongoose.model(schemaName, schema);
    schemas.push({
      name: schemaName,
      schema: schema
    });
  }

  if (1) {
    schemaName = 'ContactRelatedTitle';
    schema = ContactRelatedTitle = new Schema({
      looksUpTo: Boolean,
      type: {
        type: String,
        "enum": ['f', 'fx', 'o']
      },
      title: String,
      titleShort: String,
      titleRev: String,
      titleRevShort: String
    });
    schema.plugin(lastMod);
    exports[schemaName] = mongoose.model(schemaName, schema);
    schemas.push({
      name: schemaName,
      schema: schema
    });
  }

  if (1) {
    schemaName = 'ContactRelated';
    schema = ContactRelated = new Schema({
      parent_id: ObjectId,
      parentName: String,
      child_id: ObjectId,
      childName: String,
      relatedType: [ContactRelatedTitle],
      beginOn: [Event],
      endOn: [Event],
      status: String,
      sort: Number,
      note: String
    });
    schema.plugin(lastMod);
    exports[schemaName] = mongoose.model(schemaName, schema);
    schemas.push({
      name: schemaName,
      schema: schema
    });
  }

  if (1) {
    schemaName = 'Note';
    schema = Note = new Schema({
      tags: [String],
      note: String
    });
    schema.plugin(lastMod);
    exports[schemaName] = mongoose.model(schemaName, schema);
    schemas.push({
      name: schemaName,
      schema: schema
    });
  }

  if (1) {
    schemaName = 'URL';
    schema = URL = new Schema({
      tags: [String],
      note: String
    });
    schema.plugin(lastMod);
    exports[schemaName] = mongoose.model(schemaName, schema);
    schemas.push({
      name: schemaName,
      schema: schema
    });
  }

  if (1) {
    schemaName = 'Lang';
    schema = Lang = new Schema({
      name: String,
      iso: String,
      wt: String,
      local: String
    });
    schema.plugin(lastMod);
    exports[schemaName] = mongoose.model(schemaName, schema);
    schemas.push({
      name: schemaName,
      schema: schema
    });
  }

  if (1) {
    schemaName = 'ContactLang';
    schema = ContactLang = new Schema({
      language_id: [Lang],
      sort: Number,
      read: Boolean,
      write: Boolean,
      speak: Boolean,
      note: String
    });
    schema.plugin(lastMod);
    exports[schemaName] = mongoose.model(schemaName, schema);
    schemas.push({
      name: schemaName,
      schema: schema
    });
  }

  if (1) {
    schemaName = 'Email';
    schema = Email = new Schema({
      sort: Number,
      email: String,
      note: String
    });
    schema.plugin(lastMod);
    exports[schemaName] = mongoose.model(schemaName, schema);
    schemas.push({
      name: schemaName,
      schema: schema
    });
  }

  if (1) {
    schemaName = 'Net';
    schema = Net = new Schema({
      sort: Number,
      type: {
        type: String,
        "enum": 'skype',
        'google': 'google',
        'facebook': 'facebook',
        'other': 'other'
      },
      userName: String,
      userId: String,
      note: String
    });
    schema.plugin(lastMod);
    exports[schemaName] = mongoose.model(schemaName, schema);
    schemas.push({
      name: schemaName,
      schema: schema
    });
  }

  if (1) {
    schemaName = 'Phone';
    schema = Phone = new Schema({
      sort: Number,
      type: {
        type: String,
        "enum": ['l', 'm', 'v', 'p', 'f']
      },
      countryCode: String,
      areaCode: String,
      number: {
        type: String,
        required: true
      },
      ext: {
        type: String
      },
      note: String
    });
    schema.virtual("phoneFull").get(function() {
      var ret;
      ret = '';
      if (this.countryCode) {
        ret += '+' + this.countryCode + ' ';
      }
      if (this.areaCode) {
        ret += '(' + this.areaCode + ') ';
      }
      ret += this.number;
      if (this.ext) {
        ret += 'x' + this.ext;
      }
      return ret;
    });
    schema.plugin(lastMod);
    exports[schemaName] = mongoose.model(schemaName, schema);
    schemas.push({
      name: schemaName,
      schema: schema
    });
  }

  if (1) {
    schemaName = 'Contact';
    schema = Contact = new Schema({
      isUser: Boolean,
      statusTags: [String],
      affiliationTags: [String],
      typeId: String,
      code: String,
      industryId: String,
      nameShort: String,
      nickName: String,
      tags: [String],
      status: String,
      notes: [Note],
      log: [Event],
      adminNote: String,
      title: String,
      firstName: String,
      middleName: String,
      lastName: String,
      maidenName: String,
      suffix: String,
      gender: String,
      anniversaries: [Event],
      languages: [ContactLang],
      familyTags: [String],
      professionTags: [String],
      skillTags: [String],
      hobbyTags: [String],
      pets: [String],
      pics: [String],
      companyName: String,
      division: String,
      department: String
    });
    /*
      lastEventOn: latest log date
      lastEventBy: associated userName 
      nameFull: 
        # If person:
          personFull: lastName + maidenName + suffix, title + firstName + middleName
        # If company:
          companyFull: companyName + department
        # If company & person:          
          companyFull + personFull
        placeFull: # primary address (place):
        commMethods:
          phonesFull
          emailsFull
          netsFull
        vCard:
          nameFull
          placeFull
          commMethods
    */

    schema.plugin(lastMod);
    exports[schemaName] = mongoose.model(schemaName, schema);
    schemas.push({
      name: schemaName,
      schema: schema
    });
  }

  if (1) {
    schemaName = 'Place';
    if (1) {
      placeTypes = ['c-clinic', 'c-dinning', 'c-factory', 'c-hospital', 'c-mall', 'c-police', 'c-school', 'c-shopping', 'g-lake', 'g-river', 'l-monument', 'l-statue', 'o-world', 'o-zone', 'o-language', 'o-district', 'o-circuit', 'o-cong', 'o-group', 'o-subGroup', 'o-territory', 'o-subTerritory', 'o-block', 'p-hemisphere', 'p-continent', 'p-country', 'p-stateProvince', 'p-county', 'p-locality', 'p-subLocality', 'p-neighborhood', 'p-premise', 'p-subPremise', 'p-floor'];
      /*
          p-locality #city
          p-subLocality # like ? in CR
          p-neighborhood # like ?
          p-premise # Collection of buildings
          p-subPremise # usually a singular building within a collection
      */

    }
    schema = Place = new Schema({
      /*
          need a short human friendly unique ID that user can easily use to find by: p<id>
          c=commercial, g=geographic, l=landmark, m=mixed, o=organizational, p=political, r=residence
      */

      id: String,
      "class": {
        type: String,
        "enum": ['c', 'e', 'g', 'm', 'o', 'p', 'r']
      },
      type: {
        type: String,
        "enum": placeTypes
      },
      multipleUnits: Boolean,
      multipleLevels: Boolean,
      name: String,
      nameShort: String,
      nickname: String,
      code: String,
      sort: Number,
      status: String,
      log: [Event],
      addrStrName: String,
      addrStrAddr: String,
      addrFloor: String,
      addrSuiteApt: String,
      address: String,
      /*
          In the UI, user picks San Diego city, find or add, and use this Place
          Theoretically, user picks from existing paths of 'places' or
          fills in typical: Country, State, County, City, etc.
          from these, Place docs are created and linked together
          ultimately THIS place can only link to ONE 'location' Place
          To build location path for example:
          This residence Place belongs to a neighborhood which belongs to a city which belongs to a state, etc
      */

      location: [Place],
      boundary: {},
      boundaryConfirmed: Boolean,
      box: {},
      loc: [Number, Number],
      locConfirmed: Boolean,
      /*
          This place may belong to organizational places/territories
          ie, this Place.territory may belong to a Place.SalesDistrict
          PlaceAssoc.California -> includes -> Place.San Diego
      */

      belongsTo: [Place],
      intersection: String,
      adminNote: String,
      accessTags: [String],
      color1: {
        type: String,
        "enum": ['white', 'black', 'etc']
      },
      color2: {
        type: String,
        "enum": ['white', 'black', 'etc']
      },
      description: String,
      tags: [String],
      toNext: String,
      notes: [Note],
      phones: [Phone],
      emails: [Email],
      urls: [URL],
      contacts: [Contact]
    });
    /*
      lastEventOn: latest log date
      lastEventBy: associated userName 
      path: of ancestors, ie, ['Costa Rica', 'Heredia', 'Belen']
      pathShort: version of ancestors, ie, cr/her?/belen
      name:
      nameShort:      
      addressFull: Automatically filled in with address parts if provided.
    */

    schema.plugin(lastMod);
    exports[schemaName] = mongoose.model(schemaName, schema);
    schemas.push({
      name: schemaName,
      schema: schema
    });
  }

  if (1) {
    schemaName = 'User';
    schema = User = new Schema({
      contact_id: [Contact],
      provider: String,
      uid: String,
      name: String,
      image: String
    });
    schema.plugin(lastMod);
    exports[schemaName] = mongoose.model(schemaName, schema);
    schemas.push({
      name: schemaName,
      schema: schema
    });
  }

  exports.schemas = schemas;

}).call(this);
