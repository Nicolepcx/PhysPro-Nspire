
References	= {
	{ title="SI Prefixes",              info="",        screen=SIPrefixes       },
	{ title="Greek Alphabet",           info="",        screen=Greek            },
	{ title="Motion Variables",         info="",        screen=MotionVars       },
	{ title="Displacement Units",       info="",        screen=RefDisplacement  },
	{ title="Velocity Units",           info="",        screen=RefVelocity      },
	{ title="Acceleration Units",       info="",        screen=RefAcceleration  },
	{ title="Time Units",               info="",        screen=RefTime          },
	{ title="Force Units",              info="",        screen=RefForce         },
	{ title="Energy Units",             info="",        screen=RefEnergy        },
	{ title="Power Units",              info="",        screen=RefPower         },
	{ title="Constants",                info="",        screen=REFConstants     }
}

Ref	= WScreen()

RefList	= sList()
RefList:setSize(-8, -32)

Ref:appendWidget(RefList, 4, Ref.y+28)

function Ref.addRefs()
	for n, ref in ipairs(References) do
		if ref.screen then
			table.insert(RefList.items, ref.title)
		else
			table.insert(RefList.items, ref.title .. " (not yet done)")
		end
	end
end

function RefList:action(ref)
	if References[ref].screen then
		push_screen(References[ref].screen)
	end
end

function Ref:pushed()
	RefList:giveFocus()
end

function Ref:paint(gc)
    gc:setFont("sansserif", "b", 16)
    gc:drawString("Reference", self.x+6, -2, "top")
    gc:setFont("serif", "r", 12)
end

function Ref:tabKey()
    push_screen(CategorySel)
end

Ref.escapeKey = Ref.tabKey

Ref.addRefs()

