local Types = {}


-- Basic Types
type OddsTableEntry = { weight: number | "fill", value: any }
export type OddsTable = { OddsTableEntry }


export type Stat = "strength" | "agility" | "vitality" | "magic"


return Types