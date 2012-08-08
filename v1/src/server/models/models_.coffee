mongoose = require('mongoose')
lastMod = require("./lastmod")
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

schemas = [] # used to capture schema details for docs

# if 1 is for convenience to collapse each block in Sublime
if 1 # Event  
  schemaName = 'Event'
  schema = Event = new Schema
    type: {type: String, enum: ['l', 'e', 't', 'a'], \
      doc:"l=log, e=event, t=todo, a=anniverary"}
    tags: {type: [String], \
      doc: "DS=Discussion, CALL, wedding, hired, etc"}
    y: Number # year ie, 2012
    ym: Number # year+month, ie, 201207 or -60710
    ymd: Number # year+month+day, ie, 20120730
    is: {type: String, enum: ['a', 'b', 'c']} # b=before, a=after, c=circa/close
    date: Date
    note: String
  schema.plugin lastMod
  exports[schemaName] = mongoose.model(schemaName, schema) 
  schemas.push {name:schemaName, schema}
if 1 # ContactRelatedTitle
  # If Current Contact is 'sonOf', then looksUpTo = True or child/lookupto related Contact
  # in that case set ContactRelated.parent_id = related Contact and child_id = current Contact
  schemaName = 'ContactRelatedTitle'
  schema = ContactRelatedTitle = new Schema
    looksUpTo: Boolean 
    type:
      type: String, enum: ['f','fx','o'] # f=family, fx=extended family, o=organizational
    title: String # Father of, Manager of, Overseer of, 
    titleShort: String # fatherOf, managerOf, overseerOf, 
    titleRev: String # Son of, Reports to, Employed by, Works for
    titleRevShort: String # sonOf, reportsTo, employedBy, worksFor
  schema.plugin lastMod
  exports[schemaName] = mongoose.model(schemaName, schema) 
  schemas.push {name:schemaName, schema}
if 1 # ContactRelated
  schemaName = 'ContactRelated'
  schema = ContactRelated = new Schema
    parent_id: ObjectId
    parentName: String # if no Contact Doc, just punch in a name
    child_id: ObjectId
    childName: String # if no Contact Doc, just punch in a name
    relatedType: [ContactRelatedTitle]
      # UI NOTE: Idea is to pick from list of ContactRelatedTitle titles to determine how to connect Contacts
    beginOn: [Event]
    endOn: [Event]
    status: String 
    sort: Number # sort order as applies to sibling Associations
    note: String 
  schema.plugin lastMod
  exports[schemaName] = mongoose.model(schemaName, schema) 
  schemas.push {name:schemaName, schema}
if 1 # Note
  schemaName = 'Note'
  schema = Note = new Schema
    tags: [String] # DS=Discussion, CALL, wedding, hired, etc
    note: String
  schema.plugin lastMod
  exports[schemaName] = mongoose.model(schemaName, schema)
  schemas.push {name:schemaName, schema}
if 1 # URL
  schemaName = 'URL'
  schema = URL = new Schema
    tags: [String] # DS=Discussion, CALL, wedding, hired, etc
    note: String 
  schema.plugin lastMod
  exports[schemaName] = mongoose.model(schemaName, schema)
  schemas.push {name:schemaName, schema}
if 1 # Lang-Language
  schemaName = 'Lang'
  schema = Lang = new Schema
    name: String
    iso: String # internet standard ID code
    wt: String # code used by Watchtower
    local: String # local version of name
  schema.plugin lastMod
  exports[schemaName] = mongoose.model(schemaName, schema)
  schemas.push {name:schemaName, schema}
if 1 # ContactLang
  schemaName = 'ContactLang'
  schema = ContactLang = new Schema
    language_id: [Lang]
    sort: Number # empty = primary, otherwise sort order
    read: Boolean
    write: Boolean
    speak: Boolean
    note: String
  schema.plugin lastMod
  exports[schemaName] = mongoose.model(schemaName, schema)
  schemas.push {name:schemaName, schema}
