DefinitionBlock("", "SSDT", 2, "hack", "I2C-SPED", 0)
{
    External(_SB_.PCI0.I2C0, DeviceObj)
    External(FMD0, IntObj)
    External(FMH0, IntObj)
    External(FML0, IntObj)
    External(SSD0, IntObj)
    External(SSH0, IntObj)
    External(SSL0, IntObj)
    
    Method (PKGX, 3, Serialized)
    {
        Name (PKG, Package (0x03)
        {
            Zero, 
            Zero, 
            Zero
        })
        PKG [Zero] = Arg0
        PKG [One] = Arg1
        PKG [0x02] = Arg2
        Return (PKG) /* \PKGX.PKG_ */
    }
    
    Scope (_SB.PCI0.I2C0)
    {
        Method (SSCN, 0, NotSerialized)
        {
            Return (PKGX (SSH0, SSL0, SSD0))
        }

        Method (FMCN, 0, NotSerialized)
        {
            Return (PKGX (FMH0, FML0, FMD0))
        }
    }
}
