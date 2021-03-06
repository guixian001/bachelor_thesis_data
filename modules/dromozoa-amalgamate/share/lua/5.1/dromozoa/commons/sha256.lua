-- Copyright (C) 2015-2017 Tomoyuki Fujimori <moyu@dromozoa.com>
--
-- This file is part of dromozoa-commons.
--
-- dromozoa-commons is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- dromozoa-commons is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with dromozoa-commons.  If not, see <http://www.gnu.org/licenses/>.

local sequence = require "dromozoa.commons.sequence"
local sha = require "dromozoa.commons.sha"
local uint32 = require "dromozoa.commons.uint32"
local word_block = require "dromozoa.commons.word_block"

local add = uint32.add
local bxor = uint32.bxor
local shr = uint32.shr
local rotr = uint32.rotr

local Ch = sha.Ch
local Maj = sha.Maj

local K = {
  0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
  0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
  0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
  0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
  0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
  0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
  0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
  0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
  0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
  0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
  0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
  0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
  0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
  0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
  0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
  0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
}

local function sum0(x)
  return bxor(rotr(x, 2), rotr(x, 13), rotr(x, 22))
end

local function sum1(x)
  return bxor(rotr(x, 6), rotr(x, 11), rotr(x, 25))
end

local function sigma0(x)
  return bxor(rotr(x, 7), rotr(x, 18), shr(x, 3))
end

local function sigma1(x)
  return bxor(rotr(x, 17), rotr(x, 19), shr(x, 10))
end

local super = sha
local class = {
  hex_format = ("%02x"):rep(32);
}

function class.new()
  return class.reset({
    M = word_block(16, ">");
    W = sequence();
    H = sequence();
    L = 0;
  })
end

function class:reset()
  local H = self.H
  H[1] = 0x6a09e667
  H[2] = 0xbb67ae85
  H[3] = 0x3c6ef372
  H[4] = 0xa54ff53a
  H[5] = 0x510e527f
  H[6] = 0x9b05688c
  H[7] = 0x1f83d9ab
  H[8] = 0x5be0cd19
  return self
end

function class:compute()
  local M = self.M
  local W = self.W
  local H = self.H

  for t = 1, 16 do
    W[t] = M[t]
  end
  for t = 17, 64 do
    W[t] = add(sigma1(W[t - 2]), W[t - 7], sigma0(W[t - 15]), W[t - 16])
  end

  local H1 = H[1]
  local H2 = H[2]
  local H3 = H[3]
  local H4 = H[4]
  local H5 = H[5]
  local H6 = H[6]
  local H7 = H[7]
  local H8 = H[8]

  local a, b, c, d, e, f, g, h = H1, H2, H3, H4, H5, H6, H7, H8

  for t = 1, 64 do
    local T1 = add(h, sum1(e), Ch(e, f, g), K[t], W[t])
    local T2 = add(sum0(a), Maj(a, b, c))
    h = g
    g = f
    f = e
    e = add(d, T1)
    d = c
    c = b
    b = a
    a = add(T1, T2)
  end

  H[1] = add(a, H1)
  H[2] = add(b, H2)
  H[3] = add(c, H3)
  H[4] = add(d, H4)
  H[5] = add(e, H5)
  H[6] = add(f, H6)
  H[7] = add(g, H7)
  H[8] = add(h, H8)
end

function class.bin(message)
  return class():update(message):finalize("bin")
end

function class.hex(message)
  return class():update(message):finalize("hex")
end

function class.hmac(K, text, encode)
  return super.hmac(class, K, text, encode)
end

class.metatable = {
  __index = class;
}

return setmetatable(class, {
  __index = super;
  __call = function ()
    return setmetatable(class.new(), class.metatable)
  end;
})