if 1 # Email
  schemaName = 'Email'
  schema = Email = new Schema
    sort: Number # empty = primary, otherwise sort order
    email: String
    note: String
  schema.plugin lastMod
  exports[schemaName] = mongoose.model(schemaName, schema)
  schemas.push {name:schemaName, schema}
if 1 # Net-SocialNetwork
  schemaName = 'Net'
  schema = Net = new Schema
    sort: Number # empty = primary, otherwise sort order
    # accomodate ability to add other enum strings to Schema
    type: {type:String, enum: 'skype', 'google', 'facebook', 'other'}
    userName: String
    userId: String
    note: String
  schema.plugin lastMod
  exports[schemaName] = mongoose.model(schemaName, schema)
  schemas.push {name:schemaName, schema}
if 1 # Phone
  schemaName = 'Phone'
  schema = Phone = new Schema
    sort: Number # empty = primary, otherwise sort order
    type: 
      # l=landline, m=mobile, v=voice over internet, p=pager, f=fax
      type: String, enum: ['l', 'm', 'v', 'p', 'f'] 
    countryCode: String
    areaCode: String 
    number: {type: String, required: true}
    ext: {type: String} # extension, add validation for only numbers
    note: String
  schema.virtual("phoneFull").get ->
    ret = ''
    ret += ('+' + @countryCode + ' ') if @countryCode
    ret += ('(' + @areaCode + ') ') if @areaCode
    ret += @number
    ret += ('x' + @ext) if @ext
    return ret
  schema.plugin lastMod
  exports[schemaName] = mongoose.model(schemaName, schema)
  schemas.push {name:schemaName, schema}
if 1 # Contact
  schemaName = 'Contact'
  schema = Contact = new Schema
    # Primary
    isUser: Boolean # link to user if applicable
    statusTags: [String] # [DO_NOT_CALL, NH, ETC]
    affiliationTags: [String] # [Professional, etc]
    typeId: String # Empty = person, org=organization, cong=congregation, div=division, br=branch, grp=group
    code: String # assigned as applicable
    industryId: String # retail, manufacturing, education, government, theocratic
    nameShort: String # company abbreviation or person initials
    nickName: String # company or personal nickname
    # Status
    tags: [String] # [park, dining, coffee, parking, shopping]
    status: String # [DO_NOT_CALL, NH, ETC]
    notes: [Note] # Note Object
    log: [Event]
    adminNote: String    
    # Person
    title: String # Mr, Mrs, Ms, etc
    firstName: String
    middleName: String
    lastName: String
    maidenName: String
    suffix: String
    gender: String
    anniversaries: [Event]
    languages: [ContactLang]
    familyTags: [String] # married, single, minor, headofhouse, etc
    professionTags: [String] # doctor, teacher, etc
    skillTags: [String] # painter, etc
    hobbyTags: [String] # music, etc
    pets: [String] # dog:spot, etc
    pics: [String] # profile pictures
    # Entity
    companyName: String
    division: String
    department: String
  # Virtual Attributes
  ###
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
  ###
  schema.plugin lastMod
  exports[schemaName] = mongoose.model(schemaName, schema) 
  schemas.push {name:schemaName, schema}
