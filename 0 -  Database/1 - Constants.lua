--------------------------------------------------------
--                       Constants                    --
--------------------------------------------------------

function utf8(n)
    return string.uchar(n)
end

SubNumbers={185, 178, 179, 8308, 8309, 8310, 8311, 8312, 8313}

function numberToSub(w,n)
    return w..utf8(SubNumbers[tonumber(n)])
end

function refCon()
    local t2 = {}
    for k,v in ipairs(Constants) do	
        t2[k] = {v.info,v.key,v.value.." "..v.unit}
    end
    return t2
end

Constants = {
{key="g", info="Acceleration due to gravity", value="-9.81", unit="m*s^2"},p
{key="G", info="Gravitational constant", value="6.67*10^(-11)", unit="Nm^2/kg^-2"},
{key="N", info="Avogadro's constant", value="6.022*10^(23)", unit="mol^-1"},
{key="R", info="Gas constant", value="8.314", unit="J/((mol^-1)*(K^-1))"},
{key="k1", info="Boltzmann's constant", value="1.38*10^(-23)", unit="J/K^-1"},
{key="k2", info="Stefan-Boltzmann constant", value="5.67 * 10^-8", unit="W*m^-2*K^-1"},
{key="k3", info="Coulomb constant", value="8.99 * 10^9", unit="N*m^2*C^-2"},
{key="C", info="Speed of light in vacuum", value="2.9979*10^(8)", unit="m/s"},
{key="h", info="Planck constant", value="6.626*10^(-34)", unit="J/s"},
{key="q", info="Elementary charge", value="1.60218*10^(-19)", unit="C"},
{key="me", info="Electron rest mass", value="9.109*10^(-31)", unit="kg"},
{key="mp", info="Proton rest mass", value="1.6726*10^(-27)", unit="kg"},
{key="mn", info="Neutron rest mass", value="1.675*10^(-27)", unit="kg"},
{key="mu", info="Atomic mass unit", value="1.66*10^(-27)", unit="kg"},
{key=utf8(949).."0", info="Permittivity of a vacuum", value="8.854*10^(-12)", unit="F/m^-1"},
{key=utf8(956).."0", info="Permeability of a vacuum", value="4*pi*10^(-7)", unit="N/A^-2"}
}

function con(i)
    for k,v in ipairs(Constants) do
        if Constants[k].key == i then
            return Constants[k].value
        end
    end
    return 0
end


