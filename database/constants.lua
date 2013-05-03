--@@  constants.lua
--@@  LGLP 3 License
--@@  alex3yoyo

Constants = {
{key="g",   info="Acceleration due to gravity", val="-9.81",                unit="m/s"..s.s2},
{key="G",   info="Gravitational constant",      val="6.67*10^(-11)",        unit="Nm"..s.s2.."/kg"..s.s2h},
{key="N",   info="Avogadro's constant",         val="6.022*10^(23)",        unit="mol"..s.s1h},
{key="R",   info="Gas constant",                val="8.314",                unit="J/((mol"..s.s1h..")"..s.bul.."(K"..s.s1h.."))"},
{key="k1",  info="Boltzmann's constant",        val="1.38*10^(-23)",        unit="J/K"..s.s1h},
{key="k2",  info="Coulomb constant",            val="8.99*10^9",            unit="N"..s.bul.."m"..s.s2..s.bul.."C"..s.s2h},
{key="k3",  info="Stefan-Boltzmann constant",   val="5.67*10^-8",           unit="W"..s.bul.."m"..s.s2h..s.bul.."K"..s.s1h},
{key="C",   info="Speed of light in vacuum",    val="2.9979*10^(8)",        unit="m/s"},
{key="h",   info="Planck constant",             val="6.626*10^(-34)",       unit="J/s"},
{key="q",   info="Elementary charge",           val="1.60218*10^(-19)",     unit="C"},
{key="me",  info="Electron rest mass",          val="9.109*10^(-31)",       unit="kg"},
{key="mp",  info="Proton rest mass",            val="1.6726*10^(-27)",      unit="kg"},
{key="mn",  info="Neutron rest mass",           val="1.675*10^(-27)",       unit="kg"},
{key="mu",  info="Atomic mass unit",            val="1.66*10^(-27)",        unit="kg"},
{key=g.ep[2].."0", info="Permittivity of a vacuum", val="8.854*10^(-12)",   unit="F/m"..s.s1h},
{key=utf8(956).."0", info="Permeability of a vacuum", val="4*pi*10^(-7)",   unit="N/A"..s.s2h}
}

function con(i) -- Shortcut for using constants in the database part
    for k,v in ipairs(Constants) do
        if Constants[k].key == i then
            return Constants[k].val
        end
    end
    return "undef"
end

function refCon() -- Makes the constants reference page
    local t2 = {}

    for k,v in ipairs(Constants) do
        t2[k] = {v.info,v.key,v.val.." "..v.unit}
    end
    return t2
end