if 1 # Place
  schemaName = 'Place'
  if 1
    placeTypes = ['c-clinic','c-dinning','c-factory','c-hospital','c-mall','c-police','c-school','c-shopping','g-lake','g-river','l-monument','l-statue','o-world','o-zone','o-language','o-district','o-circuit','o-cong','o-group','o-subGroup','o-territory','o-subTerritory','o-block','p-hemisphere','p-continent','p-country','p-stateProvince','p-county','p-locality','p-subLocality','p-neighborhood','p-premise','p-subPremise','p-floor']
    ###
    p-locality #city
    p-subLocality # like ? in CR
    p-neighborhood # like ?
    p-premise # Collection of buildings
    p-subPremise # usually a singular building within a collection
    ###
  schema = Place = new Schema
    # Primary
    ###
    need a short human friendly unique ID that user can easily use to find by: p<id>
    c=commercial, g=geographic, l=landmark, m=mixed, o=organizational, p=political, r=residence
    ###
    id: String 
    class: {type:String, enum: ['c','e','g','m','o','p','r']}
    # depending on the place class, user pick from corresponding type
    type: {type: String, enum: placeTypes}
    multipleUnits: Boolean # inicates multiple units, ie, condominiums, tenants, etc
    multipleLevels: Boolean # inicates multiple floors/levels
    name: String # if applicable
    nameShort: String # abbreviation if applicable
    nickname: String # indicates a commonly-used alternative name for the 
    code: String # assigned to place as applicable
    sort: Number # empty = primary, otherwise sort order
    # Status
    status: String # [DO_NOT_CALL, NH, ETC]
    log: [Event]
    # Location
    addrStrName: String # street/route name part of address
    addrStrAddr: String # number part of an address
    addrFloor: String  # the floor of a building address.
    addrSuiteApt: String # number/letter that represents a single unit/apartment in multiunit structure
    address: String # If any of the addr parts are provided, address will format address from them
    ###
    In the UI, user picks San Diego city, find or add, and use this Place
    Theoretically, user picks from existing paths of 'places' or
    fills in typical: Country, State, County, City, etc.
    from these, Place docs are created and linked together
    ultimately THIS place can only link to ONE 'location' Place
    To build location path for example:
    This residence Place belongs to a neighborhood which belongs to a city which belongs to a state, etc
    ###
    location: [Place] 
    # Geo
    boundary: {} # array of points/locs # boundary of place if an area is involved
    boundaryConfirmed: Boolean # empty = unconfirmed
    box: {} # top-left lng-lat, bottom-right lng-lat
    loc: [Number, Number] # LNG,LAT, if this involves a boundary, loc becomes center pt
    locConfirmed: Boolean # empty = unconfirmed
    # Associations
    ###
    This place may belong to organizational places/territories
    ie, this Place.territory may belong to a Place.SalesDistrict
    PlaceAssoc.California -> includes -> Place.San Diego
    ###
    belongsTo: [Place] 
    intersection: String # major intersection, usually of two major roads.
    adminNote: String
    # Description
    accessTags: [String] # [restricted, intercom, guard]
    color1: {type: String, enum: ['white', 'black', 'etc']} # prominent color
    color2: {type: String, enum: ['white', 'black', 'etc']} # secondary color
    description: String # other identifying details
    tags: [String] # [park, dining, coffee, parking, shopping]
    toNext: String # option for directions to the next place
    # Details
    notes: [Note]
    phones: [Phone] # this place could be a general business
    emails: [Email]
    urls: [URL]
    contacts: [Contact]


  # Cached Virtual Attributes
  ###
  lastEventOn: latest log date
  lastEventBy: associated userName 
  path: of ancestors, ie, ['Costa Rica', 'Heredia', 'Belen']
  pathShort: version of ancestors, ie, cr/her?/belen
  name:
  nameShort:      
  addressFull: Automatically filled in with address parts if provided.
  ###    
  schema.plugin lastMod
  exports[schemaName] = mongoose.model(schemaName, schema)
  schemas.push {name:schemaName, schema}
if 1 # User
  schemaName = 'User'
  schema = User = new Schema
    contact_id: [Contact] # link to contact record (sync'd)
    provider: String # ie, twitter, facebook, etc
    uid: String # provider user id
    name: String
    image: String # profile image
  schema.plugin lastMod
  exports[schemaName] = mongoose.model(schemaName, schema)
  schemas.push {name:schemaName, schema}

#console.log schemas
#console.log schemas[0].schema.paths.type
exports.schemas = schemas


