if not WeakAuras.IsCorrectVersion() then return end
local AddonName, Private = ...

-- Legendaries based on https://wow.tools/dbc/?dbc=runeforgelegendaryability
-- mapping legendary id to bonus id
local legendariesToBonusId = {
  [2] = 6823,
  [3] = 6828,
  [4] = 6829,
  [5] = 6830,
  [6] = 6831,
  [7] = 6832,
  [8] = 6937,
  [9] = 6834,
  [10] = 6931,
  [11] = 6932,
  [12] = 6933,
  [13] = 6934,
  [14] = 6926,
  [15] = 6927,
  [16] = 6928,
  [17] = 6936,
  [18] = 7041,
  [19] = 7042,
  [20] = 7043,
  [21] = 7044,
  [22] = 7049,
  [23] = 7050,
  [24] = 7051,
  [25] = 7052,
  [26] = 7045,
  [27] = 7046,
  [28] = 7047,
  [29] = 7048,
  [30] = 6953,
  [31] = 6954,
  [32] = 6947,
  [33] = 6948,
  [34] = 6940,
  [35] = 6941,
  [36] = 6943,
  [37] = 6942,
  [38] = 6944,
  [39] = 6945,
  [40] = 6946,
  [41] = 7160,
  [42] = 6949,
  [43] = 6950,
  [44] = 6951,
  [45] = 6952,
  [46] = 7086,
  [47] = 7085,
  [48] = 7110,
  [49] = 7084,
  [50] = 7087,
  [51] = 7088,
  [52] = 7107,
  [53] = 7108,
  [54] = 7109,
  [55] = 7091,
  [56] = 7090,
  [57] = 7089,
  [58] = 7092,
  [59] = 7093,
  [60] = 7094,
  [61] = 7095,
  [62] = 7096,
  [63] = 7097,
  [64] = 7098,
  [65] = 7099,
  [66] = 7003,
  [67] = 7004,
  [68] = 7005,
  [69] = 7006,
  [70] = 7007,
  [71] = 7008,
  [72] = 7009,
  [73] = 7010,
  [74] = 7011,
  [75] = 7012,
  [76] = 7013,
  [77] = 7014,
  [78] = 7015,
  [79] = 7016,
  [80] = 7017,
  [81] = 7018,
  [82] = 7184,
  [83] = 7082,
  [84] = 7080,
  [85] = 7081,
  [86] = 7076,
  [87] = 7077,
  [88] = 7078,
  [89] = 7079,
  [90] = 7075,
  [91] = 7073,
  [92] = 7074,
  [93] = 7072,
  [94] = 7070,
  [95] = 7068,
  [96] = 7071,
  [97] = 7069,
  [98] = 7053,
  [100] = 7055,
  [101] = 7056,
  [102] = 7128,
  [103] = 7059,
  [104] = 7057,
  [105] = 7058,
  [106] = 7060,
  [107] = 7061,
  [108] = 7062,
  [109] = 7063,
  [110] = 7067,
  [111] = 7066,
  [112] = 7065,
  [113] = 7064,
  [114] = 7114,
  [115] = 7113,
  [116] = 7112,
  [117] = 7111,
  [118] = 7115,
  [119] = 7116,
  [120] = 7117,
  [121] = 7118,
  [122] = 7122,
  [123] = 7121,
  [124] = 7120,
  [125] = 7119,
  [126] = 7123,
  [127] = 7124,
  [128] = 7125,
  [129] = 7126,
  [130] = 6985,
  [131] = 6986,
  [132] = 6987,
  [133] = 6988,
  [134] = 6989,
  [135] = 6990,
  [136] = 6991,
  [137] = 6992,
  [138] = 6993,
  [139] = 6994,
  [140] = 6995,
  [141] = 6996,
  [142] = 6997,
  [143] = 6998,
  [144] = 6999,
  [145] = 7000,
  [146] = 7161,
  [147] = 7002,
  [148] = 6975,
  [149] = 6972,
  [150] = 6976,
  [151] = 6978,
  [152] = 6979,
  [153] = 6980,
  [154] = 6984,
  [155] = 6977,
  [156] = 6974,
  [157] = 6973,
  [158] = 6981,
  [159] = 6982,
  [160] = 6983,
  [161] = 7162,
  [162] = 7025,
  [163] = 7026,
  [164] = 7027,
  [165] = 7028,
  [166] = 7029,
  [167] = 7030,
  [168] = 7031,
  [169] = 7032,
  [170] = 7033,
  [171] = 7034,
  [172] = 7035,
  [173] = 7036,
  [174] = 7037,
  [175] = 7038,
  [176] = 7039,
  [177] = 7040,
  [178] = 6955,
  [179] = 6971,
  [180] = 6958,
  [181] = 6959,
  [182] = 6962,
  [183] = 6960,
  [184] = 6961,
  [185] = 6970,
  [186] = 6963,
  [187] = 6964,
  [188] = 6965,
  [189] = 6966,
  [190] = 6956,
  [191] = 6957,
  [192] = 6967,
  [193] = 6969,
  [196] = 7054,
  [199] = 7100,
  [200] = 7101,
  [201] = 7102,
  [202] = 7103,
  [203] = 7104,
  [204] = 7105,
  [205] = 7106,
  [206] = 7159,
}

local bonusIdToLegendary = {}
for k, v in pairs(legendariesToBonusId) do
  bonusIdToLegendary[v] = k
end

WeakAuras.GetLegendariesBonusIds = function()
  if WeakAuras.IsClassic() then
    return ""
  end

  local classId = select(3, UnitClass('player'))
  local specId = GetSpecializationInfo(GetSpecialization())

  local powers = C_LegendaryCrafting.GetRuneforgePowersByClassAndSpec(classId, specId)
  local abilities = {}
  local names = {}
  for _, power in ipairs(powers) do
    local info = C_LegendaryCrafting.GetRuneforgePowerInfo(power)
    if legendariesToBonusId[info.runeforgePowerID] then
      abilities[info.name] = {legendariesToBonusId[info.runeforgePowerID], info.iconFileID }
      tinsert(names, info.name)
    end
  end

  table.sort(names)

  local result = ""
  for index, name in ipairs(names) do
    result = result .. "|T".. abilities[name][2] .. ":16|t  " ..  name .. ": " .. abilities[name][1] .. "\n"
  end
  return result
end

WeakAuras.GetLegendaryData = function(id)
  if WeakAuras.IsClassic() then
    return ""
  end
  local legendaryID = bonusIdToLegendary[tonumber(id)]
  if legendaryID then
    local data = C_LegendaryCrafting.GetRuneforgePowerInfo(legendaryID)
    return data.name, data.iconFileID
  end
end

