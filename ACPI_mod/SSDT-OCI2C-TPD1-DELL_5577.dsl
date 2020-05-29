//TPD1
DefinitionBlock ("", "SSDT", 2, "OCLT", "TPD1", 0x00000000)
{
    External (_SB_.GNUM, MethodObj)   
    External (_SB_.INUM, MethodObj)  
    External (_SB_.SHPO, MethodObj)  
    External (SDS0, FieldUnitObj) 
    External (GPDI, FieldUnitObj) 
    External (SDM0, FieldUnitObj) 
    External (_SB_.PCI0.I2C0, DeviceObj)

    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            SDS0 = Zero
        }
    }

    Scope (_SB.PCI0.I2C0)
    {
        Name (SSCN, Package () { 432, 507, 30 })
        Name (FMCN, Package () { 72, 160, 30 })

        Device (TPD1)
        {
            Name (HID2, Zero)
            Name (SBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x0015, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C0",
                    0x00, ResourceConsumer, _Y00, Exclusive,
                    )
            })
            Name (SBFI, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, _Y01)
                {
                    0x00000000,
                }
            })
            Name (SBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0000
                    }
            })
            CreateWordField (SBFB, _Y00._ADR, BADR)  // _ADR: Address
            CreateDWordField (SBFB, _Y00._SPE, SPED)  // _SPE: Speed
            CreateWordField (SBFG, 0x17, INT1)
            CreateDWordField (SBFI, _Y01._INT, INT2)  // _INT: Interrupts
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                INT1 = GNUM (GPDI)
                INT2 = INUM (GPDI)
                If ((SDM0 == Zero))
                {
                    SHPO (GPDI, One)
                }

                If (_OSI ("Darwin"))
                {
                    _HID = "ELAN1010"
                    HID2 = 0x20
                    Return (Zero)
                }
            }

            Name (_HID, "MSFT0000")  // _HID: Hardware ID
            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
            Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If ((Arg0 == ToUUID ("3cdff6f7-4267-4555-ad05-b30a3d8938de") /* HID I2C Device */))
                {
                    If ((Arg2 == Zero))
                    {
                        If ((Arg1 == One))
                        {
                            Return (Buffer (One)
                            {
                                 0x03                                             // .
                            })
                        }
                        Else
                        {
                            Return (Buffer (One)
                            {
                                 0x00                                             // .
                            })
                        }
                    }

                    If ((Arg2 == One))
                    {
                        Return (One)
                    }
                }
                Else
                {
                    Return (Buffer (One)
                    {
                         0x7B  // 0x00 .0x7B.  0x1B
                    })
                }
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
//                If (_OSI ("Darwin"))
//                {
                    Return (ConcatenateResTemplate (SBFB, SBFG))
//                }
            }
        }
    }
}

