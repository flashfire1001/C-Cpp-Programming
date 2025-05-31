# Interrupt in C and Cpp

Great — let's explore **interrupts** in both **STM32 (embedded systems)** and **system programming in C/C++ on desktop platforms** like Linux.

------

## ⚙️ Part 1: **Interrupts in STM32 (Embedded C/C++)**

STM32 uses the **NVIC (Nested Vectored Interrupt Controller)** to manage interrupts. Programming STM32 involves either:

-   **Direct register programming** (bare metal)
-   **HAL/LL libraries** (from STMicroelectronics)
-   **CMSIS** (ARM's abstraction layer)

------

### ✅ Example: External Interrupt with STM32 HAL (e.g., button press)

**Goal**: Toggle an LED when a button is pressed (EXTI interrupt)

#### 🧩 Setup using STM32CubeMX

1.  Configure GPIO input with EXTI (e.g., pin PA0).
2.  Enable NVIC for EXTI0.

#### 💡 Code Example (Using STM32 HAL)

```c
// main.c

#include "main.h"

void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin) {
    if (GPIO_Pin == GPIO_PIN_0) {
        HAL_GPIO_TogglePin(GPIOC, GPIO_PIN_13); // Toggle LED
    }
}

int main(void) {
    HAL_Init();
    SystemClock_Config();
    MX_GPIO_Init();  // GPIO and EXTI configuration

    while (1) {
        // Main loop does nothing; interrupt handles the button
    }
}
```

#### 🛠 Required functions:

-   `HAL_GPIO_EXTI_Callback()` → called when EXTI interrupt occurs
-   `MX_GPIO_Init()` → sets pin modes and EXTI
-   `NVIC_EnableIRQ(EXTI0_IRQn)` (handled by CubeMX)

------

### 🛠 If you're doing **bare-metal (register-level)** STM32:

```c
// Enable GPIOA clock
RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

// Set PA0 as input
GPIOA->MODER &= ~(3 << (0 * 2));

// Enable SYSCFG for EXTI
RCC->APB2ENR |= RCC_APB2ENR_SYSCFGEN;
SYSCFG->EXTICR[0] &= ~SYSCFG_EXTICR1_EXTI0;

// Configure EXTI
EXTI->IMR |= EXTI_IMR_IM0;
EXTI->FTSR |= EXTI_FTSR_TR0;  // Falling edge
NVIC_EnableIRQ(EXTI0_IRQn);

// ISR
void EXTI0_IRQHandler(void) {
    if (EXTI->PR & EXTI_PR_PR0) {
        EXTI->PR |= EXTI_PR_PR0;  // Clear pending bit
        GPIOC->ODR ^= GPIO_ODR_OD13; // Toggle LED
    }
}
```

------

## 🖥️ Part 2: **System Programming (Linux C/C++)**

Interrupts aren't directly exposed to user-space programs. Instead, you handle **signals**, **event polling**, or **device interrupts** via:

### 1. **Signal Handling**

```c
#include <stdio.h>
#include <signal.h>
#include <unistd.h>

void handler(int sig) {
    printf("Caught signal %d\n", sig);
}

int main() {
    signal(SIGINT, handler); // Ctrl+C
    while (1) {
        sleep(1);
        printf("Running...\n");
    }
    return 0;
}
```

-   `SIGINT` is triggered by `Ctrl+C`
-   `signal()` sets a function to handle it

------

### 2. **Interrupts via `/proc` and `/sys` or UIO in Linux Kernel**

For **real hardware interrupts**, you typically:

-   Write a **Linux kernel module**
-   Register an ISR with `request_irq()`

#### Kernel Module Example:

```c
static irqreturn_t my_isr(int irq, void *dev_id) {
    printk(KERN_INFO "Interrupt received!\n");
    return IRQ_HANDLED;
}

int init_module(void) {
    int irq_number = 17;
    request_irq(irq_number, my_isr, IRQF_SHARED, "my_device", (void *)(my_isr));
    return 0;
}
```

To do this, you need kernel development skills and permissions.

------

## 🧠 Summary Table

| Platform           | Method                    | Example                    |
| ------------------ | ------------------------- | -------------------------- |
| STM32 (HAL)        | HAL_ISR, NVIC, EXTI       | `HAL_GPIO_EXTI_Callback()` |
| STM32 (Bare Metal) | Register access + NVIC    | `EXTI0_IRQHandler()`       |
| Linux (userland)   | `signal()`, `sigaction()` | `SIGINT`, `SIGTERM`, etc.  |
| Linux (kernel)     | `request_irq()` in driver | Real hardware ISR          |

------

Would you like an example for:

-   STM32CubeIDE project with interrupts?
-   Writing a Linux kernel module for handling real interrupts?
-   Using UIO or `/proc/interrupts`?

Let me know your platform and goals (e.g., are you using STM32CubeIDE, or doing bare metal?).