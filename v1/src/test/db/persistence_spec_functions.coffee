should = require("should")

create_entity_with_reference_and_check_populate = (data) ->
  describe "when " + data.entityName + " is saved with a reference to an existing " + data.referenceName, ->
    referencedEntity = null
    entity = null
    beforeEach (done) ->
      entity = data.getEntityFn()
      referencedEntity = data.buildReferenceEntityFn()
      referencedEntity.save (err) ->
        should.not.exist err
        entity[data.referenceName] = referencedEntity.id
        entity.save (err) ->
          should.not.exist err
          done()



    if data.remove_entity_in_afterEach
      afterEach (done) ->
        entity.remove (err) ->
          should.not.exist err
          done()


    describe "when we specify that " + data.referenceName + " should be populated when we retrieve " + data.entityName, ->
      retrievedEntity = null
      error = null
      beforeEach (done) ->
        data.entityModel.findById(entity.id).populate(data.referenceName).run (err, result) ->
          error = err
          retrievedEntity = result
          done()


      it "should not fail", ->
        should.not.exist error

      it "should populate the " + data.referenceName + " property in the returned " + data.entityName, ->
        data.equalityFn referencedEntity, retrievedEntity[data.referenceName]



module.exports = create_entity_with_reference_and_check_populate: create_entity_with_reference_and_check_populate