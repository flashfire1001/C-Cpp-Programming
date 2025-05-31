#Interrupt In LC3

previously - I/O in LC-3

-   using polling or traps
-   wait till the ready- bit in KBSR become 1, then read the content (bits) in KBDR

![image-20250517191058639](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images\image-20250517191058639.png)

the problem is the processor cannot do anything else while it waits on next character (stuck in the polling loop)

![image-20250517191030014](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images\image-20250517191030014.png)

The key to free up the processor: Interrupt !

![image-20250517191435957](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images\image-20250517191435957.png)

The Interrupt driven I/O:

![image-20250517191911784](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images\image-20250517191911784.png)

Interrupt only happens when : interrupt is enabled and the Keyboard is ready

 **When is the "Ready Bit" in KBSR set to 1?**

The **ready bit** (bit [15] of KBSR) is set to **1** **when the keyboard has received a character that has not yet been read by the program.** And is it return to zero when the program read the data in xFE02 (keyboard data register)

Competing condition: (Plus, The device request must be **more urgent than what the processor is currently doing**.)

Priority : Generating an INTerrupt

every device have a fixed constant Priority level, this is not a signal. BUT, this is displayed when it output a INT signal.

The Priority encoder is designed to :

use the input INT signal from request devices, generate a 3 bits output 111 to 000 (0-7) that represent the **device of Highest Priority Level** 

![image-20250517192629647](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images\image-20250517192629647.png)

How the processor detects INTerrupts

Recall instruction cycle. Processor will check if INT is asserted at the end of each instruction cycle before starting a new FETCH。

![image-20250517192946291](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images\image-20250517192946291.png)

If detect INT signal: 

1.the control unit needs to save the state information for later resume old process on RTI

2.load PC with the starting address of **ISR (Interrupt Service Routine)** more specifically, `ISR address = MEM[x0100 + INTV]`

3.resume original process

more specifically:

During 1 phase,

PC + general purpose registers (callee saved) + Processor Status Register (PSR) are saved.

![image-20250517193540088](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images\image-20250517193540088.png)

PSR contains: Privilege(supervisor/ user mode) + Priority default 0(user program) + condition codes



here (priv = privilege) Privilege is all about the right to do something, such as execute a particular instruction or access a particular memory location

ex.![image-20250517193837095](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images\image-20250517193837095.png)

When, switching modes, Save the current value of `R6`:

-   `Saved_USP` (user stack pointer) if moving from user to supervisor.
-   `Saved_SSP` (supervisor stack pointer) if moving back.

Update `R6` to point to the new active stack.

returning from TRAP or INTerrupt : RTI

![image-20250517203159982](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images\image-20250517203159982.png)

**RTI vs RET:**

| Aspect           | RTI                       | RET                          |
| ---------------- | ------------------------- | ---------------------------- |
| Purpose          | Return from **interrupt** | Return from a **subroutine** |
| Mode switch      | Yes (Supervisor → User)   | No                           |
| Privilege level  | **Privileged** only       | Unprivileged OK              |
| Context restored | PSR + PC + R6 (stack)     | PC only (caller stack)       |

**Before** executing RTI, the hardware must have saved the old **PSR** and **PC** on the supervisor stack (**this happens automatically on entry to the ISR**).

**RTI** pops (PC & PSR) values off the supervisor stack and returns control—and mode—back to the interrupted program.



![image-20250517200309971](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images\image-20250517200309971.png)

during 1 process  (service input routine in microinstruction set level, is already activated), the **device to get the service** and **the interrupt Service routine**  is already determined.

during 2, the stack pointer is changed.

during 3, the old or original PC and Program status register is saved.

during 4, the new PSR is prepared which the status of computer is initialized into privilege mode, with new Priority level and cc. 

during 5 and 6, switch PC = M(x0100 + INTV)

the ISR begins.

![image-20250517205604076](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images\image-20250517205604076.png)