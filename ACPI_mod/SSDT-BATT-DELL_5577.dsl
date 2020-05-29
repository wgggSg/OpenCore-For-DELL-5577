// DELL_5577 battery
// In config ACPI, _BST(N) renamed XBST(N)
// Find:     5F 42 53 54 00
// Replace:  58 42 53 54 00
//
// In config ACPI, _BIF(S) renamed XBIF(S)
// Find:     5F 42 49 46 08
// Replace:  58 42 49 46 08
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0x00000000)
{
    External (_SB.PCI0.LPCB.EC, DeviceObj)
    External (_SB.PCI0.LPCB.BAT0, DeviceObj)
    External (_SB.PCI0.LPCB.ECOK, MethodObj)
    External (_SB.PCI0.LPCB.BAT0.ITOS, MethodObj)
    External (_SB.PCI0.LPCB.EC.MUTX, MutexObj)
    External (_SB.PCI0.LPCB.BAT0.BFB0, PkgObj)
    External (_SB.PCI0.LPCB.BAT0.PAK0, PkgObj)
    External (PWRS, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC.BCNT, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC.B0DC, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC.B0IC, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC.B0CL, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC.DNN0, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC.BCN0, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC.MNN0, FieldUnitObj)
    External (_SB.PCI0.LPCB.BAT0.XBST, MethodObj)
    External (_SB.PCI0.LPCB.BAT0.XBIF, MethodObj)

    Method (B1B2, 2, NotSerialized)
    {
        Return ((Arg0 | (Arg1 << 0x08)))
    }

    Method (W16B, 3, NotSerialized)
    {
        Arg0 = Arg2
        Arg1 = (Arg2 >> 0x08)
    }

    Scope (_SB.PCI0.LPCB.EC)
    {
        OperationRegion (XCRM, EmbeddedControl, Zero, 0x0100) //ECRM
        Field (XCRM, ByteAcc, Lock, Preserve) //ECRM
        {
            Offset (0xA0), 
            CAP2,    8,    //CAP0
            CAP3,    8,
            Offset (0xA4),
            VOT2,    8,    //VOT0
            VOT3,    8,
            CRT2,    8,    //CRT0
            CRT3,    8,
            Offset (0xAE),
            FCP2,    8,    //FCP0
            FCP3,    8,    
            DCP2,    8,    //DCP0
            DCP3,    8,
            DVT2,    8,    //DVT0
            DVT3,    8,
            Offset (0xB8),
            BSN2,    8,    //BSN0
            BSN3,    8,
            Offset (0xDA),
            BST3,    8,    //BST1
            BST4,    8
        }
    }

    Scope (_SB.PCI0.LPCB.BAT0)
    {
        Method (_BIF, 0, Serialized)  // _BIF: Battery Information
        {
            If (_OSI ("Darwin"))
            {
                If (ECOK ())
                {
                    Acquire (^^EC.MUTX, 0xFFFF)
                    PAK0 [One] = B1B2 (^^EC.DCP2, ^^EC.DCP3)
                    Local0 = B1B2 (^^EC.FCP2, ^^EC.FCP3)
                    Store (Local0, Index (PAK0, 0x02))
                    PAK0 [0x04] = B1B2 (^^EC.DVT2, ^^EC.DVT3)
                    Store (^^EC.DNN0, Local1)
                    Local2 = B1B2 (^^EC.BSN2, ^^EC.BSN3)
                    Store (^^EC.BCN0, Local3)
                    Store (^^EC.MNN0, Local4)
                    Release (^^EC.MUTX)
                    Store (Divide (Local0, 0x0A, ), Index (PAK0, 0x05))
                    Store (Zero, Index (PAK0, 0x06))
                    Switch (ToInteger (Local1))
                    {
                        Case (Zero)
                        {
                            Store ("Unknow", Index (PAK0, 0x09))
                        }
                        Case (0xFF)
                        {
                            Store ("Dell", Index (PAK0, 0x09))
                        }

                    }

                    Store (ITOS (ToBCD (Local2)), Index (PAK0, 0x0A))
                    Switch (ToInteger (Local3))
                    {
                        Case (Zero)
                        {
                            Store ("Unknow", Index (PAK0, 0x0B))
                        }
                        Case (One)
                        {
                            Store ("PBAC", Index (PAK0, 0x0B))
                        }
                        Case (0x02)
                        {
                            Store ("LION", Index (PAK0, 0x0B))
                        }
                        Case (0x03)
                        {
                            Store ("NICD", Index (PAK0, 0x0B))
                        }
                        Case (0x04)
                        {
                            Store ("NIMH", Index (PAK0, 0x0B))
                        }
                        Case (0x05)
                        {
                            Store ("NIZN", Index (PAK0, 0x0B))
                        }
                        Case (0x06)
                        {
                            Store ("RAM", Index (PAK0, 0x0B))
                        }
                        Case (0x07)
                        {
                            Store ("ZNAR", Index (PAK0, 0x0B))
                        }
                        Case (0x08)
                        {
                            Store ("LIP", Index (PAK0, 0x0B))
                        }

                    }

                    Switch (ToInteger (Local4))
                    {
                        Case (Zero)
                        {
                            Store ("Unknown", Index (PAK0, 0x0C))
                        }
                        Case (One)
                        {
                            Store ("Dell", Index (PAK0, 0x0C))
                        }
                        Case (0x02)
                        {
                            Store ("SONY", Index (PAK0, 0x0C))
                        }
                        Case (0x03)
                        {
                            Store ("SANYO", Index (PAK0, 0x0C))
                        }
                        Case (0x04)
                        {
                            Store ("PANASONIC", Index (PAK0, 0x0C))
                        }
                        Case (0x05)
                        {
                            Store ("SONY_OLD", Index (PAK0, 0x0C))
                        }
                        Case (0x06)
                        {
                            Store ("SDI", Index (PAK0, 0x0C))
                        }
                        Case (0x07)
                        {
                            Store ("SIMPLO", Index (PAK0, 0x0C))
                        }
                        Case (0x08)
                        {
                            Store ("MOTOROLA", Index (PAK0, 0x0C))
                        }
                        Case (0x09)
                        {
                            Store ("LGC", Index (PAK0, 0x0C))
                        }

                    }
                }

                Return (PAK0)
            }
            Else
            {
                Return (XBIF ())
            }
        }
        
        Method (_BST, 0, NotSerialized)  // _BST: Battery Status
        {
            If (_OSI ("Darwin"))
            {
                If (ECOK ())
                {
                    Acquire (^^EC.MUTX, 0xFFFF)
                    Store (^^EC.B0DC, Local0)
                    Store (^^EC.B0IC, Local1)
                    ShiftLeft (Local1, One, Local1)
                    Add (Local0, Local1, Local0)
                    Store (^^EC.B0CL, Local1)
                    Release (^^EC.MUTX)
                    ShiftLeft (Local1, 0x02, Local1)
                    Add (Local0, Local1, Local0)
                    Store (Local0, Index (BFB0, Zero))
                    Acquire (^^EC.MUTX, 0xFFFF)
                    BFB0 [0x02] = B1B2 (^^EC.CAP2, ^^EC.CAP3)
                    BFB0 [0x03] = B1B2 (^^EC.VOT2, ^^EC.VOT3)
                    Release (^^EC.MUTX)
                    Acquire (^^EC.MUTX, 0xFFFF)
                    Local0 = B1B2 (^^EC.CRT2, ^^EC.CRT3)
                    Release (^^EC.MUTX)
                    If (LEqual (Local0, Zero))
                    {
                        Increment (Local0)
                    }
                    ElseIf (PWRS)
                    {
                        If (And (Local0, 0x8000))
                        {
                            Store (Ones, Local0)
                        }
                    }
                    ElseIf (And (Local0, 0x8000))
                    {
                        Subtract (Zero, Local0, Local0)
                        And (Local0, 0xFFFF, Local0)
                    }
                    Else
                    {
                        Store (Ones, Local0)
                    }

                    Store (Local0, Index (BFB0, One))
                }

                Return (BFB0)
            }
            Else
            {
                Return (XBST ())
            }
        }
    }
}
