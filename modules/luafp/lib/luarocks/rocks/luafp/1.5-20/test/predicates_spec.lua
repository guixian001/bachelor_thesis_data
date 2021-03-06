local predicates = require 'luafp.predicates'

describe("src/predicates.lua", function()
    describe('isNil', function()
        it('should be true for nil', function()
            assert.True(predicates.isNil(nil))
        end)
        it('should be false for 1', function()
            assert.False(predicates.isNil(1))
        end)
    end)
    describe("isBoolean", function()
        it("should be true for true", function()
            assert.True(predicates.isBoolean(true))
        end)
        it("should be true for false", function()
            assert.True(predicates.isBoolean(false))
        end)
        it("should be false for number", function()
            assert.False(predicates.isBoolean(1))
        end)
    end)
    describe('isNumber', function()
        it('should be true for number', function()
            assert.True(predicates.isNumber(1))
        end)
        it('should be false for string', function()
            assert.False(predicates.isNumber('cow'))
        end)
    end)
    describe('isString', function()
        it('should be true for string', function()
            assert.True(predicates.isString('cow'))
        end)
        it('should be false for number', function()
            assert.False(predicates.isString(1))
        end)
    end)
    describe('isFunction', function()
        it('should be true for function', function()
            assert.True(predicates.isFunction(function() return true end))
        end)
        it('should be false for coroutine', function()
            co = coroutine.create(function ()
                print("hi")
            end)
            assert.False(predicates.isFunction(co))
        end)
        it('should be false for number', function()
            assert.False(predicates.isFunction(1))
        end)
    end)
    describe('isThread', function()
        it('should be true for coroutine', function()
            co = coroutine.create(function ()
                print("hi")
            end)
            assert.True(predicates.isThread(co))
        end)
        it('should be false for number', function()
            assert.False(predicates.isThread(1))
        end)
    end)
    describe('isTable', function()
        it('should be true for table', function()
            assert.True(predicates.isTable({}))
        end)
        it('should be false for number', function()
            assert.False(predicates.isTable(1))
        end)
    end)


    

end)