PHDRS
{
  ph_text   PT_LOAD FLAGS (0x7); /* RWE */
  ph_rodata PT_LOAD FLAGS (0x6); /* RW */
  ph_data   PT_LOAD FLAGS (0x6); /* RW */
}

SECTIONS
{
  . = 0x0;

  .text : {
    *(.text.entry)
    *(.text*)
  } :ph_text

  . = ALIGN(0x4000);

  .rodata : {
    *(.rodata*)
  } :ph_rodata

  . = ALIGN(0x4000);

  .data : {
    *(.data*)
    *(.got*)
  } :ph_data

  .bss : {
    *(.bss*)
    *(COMMON)
  } :ph_data

  /DISCARD/ : {
    *(.interp)
    *(.note*)
    *(.comment)
    *(.eh_frame*)
    *(.dynsym)
    *(.dynstr)
    *(.dynamic)
    *(.rela*)
    *(.gnu.hash)
  }
}
