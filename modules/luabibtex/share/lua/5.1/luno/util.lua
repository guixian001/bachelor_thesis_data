-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2013 Eric Chiesse de Souza (www.echiesse.com.br)
-- Read "License.txt" for the license terms
-- *****************************************************************************

require"luno.base"


luno.util = {} -- Apenas para dizer que "luno.util" está carregado

--------------------------------------------------------------------------------
--  Escolhe uma das duas opções conforme a condição seja verdadeira ou falsa.
--  @param condition  Condição a ser avaliada.
--  @param valueTrue  Valor a ser retornado caso a expressão seja verdadeira.
--  @param valueFalse Valor a ser retornado caso a expressão seja falsa.
--  @return    Retorna "valueTrue" se "condition" for avaliado como verdadeiro
--         ou "valueFalse" se "condition" for avaliado como falso.
function choose(condition, valueTrue, valueFalse)
    if condition then
        return valueTrue
    else
        return valueFalse
    end
end


--------------------------------------------------------------------------------
--  Imprime uma tabela em profundidade
--  @param val    Valor ou tabela a ser impresso
--  @param level  Profundidade atual da variavel a ser impressa.
--  @param lookup Tabela que guarda as tabelas já impressas para evitar recursões infinitas
--  O valor padrão é nil
local function _printDeep(val, level, lookup)
    level = level or 0
    local indentStep = "    "
    local indent = ""
    for i = 1, level do indent = indent .. indentStep end

    lookup = lookup or {}
    if type(val) == "table" then
        lookup[val] = true
        for i, v in pairs(val) do
            if type(v) == "table" then
                print(indent .. tostring(i) .. ": (" .. tostring(v) .. "):")
                if lookup[v] == nil then
                    _printDeep(v, level + 1, lookup)
                end
            else
                print(indent .. tostring(i) .. ": " .. tostring(v))
            end
        end
    else
        print(indent .. tostring(val))
    end
    return ret
end


--------------------------------------------------------------------------------
--  Imprime uma tabela em profundidade
--  @param val   Valor ou tabela a ser impresso
--  O valor padrão é nil
function printDeep(val)
    return _printDeep(val)
end


local function _copy(val, lookup)
    local ret
    lookup = lookup or {}
    if type(val) == "table" then
        if lookup[val] ~= nil then
            ret = lookup[val]
        else
            ret = {}
            lookup[val] = ret
            for i, v in pairs(val) do
                local index = lookup[i] or _copy(i, lookup)
                local value = lookup[v] or _copy(v, lookup)
                ret[index] = value
            end
        end
    else
        ret = val
    end
    return ret
end

--------------------------------------------------------------------------------
--  Copia uma variável lua em profundidade. Caso seja uma tabela que contenha
--  ciclos, esses são tratados adequadamente.
--
--  @param val Valor a ser copiado
--  @return    A cópia do valor de entrada
function copy(val)
    return _copy(val)
end

--------------------------------------------------------------------------------
--  Expõe os campos da tabela para o ambiente global (_G)
--  @param tab A tabela a ser exposta.
function expose(tab)
    for i, v in pairs(tab) do
        if type(i) == "string" then
            _G[i] = v
        end
    end
end


function exposeOnly(tab, keys)
    for i, v in ipairs(keys) do
        if type(v) == "string" then
            _G[v] = tab[v]
        end
    end
end


function pack(...)
    return {...}
end

