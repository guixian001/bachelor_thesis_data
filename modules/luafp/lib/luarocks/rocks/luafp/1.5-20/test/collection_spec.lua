local collection = require 'luafp.collection'

describe("src/collection.lua", function()
    describe('length', function()
        it('should give 3 for a table of 3', function()
            assert.are.equals(3, collection.length({1, 2, 3}))
        end)
        it('should give 0 for a table of 0', function()
            assert.are.equals(0, collection.length({}))
        end)
        it('should give 0 for a cow', function()
            assert.are.equals(0, collection.length('cow'))
        end)
    end)
    describe('map', function()
        it('should give cow for raw', function()
            local result = collection.map(function() return 'cow' end)({'raw'})
            assert.are.same({'cow'}, result)
        end)
        it('should not give chicken for raw', function()
            local result = collection.map(function() return 'cow' end)({'raw'})
            assert.are_not.same({'chicken'}, result)
        end)
        it('should add nums for map ones', function()
            local add1 = function(i) return i + 1 end
            local result = collection.map(add1)({1, 2, 3})
            assert.are.same({2, 3, 4}, result)
        end)
    end)
    describe('filter', function()
        it('should filter out cows', function()
            local isCow = function(o) return o == 'cow' end
            local result = collection.filter(isCow)({'a', 'cow', 'b'})
            assert.are.same({'cow'}, result)
        end)
        it('should filter out cows if there are none should be empty', function()
            local isCow = function(o) return o == 'cow' end
            local result = collection.filter(isCow)({'a', 'b', 'c'})
            assert.True(collection.length(result) == 0)
        end)
        -- it('should filter out complex people', function()
        --     local isPerson = function(o)

        --     local result = collection.filter(isCow)({'a', 'cow', 'b'})
        --     assert.are.same({'cow'}, result)
        -- end)
    end)
end)