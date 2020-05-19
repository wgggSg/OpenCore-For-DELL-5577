// BrightKey for DELL 5577
// In config ACPI, _Q80 to XQ80(Fn+F11)
// Find:     5F 51 38 30
// Replace:  58 51 38 30

// In config ACPI, _Q81 to XQ81(Fn+F12)
// Find:     5F 51 38 31
// Replace:  58 51 38 31
//
DefinitionBlock("", "SSDT", 2, "OCLT", "BrightFN", 0)
{
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.PCI0.LPCB.EC.XQ80, MethodObj)
    External(_SB.PCI0.LPCB.EC.XQ81, MethodObj)
    
    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q80, 0, NotSerialized)//up
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
                Notify(\_SB.PCI0.LPCB.PS2K, 0x10)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ80()
            }
        }

        Method (_Q81, 0, NotSerialized)//down
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
                Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ81()
            }
        }
    }
}
//EOF