
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 70 c6 10 80       	mov    $0x8010c670,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 c8 33 10 80       	mov    $0x801033c8,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	c7 44 24 04 2c 87 10 	movl   $0x8010872c,0x4(%esp)
80100041:	80 
80100042:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
80100049:	e8 10 50 00 00       	call   8010505e <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004e:	c7 05 b0 db 10 80 a4 	movl   $0x8010dba4,0x8010dbb0
80100055:	db 10 80 
  bcache.head.next = &bcache.head;
80100058:	c7 05 b4 db 10 80 a4 	movl   $0x8010dba4,0x8010dbb4
8010005f:	db 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100062:	c7 45 f4 b4 c6 10 80 	movl   $0x8010c6b4,-0xc(%ebp)
80100069:	eb 3a                	jmp    801000a5 <binit+0x71>
    b->next = bcache.head.next;
8010006b:	8b 15 b4 db 10 80    	mov    0x8010dbb4,%edx
80100071:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100074:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100077:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007a:	c7 40 0c a4 db 10 80 	movl   $0x8010dba4,0xc(%eax)
    b->dev = -1;
80100081:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100084:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008b:	a1 b4 db 10 80       	mov    0x8010dbb4,%eax
80100090:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100093:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100096:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100099:	a3 b4 db 10 80       	mov    %eax,0x8010dbb4

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009e:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a5:	81 7d f4 a4 db 10 80 	cmpl   $0x8010dba4,-0xc(%ebp)
801000ac:	72 bd                	jb     8010006b <binit+0x37>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000ae:	c9                   	leave  
801000af:	c3                   	ret    

801000b0 <bget>:
// Look through buffer cache for sector on device dev.
// If not found, allocate fresh block.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint sector)
{
801000b0:	55                   	push   %ebp
801000b1:	89 e5                	mov    %esp,%ebp
801000b3:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b6:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
801000bd:	e8 bd 4f 00 00       	call   8010507f <acquire>

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c2:	a1 b4 db 10 80       	mov    0x8010dbb4,%eax
801000c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000ca:	eb 63                	jmp    8010012f <bget+0x7f>
    if(b->dev == dev && b->sector == sector){
801000cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000cf:	8b 40 04             	mov    0x4(%eax),%eax
801000d2:	3b 45 08             	cmp    0x8(%ebp),%eax
801000d5:	75 4f                	jne    80100126 <bget+0x76>
801000d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000da:	8b 40 08             	mov    0x8(%eax),%eax
801000dd:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e0:	75 44                	jne    80100126 <bget+0x76>
      if(!(b->flags & B_BUSY)){
801000e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e5:	8b 00                	mov    (%eax),%eax
801000e7:	83 e0 01             	and    $0x1,%eax
801000ea:	85 c0                	test   %eax,%eax
801000ec:	75 23                	jne    80100111 <bget+0x61>
        b->flags |= B_BUSY;
801000ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f1:	8b 00                	mov    (%eax),%eax
801000f3:	83 c8 01             	or     $0x1,%eax
801000f6:	89 c2                	mov    %eax,%edx
801000f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000fb:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
801000fd:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
80100104:	e8 d8 4f 00 00       	call   801050e1 <release>
        return b;
80100109:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010010c:	e9 93 00 00 00       	jmp    801001a4 <bget+0xf4>
      }
      sleep(b, &bcache.lock);
80100111:	c7 44 24 04 80 c6 10 	movl   $0x8010c680,0x4(%esp)
80100118:	80 
80100119:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010011c:	89 04 24             	mov    %eax,(%esp)
8010011f:	e8 ea 4b 00 00       	call   80104d0e <sleep>
      goto loop;
80100124:	eb 9c                	jmp    801000c2 <bget+0x12>

  acquire(&bcache.lock);

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100126:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100129:	8b 40 10             	mov    0x10(%eax),%eax
8010012c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010012f:	81 7d f4 a4 db 10 80 	cmpl   $0x8010dba4,-0xc(%ebp)
80100136:	75 94                	jne    801000cc <bget+0x1c>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100138:	a1 b0 db 10 80       	mov    0x8010dbb0,%eax
8010013d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100140:	eb 4d                	jmp    8010018f <bget+0xdf>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
80100142:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100145:	8b 00                	mov    (%eax),%eax
80100147:	83 e0 01             	and    $0x1,%eax
8010014a:	85 c0                	test   %eax,%eax
8010014c:	75 38                	jne    80100186 <bget+0xd6>
8010014e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100151:	8b 00                	mov    (%eax),%eax
80100153:	83 e0 04             	and    $0x4,%eax
80100156:	85 c0                	test   %eax,%eax
80100158:	75 2c                	jne    80100186 <bget+0xd6>
      b->dev = dev;
8010015a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015d:	8b 55 08             	mov    0x8(%ebp),%edx
80100160:	89 50 04             	mov    %edx,0x4(%eax)
      b->sector = sector;
80100163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100166:	8b 55 0c             	mov    0xc(%ebp),%edx
80100169:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
8010016c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016f:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100175:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
8010017c:	e8 60 4f 00 00       	call   801050e1 <release>
      return b;
80100181:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100184:	eb 1e                	jmp    801001a4 <bget+0xf4>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100186:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100189:	8b 40 0c             	mov    0xc(%eax),%eax
8010018c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010018f:	81 7d f4 a4 db 10 80 	cmpl   $0x8010dba4,-0xc(%ebp)
80100196:	75 aa                	jne    80100142 <bget+0x92>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100198:	c7 04 24 33 87 10 80 	movl   $0x80108733,(%esp)
8010019f:	e8 96 03 00 00       	call   8010053a <panic>
}
801001a4:	c9                   	leave  
801001a5:	c3                   	ret    

801001a6 <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
801001a6:	55                   	push   %ebp
801001a7:	89 e5                	mov    %esp,%ebp
801001a9:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  b = bget(dev, sector);
801001ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801001af:	89 44 24 04          	mov    %eax,0x4(%esp)
801001b3:	8b 45 08             	mov    0x8(%ebp),%eax
801001b6:	89 04 24             	mov    %eax,(%esp)
801001b9:	e8 f2 fe ff ff       	call   801000b0 <bget>
801001be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID))
801001c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001c4:	8b 00                	mov    (%eax),%eax
801001c6:	83 e0 02             	and    $0x2,%eax
801001c9:	85 c0                	test   %eax,%eax
801001cb:	75 0b                	jne    801001d8 <bread+0x32>
    iderw(b);
801001cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d0:	89 04 24             	mov    %eax,(%esp)
801001d3:	e8 c7 25 00 00       	call   8010279f <iderw>
  return b;
801001d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001db:	c9                   	leave  
801001dc:	c3                   	ret    

801001dd <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001dd:	55                   	push   %ebp
801001de:	89 e5                	mov    %esp,%ebp
801001e0:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
801001e3:	8b 45 08             	mov    0x8(%ebp),%eax
801001e6:	8b 00                	mov    (%eax),%eax
801001e8:	83 e0 01             	and    $0x1,%eax
801001eb:	85 c0                	test   %eax,%eax
801001ed:	75 0c                	jne    801001fb <bwrite+0x1e>
    panic("bwrite");
801001ef:	c7 04 24 44 87 10 80 	movl   $0x80108744,(%esp)
801001f6:	e8 3f 03 00 00       	call   8010053a <panic>
  b->flags |= B_DIRTY;
801001fb:	8b 45 08             	mov    0x8(%ebp),%eax
801001fe:	8b 00                	mov    (%eax),%eax
80100200:	83 c8 04             	or     $0x4,%eax
80100203:	89 c2                	mov    %eax,%edx
80100205:	8b 45 08             	mov    0x8(%ebp),%eax
80100208:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010020a:	8b 45 08             	mov    0x8(%ebp),%eax
8010020d:	89 04 24             	mov    %eax,(%esp)
80100210:	e8 8a 25 00 00       	call   8010279f <iderw>
}
80100215:	c9                   	leave  
80100216:	c3                   	ret    

80100217 <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100217:	55                   	push   %ebp
80100218:	89 e5                	mov    %esp,%ebp
8010021a:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
8010021d:	8b 45 08             	mov    0x8(%ebp),%eax
80100220:	8b 00                	mov    (%eax),%eax
80100222:	83 e0 01             	and    $0x1,%eax
80100225:	85 c0                	test   %eax,%eax
80100227:	75 0c                	jne    80100235 <brelse+0x1e>
    panic("brelse");
80100229:	c7 04 24 4b 87 10 80 	movl   $0x8010874b,(%esp)
80100230:	e8 05 03 00 00       	call   8010053a <panic>

  acquire(&bcache.lock);
80100235:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
8010023c:	e8 3e 4e 00 00       	call   8010507f <acquire>

  b->next->prev = b->prev;
80100241:	8b 45 08             	mov    0x8(%ebp),%eax
80100244:	8b 40 10             	mov    0x10(%eax),%eax
80100247:	8b 55 08             	mov    0x8(%ebp),%edx
8010024a:	8b 52 0c             	mov    0xc(%edx),%edx
8010024d:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100250:	8b 45 08             	mov    0x8(%ebp),%eax
80100253:	8b 40 0c             	mov    0xc(%eax),%eax
80100256:	8b 55 08             	mov    0x8(%ebp),%edx
80100259:	8b 52 10             	mov    0x10(%edx),%edx
8010025c:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
8010025f:	8b 15 b4 db 10 80    	mov    0x8010dbb4,%edx
80100265:	8b 45 08             	mov    0x8(%ebp),%eax
80100268:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
8010026b:	8b 45 08             	mov    0x8(%ebp),%eax
8010026e:	c7 40 0c a4 db 10 80 	movl   $0x8010dba4,0xc(%eax)
  bcache.head.next->prev = b;
80100275:	a1 b4 db 10 80       	mov    0x8010dbb4,%eax
8010027a:	8b 55 08             	mov    0x8(%ebp),%edx
8010027d:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100280:	8b 45 08             	mov    0x8(%ebp),%eax
80100283:	a3 b4 db 10 80       	mov    %eax,0x8010dbb4

  b->flags &= ~B_BUSY;
80100288:	8b 45 08             	mov    0x8(%ebp),%eax
8010028b:	8b 00                	mov    (%eax),%eax
8010028d:	83 e0 fe             	and    $0xfffffffe,%eax
80100290:	89 c2                	mov    %eax,%edx
80100292:	8b 45 08             	mov    0x8(%ebp),%eax
80100295:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80100297:	8b 45 08             	mov    0x8(%ebp),%eax
8010029a:	89 04 24             	mov    %eax,(%esp)
8010029d:	e8 b0 4b 00 00       	call   80104e52 <wakeup>

  release(&bcache.lock);
801002a2:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
801002a9:	e8 33 4e 00 00       	call   801050e1 <release>
}
801002ae:	c9                   	leave  
801002af:	c3                   	ret    

801002b0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002b0:	55                   	push   %ebp
801002b1:	89 e5                	mov    %esp,%ebp
801002b3:	83 ec 14             	sub    $0x14,%esp
801002b6:	8b 45 08             	mov    0x8(%ebp),%eax
801002b9:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002bd:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002c1:	89 c2                	mov    %eax,%edx
801002c3:	ec                   	in     (%dx),%al
801002c4:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002c7:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801002cb:	c9                   	leave  
801002cc:	c3                   	ret    

801002cd <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002cd:	55                   	push   %ebp
801002ce:	89 e5                	mov    %esp,%ebp
801002d0:	83 ec 08             	sub    $0x8,%esp
801002d3:	8b 55 08             	mov    0x8(%ebp),%edx
801002d6:	8b 45 0c             	mov    0xc(%ebp),%eax
801002d9:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801002dd:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801002e0:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801002e4:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801002e8:	ee                   	out    %al,(%dx)
}
801002e9:	c9                   	leave  
801002ea:	c3                   	ret    

801002eb <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
801002eb:	55                   	push   %ebp
801002ec:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
801002ee:	fa                   	cli    
}
801002ef:	5d                   	pop    %ebp
801002f0:	c3                   	ret    

801002f1 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801002f1:	55                   	push   %ebp
801002f2:	89 e5                	mov    %esp,%ebp
801002f4:	56                   	push   %esi
801002f5:	53                   	push   %ebx
801002f6:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801002f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801002fd:	74 1c                	je     8010031b <printint+0x2a>
801002ff:	8b 45 08             	mov    0x8(%ebp),%eax
80100302:	c1 e8 1f             	shr    $0x1f,%eax
80100305:	0f b6 c0             	movzbl %al,%eax
80100308:	89 45 10             	mov    %eax,0x10(%ebp)
8010030b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010030f:	74 0a                	je     8010031b <printint+0x2a>
    x = -xx;
80100311:	8b 45 08             	mov    0x8(%ebp),%eax
80100314:	f7 d8                	neg    %eax
80100316:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100319:	eb 06                	jmp    80100321 <printint+0x30>
  else
    x = xx;
8010031b:	8b 45 08             	mov    0x8(%ebp),%eax
8010031e:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100321:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100328:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010032b:	8d 41 01             	lea    0x1(%ecx),%eax
8010032e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100331:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100334:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100337:	ba 00 00 00 00       	mov    $0x0,%edx
8010033c:	f7 f3                	div    %ebx
8010033e:	89 d0                	mov    %edx,%eax
80100340:	0f b6 80 04 90 10 80 	movzbl -0x7fef6ffc(%eax),%eax
80100347:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
8010034b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010034e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100351:	ba 00 00 00 00       	mov    $0x0,%edx
80100356:	f7 f6                	div    %esi
80100358:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010035b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010035f:	75 c7                	jne    80100328 <printint+0x37>

  if(sign)
80100361:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100365:	74 10                	je     80100377 <printint+0x86>
    buf[i++] = '-';
80100367:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010036a:	8d 50 01             	lea    0x1(%eax),%edx
8010036d:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100370:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
80100375:	eb 18                	jmp    8010038f <printint+0x9e>
80100377:	eb 16                	jmp    8010038f <printint+0x9e>
    consputc(buf[i]);
80100379:	8d 55 e0             	lea    -0x20(%ebp),%edx
8010037c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010037f:	01 d0                	add    %edx,%eax
80100381:	0f b6 00             	movzbl (%eax),%eax
80100384:	0f be c0             	movsbl %al,%eax
80100387:	89 04 24             	mov    %eax,(%esp)
8010038a:	e8 c1 03 00 00       	call   80100750 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
8010038f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100393:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100397:	79 e0                	jns    80100379 <printint+0x88>
    consputc(buf[i]);
}
80100399:	83 c4 30             	add    $0x30,%esp
8010039c:	5b                   	pop    %ebx
8010039d:	5e                   	pop    %esi
8010039e:	5d                   	pop    %ebp
8010039f:	c3                   	ret    

801003a0 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003a0:	55                   	push   %ebp
801003a1:	89 e5                	mov    %esp,%ebp
801003a3:	83 ec 38             	sub    $0x38,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003a6:	a1 14 b6 10 80       	mov    0x8010b614,%eax
801003ab:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003ae:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003b2:	74 0c                	je     801003c0 <cprintf+0x20>
    acquire(&cons.lock);
801003b4:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
801003bb:	e8 bf 4c 00 00       	call   8010507f <acquire>

  if (fmt == 0)
801003c0:	8b 45 08             	mov    0x8(%ebp),%eax
801003c3:	85 c0                	test   %eax,%eax
801003c5:	75 0c                	jne    801003d3 <cprintf+0x33>
    panic("null fmt");
801003c7:	c7 04 24 52 87 10 80 	movl   $0x80108752,(%esp)
801003ce:	e8 67 01 00 00       	call   8010053a <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003d3:	8d 45 0c             	lea    0xc(%ebp),%eax
801003d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801003d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801003e0:	e9 21 01 00 00       	jmp    80100506 <cprintf+0x166>
    if(c != '%'){
801003e5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
801003e9:	74 10                	je     801003fb <cprintf+0x5b>
      consputc(c);
801003eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801003ee:	89 04 24             	mov    %eax,(%esp)
801003f1:	e8 5a 03 00 00       	call   80100750 <consputc>
      continue;
801003f6:	e9 07 01 00 00       	jmp    80100502 <cprintf+0x162>
    }
    c = fmt[++i] & 0xff;
801003fb:	8b 55 08             	mov    0x8(%ebp),%edx
801003fe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100402:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100405:	01 d0                	add    %edx,%eax
80100407:	0f b6 00             	movzbl (%eax),%eax
8010040a:	0f be c0             	movsbl %al,%eax
8010040d:	25 ff 00 00 00       	and    $0xff,%eax
80100412:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
80100415:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100419:	75 05                	jne    80100420 <cprintf+0x80>
      break;
8010041b:	e9 06 01 00 00       	jmp    80100526 <cprintf+0x186>
    switch(c){
80100420:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100423:	83 f8 70             	cmp    $0x70,%eax
80100426:	74 4f                	je     80100477 <cprintf+0xd7>
80100428:	83 f8 70             	cmp    $0x70,%eax
8010042b:	7f 13                	jg     80100440 <cprintf+0xa0>
8010042d:	83 f8 25             	cmp    $0x25,%eax
80100430:	0f 84 a6 00 00 00    	je     801004dc <cprintf+0x13c>
80100436:	83 f8 64             	cmp    $0x64,%eax
80100439:	74 14                	je     8010044f <cprintf+0xaf>
8010043b:	e9 aa 00 00 00       	jmp    801004ea <cprintf+0x14a>
80100440:	83 f8 73             	cmp    $0x73,%eax
80100443:	74 57                	je     8010049c <cprintf+0xfc>
80100445:	83 f8 78             	cmp    $0x78,%eax
80100448:	74 2d                	je     80100477 <cprintf+0xd7>
8010044a:	e9 9b 00 00 00       	jmp    801004ea <cprintf+0x14a>
    case 'd':
      printint(*argp++, 10, 1);
8010044f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100452:	8d 50 04             	lea    0x4(%eax),%edx
80100455:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100458:	8b 00                	mov    (%eax),%eax
8010045a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
80100461:	00 
80100462:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80100469:	00 
8010046a:	89 04 24             	mov    %eax,(%esp)
8010046d:	e8 7f fe ff ff       	call   801002f1 <printint>
      break;
80100472:	e9 8b 00 00 00       	jmp    80100502 <cprintf+0x162>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100477:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010047a:	8d 50 04             	lea    0x4(%eax),%edx
8010047d:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100480:	8b 00                	mov    (%eax),%eax
80100482:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100489:	00 
8010048a:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
80100491:	00 
80100492:	89 04 24             	mov    %eax,(%esp)
80100495:	e8 57 fe ff ff       	call   801002f1 <printint>
      break;
8010049a:	eb 66                	jmp    80100502 <cprintf+0x162>
    case 's':
      if((s = (char*)*argp++) == 0)
8010049c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010049f:	8d 50 04             	lea    0x4(%eax),%edx
801004a2:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004a5:	8b 00                	mov    (%eax),%eax
801004a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004aa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004ae:	75 09                	jne    801004b9 <cprintf+0x119>
        s = "(null)";
801004b0:	c7 45 ec 5b 87 10 80 	movl   $0x8010875b,-0x14(%ebp)
      for(; *s; s++)
801004b7:	eb 17                	jmp    801004d0 <cprintf+0x130>
801004b9:	eb 15                	jmp    801004d0 <cprintf+0x130>
        consputc(*s);
801004bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004be:	0f b6 00             	movzbl (%eax),%eax
801004c1:	0f be c0             	movsbl %al,%eax
801004c4:	89 04 24             	mov    %eax,(%esp)
801004c7:	e8 84 02 00 00       	call   80100750 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004cc:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004d3:	0f b6 00             	movzbl (%eax),%eax
801004d6:	84 c0                	test   %al,%al
801004d8:	75 e1                	jne    801004bb <cprintf+0x11b>
        consputc(*s);
      break;
801004da:	eb 26                	jmp    80100502 <cprintf+0x162>
    case '%':
      consputc('%');
801004dc:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004e3:	e8 68 02 00 00       	call   80100750 <consputc>
      break;
801004e8:	eb 18                	jmp    80100502 <cprintf+0x162>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801004ea:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004f1:	e8 5a 02 00 00       	call   80100750 <consputc>
      consputc(c);
801004f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801004f9:	89 04 24             	mov    %eax,(%esp)
801004fc:	e8 4f 02 00 00       	call   80100750 <consputc>
      break;
80100501:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100502:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100506:	8b 55 08             	mov    0x8(%ebp),%edx
80100509:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010050c:	01 d0                	add    %edx,%eax
8010050e:	0f b6 00             	movzbl (%eax),%eax
80100511:	0f be c0             	movsbl %al,%eax
80100514:	25 ff 00 00 00       	and    $0xff,%eax
80100519:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010051c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100520:	0f 85 bf fe ff ff    	jne    801003e5 <cprintf+0x45>
      consputc(c);
      break;
    }
  }

  if(locking)
80100526:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010052a:	74 0c                	je     80100538 <cprintf+0x198>
    release(&cons.lock);
8010052c:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100533:	e8 a9 4b 00 00       	call   801050e1 <release>
}
80100538:	c9                   	leave  
80100539:	c3                   	ret    

8010053a <panic>:

void
panic(char *s)
{
8010053a:	55                   	push   %ebp
8010053b:	89 e5                	mov    %esp,%ebp
8010053d:	83 ec 48             	sub    $0x48,%esp
  int i;
  uint pcs[10];
  
  cli();
80100540:	e8 a6 fd ff ff       	call   801002eb <cli>
  cons.locking = 0;
80100545:	c7 05 14 b6 10 80 00 	movl   $0x0,0x8010b614
8010054c:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
8010054f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100555:	0f b6 00             	movzbl (%eax),%eax
80100558:	0f b6 c0             	movzbl %al,%eax
8010055b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010055f:	c7 04 24 62 87 10 80 	movl   $0x80108762,(%esp)
80100566:	e8 35 fe ff ff       	call   801003a0 <cprintf>
  cprintf(s);
8010056b:	8b 45 08             	mov    0x8(%ebp),%eax
8010056e:	89 04 24             	mov    %eax,(%esp)
80100571:	e8 2a fe ff ff       	call   801003a0 <cprintf>
  cprintf("\n");
80100576:	c7 04 24 71 87 10 80 	movl   $0x80108771,(%esp)
8010057d:	e8 1e fe ff ff       	call   801003a0 <cprintf>
  getcallerpcs(&s, pcs);
80100582:	8d 45 cc             	lea    -0x34(%ebp),%eax
80100585:	89 44 24 04          	mov    %eax,0x4(%esp)
80100589:	8d 45 08             	lea    0x8(%ebp),%eax
8010058c:	89 04 24             	mov    %eax,(%esp)
8010058f:	e8 9c 4b 00 00       	call   80105130 <getcallerpcs>
  for(i=0; i<10; i++)
80100594:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010059b:	eb 1b                	jmp    801005b8 <panic+0x7e>
    cprintf(" %p", pcs[i]);
8010059d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005a0:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801005a8:	c7 04 24 73 87 10 80 	movl   $0x80108773,(%esp)
801005af:	e8 ec fd ff ff       	call   801003a0 <cprintf>
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005b4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005b8:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005bc:	7e df                	jle    8010059d <panic+0x63>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005be:	c7 05 c0 b5 10 80 01 	movl   $0x1,0x8010b5c0
801005c5:	00 00 00 
  for(;;)
    ;
801005c8:	eb fe                	jmp    801005c8 <panic+0x8e>

801005ca <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
801005ca:	55                   	push   %ebp
801005cb:	89 e5                	mov    %esp,%ebp
801005cd:	83 ec 28             	sub    $0x28,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
801005d0:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
801005d7:	00 
801005d8:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
801005df:	e8 e9 fc ff ff       	call   801002cd <outb>
  pos = inb(CRTPORT+1) << 8;
801005e4:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
801005eb:	e8 c0 fc ff ff       	call   801002b0 <inb>
801005f0:	0f b6 c0             	movzbl %al,%eax
801005f3:	c1 e0 08             	shl    $0x8,%eax
801005f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
801005f9:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80100600:	00 
80100601:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100608:	e8 c0 fc ff ff       	call   801002cd <outb>
  pos |= inb(CRTPORT+1);
8010060d:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100614:	e8 97 fc ff ff       	call   801002b0 <inb>
80100619:	0f b6 c0             	movzbl %al,%eax
8010061c:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
8010061f:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100623:	75 30                	jne    80100655 <cgaputc+0x8b>
    pos += 80 - pos%80;
80100625:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100628:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010062d:	89 c8                	mov    %ecx,%eax
8010062f:	f7 ea                	imul   %edx
80100631:	c1 fa 05             	sar    $0x5,%edx
80100634:	89 c8                	mov    %ecx,%eax
80100636:	c1 f8 1f             	sar    $0x1f,%eax
80100639:	29 c2                	sub    %eax,%edx
8010063b:	89 d0                	mov    %edx,%eax
8010063d:	c1 e0 02             	shl    $0x2,%eax
80100640:	01 d0                	add    %edx,%eax
80100642:	c1 e0 04             	shl    $0x4,%eax
80100645:	29 c1                	sub    %eax,%ecx
80100647:	89 ca                	mov    %ecx,%edx
80100649:	b8 50 00 00 00       	mov    $0x50,%eax
8010064e:	29 d0                	sub    %edx,%eax
80100650:	01 45 f4             	add    %eax,-0xc(%ebp)
80100653:	eb 35                	jmp    8010068a <cgaputc+0xc0>
  else if(c == BACKSPACE){
80100655:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010065c:	75 0c                	jne    8010066a <cgaputc+0xa0>
    if(pos > 0) --pos;
8010065e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100662:	7e 26                	jle    8010068a <cgaputc+0xc0>
80100664:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100668:	eb 20                	jmp    8010068a <cgaputc+0xc0>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010066a:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
80100670:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100673:	8d 50 01             	lea    0x1(%eax),%edx
80100676:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100679:	01 c0                	add    %eax,%eax
8010067b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
8010067e:	8b 45 08             	mov    0x8(%ebp),%eax
80100681:	0f b6 c0             	movzbl %al,%eax
80100684:	80 cc 07             	or     $0x7,%ah
80100687:	66 89 02             	mov    %ax,(%edx)
  
  if((pos/80) >= 24){  // Scroll up.
8010068a:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
80100691:	7e 53                	jle    801006e6 <cgaputc+0x11c>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100693:	a1 00 90 10 80       	mov    0x80109000,%eax
80100698:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
8010069e:	a1 00 90 10 80       	mov    0x80109000,%eax
801006a3:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801006aa:	00 
801006ab:	89 54 24 04          	mov    %edx,0x4(%esp)
801006af:	89 04 24             	mov    %eax,(%esp)
801006b2:	e8 ee 4c 00 00       	call   801053a5 <memmove>
    pos -= 80;
801006b7:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006bb:	b8 80 07 00 00       	mov    $0x780,%eax
801006c0:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006c3:	8d 14 00             	lea    (%eax,%eax,1),%edx
801006c6:	a1 00 90 10 80       	mov    0x80109000,%eax
801006cb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006ce:	01 c9                	add    %ecx,%ecx
801006d0:	01 c8                	add    %ecx,%eax
801006d2:	89 54 24 08          	mov    %edx,0x8(%esp)
801006d6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801006dd:	00 
801006de:	89 04 24             	mov    %eax,(%esp)
801006e1:	e8 f0 4b 00 00       	call   801052d6 <memset>
  }
  
  outb(CRTPORT, 14);
801006e6:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
801006ed:	00 
801006ee:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
801006f5:	e8 d3 fb ff ff       	call   801002cd <outb>
  outb(CRTPORT+1, pos>>8);
801006fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006fd:	c1 f8 08             	sar    $0x8,%eax
80100700:	0f b6 c0             	movzbl %al,%eax
80100703:	89 44 24 04          	mov    %eax,0x4(%esp)
80100707:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
8010070e:	e8 ba fb ff ff       	call   801002cd <outb>
  outb(CRTPORT, 15);
80100713:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
8010071a:	00 
8010071b:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100722:	e8 a6 fb ff ff       	call   801002cd <outb>
  outb(CRTPORT+1, pos);
80100727:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010072a:	0f b6 c0             	movzbl %al,%eax
8010072d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100731:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100738:	e8 90 fb ff ff       	call   801002cd <outb>
  crt[pos] = ' ' | 0x0700;
8010073d:	a1 00 90 10 80       	mov    0x80109000,%eax
80100742:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100745:	01 d2                	add    %edx,%edx
80100747:	01 d0                	add    %edx,%eax
80100749:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
8010074e:	c9                   	leave  
8010074f:	c3                   	ret    

80100750 <consputc>:

void
consputc(int c)
{
80100750:	55                   	push   %ebp
80100751:	89 e5                	mov    %esp,%ebp
80100753:	83 ec 18             	sub    $0x18,%esp
  if(panicked){
80100756:	a1 c0 b5 10 80       	mov    0x8010b5c0,%eax
8010075b:	85 c0                	test   %eax,%eax
8010075d:	74 07                	je     80100766 <consputc+0x16>
    cli();
8010075f:	e8 87 fb ff ff       	call   801002eb <cli>
    for(;;)
      ;
80100764:	eb fe                	jmp    80100764 <consputc+0x14>
  }

  if(c == BACKSPACE){
80100766:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010076d:	75 26                	jne    80100795 <consputc+0x45>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010076f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100776:	e8 ec 65 00 00       	call   80106d67 <uartputc>
8010077b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100782:	e8 e0 65 00 00       	call   80106d67 <uartputc>
80100787:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010078e:	e8 d4 65 00 00       	call   80106d67 <uartputc>
80100793:	eb 0b                	jmp    801007a0 <consputc+0x50>
  } else
    uartputc(c);
80100795:	8b 45 08             	mov    0x8(%ebp),%eax
80100798:	89 04 24             	mov    %eax,(%esp)
8010079b:	e8 c7 65 00 00       	call   80106d67 <uartputc>
  cgaputc(c);
801007a0:	8b 45 08             	mov    0x8(%ebp),%eax
801007a3:	89 04 24             	mov    %eax,(%esp)
801007a6:	e8 1f fe ff ff       	call   801005ca <cgaputc>
}
801007ab:	c9                   	leave  
801007ac:	c3                   	ret    

801007ad <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007ad:	55                   	push   %ebp
801007ae:	89 e5                	mov    %esp,%ebp
801007b0:	83 ec 28             	sub    $0x28,%esp
  int c;

  acquire(&input.lock);
801007b3:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
801007ba:	e8 c0 48 00 00       	call   8010507f <acquire>
  while((c = getc()) >= 0){
801007bf:	e9 37 01 00 00       	jmp    801008fb <consoleintr+0x14e>
    switch(c){
801007c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007c7:	83 f8 10             	cmp    $0x10,%eax
801007ca:	74 1e                	je     801007ea <consoleintr+0x3d>
801007cc:	83 f8 10             	cmp    $0x10,%eax
801007cf:	7f 0a                	jg     801007db <consoleintr+0x2e>
801007d1:	83 f8 08             	cmp    $0x8,%eax
801007d4:	74 64                	je     8010083a <consoleintr+0x8d>
801007d6:	e9 91 00 00 00       	jmp    8010086c <consoleintr+0xbf>
801007db:	83 f8 15             	cmp    $0x15,%eax
801007de:	74 2f                	je     8010080f <consoleintr+0x62>
801007e0:	83 f8 7f             	cmp    $0x7f,%eax
801007e3:	74 55                	je     8010083a <consoleintr+0x8d>
801007e5:	e9 82 00 00 00       	jmp    8010086c <consoleintr+0xbf>
    case C('P'):  // Process listing.
      procdump();
801007ea:	e8 09 47 00 00       	call   80104ef8 <procdump>
      break;
801007ef:	e9 07 01 00 00       	jmp    801008fb <consoleintr+0x14e>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801007f4:	a1 7c de 10 80       	mov    0x8010de7c,%eax
801007f9:	83 e8 01             	sub    $0x1,%eax
801007fc:	a3 7c de 10 80       	mov    %eax,0x8010de7c
        consputc(BACKSPACE);
80100801:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100808:	e8 43 ff ff ff       	call   80100750 <consputc>
8010080d:	eb 01                	jmp    80100810 <consoleintr+0x63>
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010080f:	90                   	nop
80100810:	8b 15 7c de 10 80    	mov    0x8010de7c,%edx
80100816:	a1 78 de 10 80       	mov    0x8010de78,%eax
8010081b:	39 c2                	cmp    %eax,%edx
8010081d:	74 16                	je     80100835 <consoleintr+0x88>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
8010081f:	a1 7c de 10 80       	mov    0x8010de7c,%eax
80100824:	83 e8 01             	sub    $0x1,%eax
80100827:	83 e0 7f             	and    $0x7f,%eax
8010082a:	0f b6 80 f4 dd 10 80 	movzbl -0x7fef220c(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100831:	3c 0a                	cmp    $0xa,%al
80100833:	75 bf                	jne    801007f4 <consoleintr+0x47>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100835:	e9 c1 00 00 00       	jmp    801008fb <consoleintr+0x14e>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
8010083a:	8b 15 7c de 10 80    	mov    0x8010de7c,%edx
80100840:	a1 78 de 10 80       	mov    0x8010de78,%eax
80100845:	39 c2                	cmp    %eax,%edx
80100847:	74 1e                	je     80100867 <consoleintr+0xba>
        input.e--;
80100849:	a1 7c de 10 80       	mov    0x8010de7c,%eax
8010084e:	83 e8 01             	sub    $0x1,%eax
80100851:	a3 7c de 10 80       	mov    %eax,0x8010de7c
        consputc(BACKSPACE);
80100856:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
8010085d:	e8 ee fe ff ff       	call   80100750 <consputc>
      }
      break;
80100862:	e9 94 00 00 00       	jmp    801008fb <consoleintr+0x14e>
80100867:	e9 8f 00 00 00       	jmp    801008fb <consoleintr+0x14e>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010086c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100870:	0f 84 84 00 00 00    	je     801008fa <consoleintr+0x14d>
80100876:	8b 15 7c de 10 80    	mov    0x8010de7c,%edx
8010087c:	a1 74 de 10 80       	mov    0x8010de74,%eax
80100881:	29 c2                	sub    %eax,%edx
80100883:	89 d0                	mov    %edx,%eax
80100885:	83 f8 7f             	cmp    $0x7f,%eax
80100888:	77 70                	ja     801008fa <consoleintr+0x14d>
        c = (c == '\r') ? '\n' : c;
8010088a:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
8010088e:	74 05                	je     80100895 <consoleintr+0xe8>
80100890:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100893:	eb 05                	jmp    8010089a <consoleintr+0xed>
80100895:	b8 0a 00 00 00       	mov    $0xa,%eax
8010089a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
8010089d:	a1 7c de 10 80       	mov    0x8010de7c,%eax
801008a2:	8d 50 01             	lea    0x1(%eax),%edx
801008a5:	89 15 7c de 10 80    	mov    %edx,0x8010de7c
801008ab:	83 e0 7f             	and    $0x7f,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008b3:	88 82 f4 dd 10 80    	mov    %al,-0x7fef220c(%edx)
        consputc(c);
801008b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008bc:	89 04 24             	mov    %eax,(%esp)
801008bf:	e8 8c fe ff ff       	call   80100750 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c4:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
801008c8:	74 18                	je     801008e2 <consoleintr+0x135>
801008ca:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
801008ce:	74 12                	je     801008e2 <consoleintr+0x135>
801008d0:	a1 7c de 10 80       	mov    0x8010de7c,%eax
801008d5:	8b 15 74 de 10 80    	mov    0x8010de74,%edx
801008db:	83 ea 80             	sub    $0xffffff80,%edx
801008de:	39 d0                	cmp    %edx,%eax
801008e0:	75 18                	jne    801008fa <consoleintr+0x14d>
          input.w = input.e;
801008e2:	a1 7c de 10 80       	mov    0x8010de7c,%eax
801008e7:	a3 78 de 10 80       	mov    %eax,0x8010de78
          wakeup(&input.r);
801008ec:	c7 04 24 74 de 10 80 	movl   $0x8010de74,(%esp)
801008f3:	e8 5a 45 00 00       	call   80104e52 <wakeup>
        }
      }
      break;
801008f8:	eb 00                	jmp    801008fa <consoleintr+0x14d>
801008fa:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
801008fb:	8b 45 08             	mov    0x8(%ebp),%eax
801008fe:	ff d0                	call   *%eax
80100900:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100903:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100907:	0f 89 b7 fe ff ff    	jns    801007c4 <consoleintr+0x17>
        }
      }
      break;
    }
  }
  release(&input.lock);
8010090d:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
80100914:	e8 c8 47 00 00       	call   801050e1 <release>
}
80100919:	c9                   	leave  
8010091a:	c3                   	ret    

8010091b <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
8010091b:	55                   	push   %ebp
8010091c:	89 e5                	mov    %esp,%ebp
8010091e:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
80100921:	8b 45 08             	mov    0x8(%ebp),%eax
80100924:	89 04 24             	mov    %eax,(%esp)
80100927:	e8 78 10 00 00       	call   801019a4 <iunlock>
  target = n;
8010092c:	8b 45 10             	mov    0x10(%ebp),%eax
8010092f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&input.lock);
80100932:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
80100939:	e8 41 47 00 00       	call   8010507f <acquire>
  while(n > 0){
8010093e:	e9 aa 00 00 00       	jmp    801009ed <consoleread+0xd2>
    while(input.r == input.w){
80100943:	eb 42                	jmp    80100987 <consoleread+0x6c>
      if(proc->killed){
80100945:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010094b:	8b 40 24             	mov    0x24(%eax),%eax
8010094e:	85 c0                	test   %eax,%eax
80100950:	74 21                	je     80100973 <consoleread+0x58>
        release(&input.lock);
80100952:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
80100959:	e8 83 47 00 00       	call   801050e1 <release>
        ilock(ip);
8010095e:	8b 45 08             	mov    0x8(%ebp),%eax
80100961:	89 04 24             	mov    %eax,(%esp)
80100964:	e8 ed 0e 00 00       	call   80101856 <ilock>
        return -1;
80100969:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010096e:	e9 a5 00 00 00       	jmp    80100a18 <consoleread+0xfd>
      }
      sleep(&input.r, &input.lock);
80100973:	c7 44 24 04 c0 dd 10 	movl   $0x8010ddc0,0x4(%esp)
8010097a:	80 
8010097b:	c7 04 24 74 de 10 80 	movl   $0x8010de74,(%esp)
80100982:	e8 87 43 00 00       	call   80104d0e <sleep>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
80100987:	8b 15 74 de 10 80    	mov    0x8010de74,%edx
8010098d:	a1 78 de 10 80       	mov    0x8010de78,%eax
80100992:	39 c2                	cmp    %eax,%edx
80100994:	74 af                	je     80100945 <consoleread+0x2a>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100996:	a1 74 de 10 80       	mov    0x8010de74,%eax
8010099b:	8d 50 01             	lea    0x1(%eax),%edx
8010099e:	89 15 74 de 10 80    	mov    %edx,0x8010de74
801009a4:	83 e0 7f             	and    $0x7f,%eax
801009a7:	0f b6 80 f4 dd 10 80 	movzbl -0x7fef220c(%eax),%eax
801009ae:	0f be c0             	movsbl %al,%eax
801009b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
801009b4:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801009b8:	75 19                	jne    801009d3 <consoleread+0xb8>
      if(n < target){
801009ba:	8b 45 10             	mov    0x10(%ebp),%eax
801009bd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801009c0:	73 0f                	jae    801009d1 <consoleread+0xb6>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
801009c2:	a1 74 de 10 80       	mov    0x8010de74,%eax
801009c7:	83 e8 01             	sub    $0x1,%eax
801009ca:	a3 74 de 10 80       	mov    %eax,0x8010de74
      }
      break;
801009cf:	eb 26                	jmp    801009f7 <consoleread+0xdc>
801009d1:	eb 24                	jmp    801009f7 <consoleread+0xdc>
    }
    *dst++ = c;
801009d3:	8b 45 0c             	mov    0xc(%ebp),%eax
801009d6:	8d 50 01             	lea    0x1(%eax),%edx
801009d9:	89 55 0c             	mov    %edx,0xc(%ebp)
801009dc:	8b 55 f0             	mov    -0x10(%ebp),%edx
801009df:	88 10                	mov    %dl,(%eax)
    --n;
801009e1:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
801009e5:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
801009e9:	75 02                	jne    801009ed <consoleread+0xd2>
      break;
801009eb:	eb 0a                	jmp    801009f7 <consoleread+0xdc>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
801009ed:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801009f1:	0f 8f 4c ff ff ff    	jg     80100943 <consoleread+0x28>
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
801009f7:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
801009fe:	e8 de 46 00 00       	call   801050e1 <release>
  ilock(ip);
80100a03:	8b 45 08             	mov    0x8(%ebp),%eax
80100a06:	89 04 24             	mov    %eax,(%esp)
80100a09:	e8 48 0e 00 00       	call   80101856 <ilock>

  return target - n;
80100a0e:	8b 45 10             	mov    0x10(%ebp),%eax
80100a11:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a14:	29 c2                	sub    %eax,%edx
80100a16:	89 d0                	mov    %edx,%eax
}
80100a18:	c9                   	leave  
80100a19:	c3                   	ret    

80100a1a <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a1a:	55                   	push   %ebp
80100a1b:	89 e5                	mov    %esp,%ebp
80100a1d:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100a20:	8b 45 08             	mov    0x8(%ebp),%eax
80100a23:	89 04 24             	mov    %eax,(%esp)
80100a26:	e8 79 0f 00 00       	call   801019a4 <iunlock>
  acquire(&cons.lock);
80100a2b:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100a32:	e8 48 46 00 00       	call   8010507f <acquire>
  for(i = 0; i < n; i++)
80100a37:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a3e:	eb 1d                	jmp    80100a5d <consolewrite+0x43>
    consputc(buf[i] & 0xff);
80100a40:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a43:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a46:	01 d0                	add    %edx,%eax
80100a48:	0f b6 00             	movzbl (%eax),%eax
80100a4b:	0f be c0             	movsbl %al,%eax
80100a4e:	0f b6 c0             	movzbl %al,%eax
80100a51:	89 04 24             	mov    %eax,(%esp)
80100a54:	e8 f7 fc ff ff       	call   80100750 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100a59:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100a60:	3b 45 10             	cmp    0x10(%ebp),%eax
80100a63:	7c db                	jl     80100a40 <consolewrite+0x26>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100a65:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100a6c:	e8 70 46 00 00       	call   801050e1 <release>
  ilock(ip);
80100a71:	8b 45 08             	mov    0x8(%ebp),%eax
80100a74:	89 04 24             	mov    %eax,(%esp)
80100a77:	e8 da 0d 00 00       	call   80101856 <ilock>

  return n;
80100a7c:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100a7f:	c9                   	leave  
80100a80:	c3                   	ret    

80100a81 <consoleinit>:

void
consoleinit(void)
{
80100a81:	55                   	push   %ebp
80100a82:	89 e5                	mov    %esp,%ebp
80100a84:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100a87:	c7 44 24 04 77 87 10 	movl   $0x80108777,0x4(%esp)
80100a8e:	80 
80100a8f:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100a96:	e8 c3 45 00 00       	call   8010505e <initlock>
  initlock(&input.lock, "input");
80100a9b:	c7 44 24 04 7f 87 10 	movl   $0x8010877f,0x4(%esp)
80100aa2:	80 
80100aa3:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
80100aaa:	e8 af 45 00 00       	call   8010505e <initlock>

  devsw[CONSOLE].write = consolewrite;
80100aaf:	c7 05 2c e8 10 80 1a 	movl   $0x80100a1a,0x8010e82c
80100ab6:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100ab9:	c7 05 28 e8 10 80 1b 	movl   $0x8010091b,0x8010e828
80100ac0:	09 10 80 
  cons.locking = 1;
80100ac3:	c7 05 14 b6 10 80 01 	movl   $0x1,0x8010b614
80100aca:	00 00 00 

  picenable(IRQ_KBD);
80100acd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100ad4:	e8 90 2f 00 00       	call   80103a69 <picenable>
  ioapicenable(IRQ_KBD, 0);
80100ad9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100ae0:	00 
80100ae1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100ae8:	e8 6f 1e 00 00       	call   8010295c <ioapicenable>
}
80100aed:	c9                   	leave  
80100aee:	c3                   	ret    
80100aef:	90                   	nop

80100af0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100af0:	55                   	push   %ebp
80100af1:	89 e5                	mov    %esp,%ebp
80100af3:	81 ec 38 01 00 00    	sub    $0x138,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
80100af9:	8b 45 08             	mov    0x8(%ebp),%eax
80100afc:	89 04 24             	mov    %eax,(%esp)
80100aff:	e8 fd 18 00 00       	call   80102401 <namei>
80100b04:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b07:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b0b:	75 0a                	jne    80100b17 <exec+0x27>
    return -1;
80100b0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b12:	e9 ea 03 00 00       	jmp    80100f01 <exec+0x411>
  ilock(ip);
80100b17:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100b1a:	89 04 24             	mov    %eax,(%esp)
80100b1d:	e8 34 0d 00 00       	call   80101856 <ilock>
  pgdir = 0;
80100b22:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100b29:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100b30:	00 
80100b31:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100b38:	00 
80100b39:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100b3f:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b43:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100b46:	89 04 24             	mov    %eax,(%esp)
80100b49:	e8 15 12 00 00       	call   80101d63 <readi>
80100b4e:	83 f8 33             	cmp    $0x33,%eax
80100b51:	77 05                	ja     80100b58 <exec+0x68>
    goto bad;
80100b53:	e9 82 03 00 00       	jmp    80100eda <exec+0x3ea>
  if(elf.magic != ELF_MAGIC)
80100b58:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b5e:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100b63:	74 05                	je     80100b6a <exec+0x7a>
    goto bad;
80100b65:	e9 70 03 00 00       	jmp    80100eda <exec+0x3ea>

  if((pgdir = setupkvm()) == 0)
80100b6a:	e8 4e 73 00 00       	call   80107ebd <setupkvm>
80100b6f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100b72:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100b76:	75 05                	jne    80100b7d <exec+0x8d>
    goto bad;
80100b78:	e9 5d 03 00 00       	jmp    80100eda <exec+0x3ea>

  // Load program into memory.
  sz = PGSIZE - 1;
80100b7d:	c7 45 e0 ff 0f 00 00 	movl   $0xfff,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b84:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100b8b:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100b91:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100b94:	e9 cb 00 00 00       	jmp    80100c64 <exec+0x174>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b99:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100b9c:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100ba3:	00 
80100ba4:	89 44 24 08          	mov    %eax,0x8(%esp)
80100ba8:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100bae:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bb2:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100bb5:	89 04 24             	mov    %eax,(%esp)
80100bb8:	e8 a6 11 00 00       	call   80101d63 <readi>
80100bbd:	83 f8 20             	cmp    $0x20,%eax
80100bc0:	74 05                	je     80100bc7 <exec+0xd7>
      goto bad;
80100bc2:	e9 13 03 00 00       	jmp    80100eda <exec+0x3ea>
    if(ph.type != ELF_PROG_LOAD)
80100bc7:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100bcd:	83 f8 01             	cmp    $0x1,%eax
80100bd0:	74 05                	je     80100bd7 <exec+0xe7>
      continue;
80100bd2:	e9 80 00 00 00       	jmp    80100c57 <exec+0x167>
    if(ph.memsz < ph.filesz)
80100bd7:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100bdd:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100be3:	39 c2                	cmp    %eax,%edx
80100be5:	73 05                	jae    80100bec <exec+0xfc>
      goto bad;
80100be7:	e9 ee 02 00 00       	jmp    80100eda <exec+0x3ea>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bec:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100bf2:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100bf8:	01 d0                	add    %edx,%eax
80100bfa:	89 44 24 08          	mov    %eax,0x8(%esp)
80100bfe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100c01:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c05:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100c08:	89 04 24             	mov    %eax,(%esp)
80100c0b:	e8 7b 76 00 00       	call   8010828b <allocuvm>
80100c10:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c13:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c17:	75 05                	jne    80100c1e <exec+0x12e>
      goto bad;
80100c19:	e9 bc 02 00 00       	jmp    80100eda <exec+0x3ea>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c1e:	8b 8d fc fe ff ff    	mov    -0x104(%ebp),%ecx
80100c24:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100c2a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c30:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80100c34:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100c38:	8b 55 d8             	mov    -0x28(%ebp),%edx
80100c3b:	89 54 24 08          	mov    %edx,0x8(%esp)
80100c3f:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c43:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100c46:	89 04 24             	mov    %eax,(%esp)
80100c49:	e8 52 75 00 00       	call   801081a0 <loaduvm>
80100c4e:	85 c0                	test   %eax,%eax
80100c50:	79 05                	jns    80100c57 <exec+0x167>
      goto bad;
80100c52:	e9 83 02 00 00       	jmp    80100eda <exec+0x3ea>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = PGSIZE - 1;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c57:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100c5b:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c5e:	83 c0 20             	add    $0x20,%eax
80100c61:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c64:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100c6b:	0f b7 c0             	movzwl %ax,%eax
80100c6e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100c71:	0f 8f 22 ff ff ff    	jg     80100b99 <exec+0xa9>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100c77:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100c7a:	89 04 24             	mov    %eax,(%esp)
80100c7d:	e8 58 0e 00 00       	call   80101ada <iunlockput>
  ip = 0;
80100c82:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100c89:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100c8c:	05 ff 0f 00 00       	add    $0xfff,%eax
80100c91:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100c96:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c99:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100c9c:	05 00 20 00 00       	add    $0x2000,%eax
80100ca1:	89 44 24 08          	mov    %eax,0x8(%esp)
80100ca5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ca8:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cac:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100caf:	89 04 24             	mov    %eax,(%esp)
80100cb2:	e8 d4 75 00 00       	call   8010828b <allocuvm>
80100cb7:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100cba:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100cbe:	75 05                	jne    80100cc5 <exec+0x1d5>
    goto bad;
80100cc0:	e9 15 02 00 00       	jmp    80100eda <exec+0x3ea>
  proc->pstack = (uint *)sz;
80100cc5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ccb:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100cce:	89 50 7c             	mov    %edx,0x7c(%eax)

  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cd4:	2d 00 20 00 00       	sub    $0x2000,%eax
80100cd9:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cdd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100ce0:	89 04 24             	mov    %eax,(%esp)
80100ce3:	e8 d3 77 00 00       	call   801084bb <clearpteu>

  sp = sz;
80100ce8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ceb:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100cee:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100cf5:	e9 9a 00 00 00       	jmp    80100d94 <exec+0x2a4>
    if(argc >= MAXARG)
80100cfa:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100cfe:	76 05                	jbe    80100d05 <exec+0x215>
      goto bad;
80100d00:	e9 d5 01 00 00       	jmp    80100eda <exec+0x3ea>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d05:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d08:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d0f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d12:	01 d0                	add    %edx,%eax
80100d14:	8b 00                	mov    (%eax),%eax
80100d16:	89 04 24             	mov    %eax,(%esp)
80100d19:	e8 22 48 00 00       	call   80105540 <strlen>
80100d1e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100d21:	29 c2                	sub    %eax,%edx
80100d23:	89 d0                	mov    %edx,%eax
80100d25:	83 e8 01             	sub    $0x1,%eax
80100d28:	83 e0 fc             	and    $0xfffffffc,%eax
80100d2b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d2e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d31:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d38:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d3b:	01 d0                	add    %edx,%eax
80100d3d:	8b 00                	mov    (%eax),%eax
80100d3f:	89 04 24             	mov    %eax,(%esp)
80100d42:	e8 f9 47 00 00       	call   80105540 <strlen>
80100d47:	83 c0 01             	add    $0x1,%eax
80100d4a:	89 c2                	mov    %eax,%edx
80100d4c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d4f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
80100d56:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d59:	01 c8                	add    %ecx,%eax
80100d5b:	8b 00                	mov    (%eax),%eax
80100d5d:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100d61:	89 44 24 08          	mov    %eax,0x8(%esp)
80100d65:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d68:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d6c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100d6f:	89 04 24             	mov    %eax,(%esp)
80100d72:	e8 09 79 00 00       	call   80108680 <copyout>
80100d77:	85 c0                	test   %eax,%eax
80100d79:	79 05                	jns    80100d80 <exec+0x290>
      goto bad;
80100d7b:	e9 5a 01 00 00       	jmp    80100eda <exec+0x3ea>
    ustack[3+argc] = sp;
80100d80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d83:	8d 50 03             	lea    0x3(%eax),%edx
80100d86:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d89:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));

  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d90:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100d94:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d97:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d9e:	8b 45 0c             	mov    0xc(%ebp),%eax
80100da1:	01 d0                	add    %edx,%eax
80100da3:	8b 00                	mov    (%eax),%eax
80100da5:	85 c0                	test   %eax,%eax
80100da7:	0f 85 4d ff ff ff    	jne    80100cfa <exec+0x20a>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100dad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100db0:	83 c0 03             	add    $0x3,%eax
80100db3:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100dba:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100dbe:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100dc5:	ff ff ff 
  ustack[1] = argc;
80100dc8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dcb:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100dd1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dd4:	83 c0 01             	add    $0x1,%eax
80100dd7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dde:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100de1:	29 d0                	sub    %edx,%eax
80100de3:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100de9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dec:	83 c0 04             	add    $0x4,%eax
80100def:	c1 e0 02             	shl    $0x2,%eax
80100df2:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100df5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100df8:	83 c0 04             	add    $0x4,%eax
80100dfb:	c1 e0 02             	shl    $0x2,%eax
80100dfe:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100e02:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100e08:	89 44 24 08          	mov    %eax,0x8(%esp)
80100e0c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e0f:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e13:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100e16:	89 04 24             	mov    %eax,(%esp)
80100e19:	e8 62 78 00 00       	call   80108680 <copyout>
80100e1e:	85 c0                	test   %eax,%eax
80100e20:	79 05                	jns    80100e27 <exec+0x337>
    goto bad;
80100e22:	e9 b3 00 00 00       	jmp    80100eda <exec+0x3ea>

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e27:	8b 45 08             	mov    0x8(%ebp),%eax
80100e2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e30:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e33:	eb 17                	jmp    80100e4c <exec+0x35c>
    if(*s == '/')
80100e35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e38:	0f b6 00             	movzbl (%eax),%eax
80100e3b:	3c 2f                	cmp    $0x2f,%al
80100e3d:	75 09                	jne    80100e48 <exec+0x358>
      last = s+1;
80100e3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e42:	83 c0 01             	add    $0x1,%eax
80100e45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e48:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e4f:	0f b6 00             	movzbl (%eax),%eax
80100e52:	84 c0                	test   %al,%al
80100e54:	75 df                	jne    80100e35 <exec+0x345>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e56:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e5c:	8d 50 6c             	lea    0x6c(%eax),%edx
80100e5f:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100e66:	00 
80100e67:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100e6a:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e6e:	89 14 24             	mov    %edx,(%esp)
80100e71:	e8 80 46 00 00       	call   801054f6 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100e76:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e7c:	8b 40 04             	mov    0x4(%eax),%eax
80100e7f:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100e82:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e88:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100e8b:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100e8e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e94:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100e97:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100e99:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e9f:	8b 40 18             	mov    0x18(%eax),%eax
80100ea2:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100ea8:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100eab:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eb1:	8b 40 18             	mov    0x18(%eax),%eax
80100eb4:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100eb7:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100eba:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ec0:	89 04 24             	mov    %eax,(%esp)
80100ec3:	e8 e6 70 00 00       	call   80107fae <switchuvm>
  freevm(oldpgdir);
80100ec8:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100ecb:	89 04 24             	mov    %eax,(%esp)
80100ece:	e8 4e 75 00 00       	call   80108421 <freevm>
  return 0;
80100ed3:	b8 00 00 00 00       	mov    $0x0,%eax
80100ed8:	eb 27                	jmp    80100f01 <exec+0x411>

 bad:
  if(pgdir)
80100eda:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100ede:	74 0b                	je     80100eeb <exec+0x3fb>
    freevm(pgdir);
80100ee0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100ee3:	89 04 24             	mov    %eax,(%esp)
80100ee6:	e8 36 75 00 00       	call   80108421 <freevm>
  if(ip)
80100eeb:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100eef:	74 0b                	je     80100efc <exec+0x40c>
    iunlockput(ip);
80100ef1:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100ef4:	89 04 24             	mov    %eax,(%esp)
80100ef7:	e8 de 0b 00 00       	call   80101ada <iunlockput>
  return -1;
80100efc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f01:	c9                   	leave  
80100f02:	c3                   	ret    
80100f03:	90                   	nop

80100f04 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f04:	55                   	push   %ebp
80100f05:	89 e5                	mov    %esp,%ebp
80100f07:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100f0a:	c7 44 24 04 85 87 10 	movl   $0x80108785,0x4(%esp)
80100f11:	80 
80100f12:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100f19:	e8 40 41 00 00       	call   8010505e <initlock>
}
80100f1e:	c9                   	leave  
80100f1f:	c3                   	ret    

80100f20 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f20:	55                   	push   %ebp
80100f21:	89 e5                	mov    %esp,%ebp
80100f23:	83 ec 28             	sub    $0x28,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f26:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100f2d:	e8 4d 41 00 00       	call   8010507f <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f32:	c7 45 f4 b4 de 10 80 	movl   $0x8010deb4,-0xc(%ebp)
80100f39:	eb 29                	jmp    80100f64 <filealloc+0x44>
    if(f->ref == 0){
80100f3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f3e:	8b 40 04             	mov    0x4(%eax),%eax
80100f41:	85 c0                	test   %eax,%eax
80100f43:	75 1b                	jne    80100f60 <filealloc+0x40>
      f->ref = 1;
80100f45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f48:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100f4f:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100f56:	e8 86 41 00 00       	call   801050e1 <release>
      return f;
80100f5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f5e:	eb 1e                	jmp    80100f7e <filealloc+0x5e>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f60:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100f64:	81 7d f4 14 e8 10 80 	cmpl   $0x8010e814,-0xc(%ebp)
80100f6b:	72 ce                	jb     80100f3b <filealloc+0x1b>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100f6d:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100f74:	e8 68 41 00 00       	call   801050e1 <release>
  return 0;
80100f79:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100f7e:	c9                   	leave  
80100f7f:	c3                   	ret    

80100f80 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f80:	55                   	push   %ebp
80100f81:	89 e5                	mov    %esp,%ebp
80100f83:	83 ec 18             	sub    $0x18,%esp
  acquire(&ftable.lock);
80100f86:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100f8d:	e8 ed 40 00 00       	call   8010507f <acquire>
  if(f->ref < 1)
80100f92:	8b 45 08             	mov    0x8(%ebp),%eax
80100f95:	8b 40 04             	mov    0x4(%eax),%eax
80100f98:	85 c0                	test   %eax,%eax
80100f9a:	7f 0c                	jg     80100fa8 <filedup+0x28>
    panic("filedup");
80100f9c:	c7 04 24 8c 87 10 80 	movl   $0x8010878c,(%esp)
80100fa3:	e8 92 f5 ff ff       	call   8010053a <panic>
  f->ref++;
80100fa8:	8b 45 08             	mov    0x8(%ebp),%eax
80100fab:	8b 40 04             	mov    0x4(%eax),%eax
80100fae:	8d 50 01             	lea    0x1(%eax),%edx
80100fb1:	8b 45 08             	mov    0x8(%ebp),%eax
80100fb4:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80100fb7:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100fbe:	e8 1e 41 00 00       	call   801050e1 <release>
  return f;
80100fc3:	8b 45 08             	mov    0x8(%ebp),%eax
}
80100fc6:	c9                   	leave  
80100fc7:	c3                   	ret    

80100fc8 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100fc8:	55                   	push   %ebp
80100fc9:	89 e5                	mov    %esp,%ebp
80100fcb:	83 ec 38             	sub    $0x38,%esp
  struct file ff;

  acquire(&ftable.lock);
80100fce:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100fd5:	e8 a5 40 00 00       	call   8010507f <acquire>
  if(f->ref < 1)
80100fda:	8b 45 08             	mov    0x8(%ebp),%eax
80100fdd:	8b 40 04             	mov    0x4(%eax),%eax
80100fe0:	85 c0                	test   %eax,%eax
80100fe2:	7f 0c                	jg     80100ff0 <fileclose+0x28>
    panic("fileclose");
80100fe4:	c7 04 24 94 87 10 80 	movl   $0x80108794,(%esp)
80100feb:	e8 4a f5 ff ff       	call   8010053a <panic>
  if(--f->ref > 0){
80100ff0:	8b 45 08             	mov    0x8(%ebp),%eax
80100ff3:	8b 40 04             	mov    0x4(%eax),%eax
80100ff6:	8d 50 ff             	lea    -0x1(%eax),%edx
80100ff9:	8b 45 08             	mov    0x8(%ebp),%eax
80100ffc:	89 50 04             	mov    %edx,0x4(%eax)
80100fff:	8b 45 08             	mov    0x8(%ebp),%eax
80101002:	8b 40 04             	mov    0x4(%eax),%eax
80101005:	85 c0                	test   %eax,%eax
80101007:	7e 11                	jle    8010101a <fileclose+0x52>
    release(&ftable.lock);
80101009:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80101010:	e8 cc 40 00 00       	call   801050e1 <release>
80101015:	e9 82 00 00 00       	jmp    8010109c <fileclose+0xd4>
    return;
  }
  ff = *f;
8010101a:	8b 45 08             	mov    0x8(%ebp),%eax
8010101d:	8b 10                	mov    (%eax),%edx
8010101f:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101022:	8b 50 04             	mov    0x4(%eax),%edx
80101025:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101028:	8b 50 08             	mov    0x8(%eax),%edx
8010102b:	89 55 e8             	mov    %edx,-0x18(%ebp)
8010102e:	8b 50 0c             	mov    0xc(%eax),%edx
80101031:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101034:	8b 50 10             	mov    0x10(%eax),%edx
80101037:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010103a:	8b 40 14             	mov    0x14(%eax),%eax
8010103d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101040:	8b 45 08             	mov    0x8(%ebp),%eax
80101043:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
8010104a:	8b 45 08             	mov    0x8(%ebp),%eax
8010104d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
80101053:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
8010105a:	e8 82 40 00 00       	call   801050e1 <release>
  
  if(ff.type == FD_PIPE)
8010105f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101062:	83 f8 01             	cmp    $0x1,%eax
80101065:	75 18                	jne    8010107f <fileclose+0xb7>
    pipeclose(ff.pipe, ff.writable);
80101067:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
8010106b:	0f be d0             	movsbl %al,%edx
8010106e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101071:	89 54 24 04          	mov    %edx,0x4(%esp)
80101075:	89 04 24             	mov    %eax,(%esp)
80101078:	e8 9e 2c 00 00       	call   80103d1b <pipeclose>
8010107d:	eb 1d                	jmp    8010109c <fileclose+0xd4>
  else if(ff.type == FD_INODE){
8010107f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101082:	83 f8 02             	cmp    $0x2,%eax
80101085:	75 15                	jne    8010109c <fileclose+0xd4>
    begin_trans();
80101087:	e8 5a 21 00 00       	call   801031e6 <begin_trans>
    iput(ff.ip);
8010108c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010108f:	89 04 24             	mov    %eax,(%esp)
80101092:	e8 72 09 00 00       	call   80101a09 <iput>
    commit_trans();
80101097:	e8 93 21 00 00       	call   8010322f <commit_trans>
  }
}
8010109c:	c9                   	leave  
8010109d:	c3                   	ret    

8010109e <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
8010109e:	55                   	push   %ebp
8010109f:	89 e5                	mov    %esp,%ebp
801010a1:	83 ec 18             	sub    $0x18,%esp
  if(f->type == FD_INODE){
801010a4:	8b 45 08             	mov    0x8(%ebp),%eax
801010a7:	8b 00                	mov    (%eax),%eax
801010a9:	83 f8 02             	cmp    $0x2,%eax
801010ac:	75 38                	jne    801010e6 <filestat+0x48>
    ilock(f->ip);
801010ae:	8b 45 08             	mov    0x8(%ebp),%eax
801010b1:	8b 40 10             	mov    0x10(%eax),%eax
801010b4:	89 04 24             	mov    %eax,(%esp)
801010b7:	e8 9a 07 00 00       	call   80101856 <ilock>
    stati(f->ip, st);
801010bc:	8b 45 08             	mov    0x8(%ebp),%eax
801010bf:	8b 40 10             	mov    0x10(%eax),%eax
801010c2:	8b 55 0c             	mov    0xc(%ebp),%edx
801010c5:	89 54 24 04          	mov    %edx,0x4(%esp)
801010c9:	89 04 24             	mov    %eax,(%esp)
801010cc:	e8 4d 0c 00 00       	call   80101d1e <stati>
    iunlock(f->ip);
801010d1:	8b 45 08             	mov    0x8(%ebp),%eax
801010d4:	8b 40 10             	mov    0x10(%eax),%eax
801010d7:	89 04 24             	mov    %eax,(%esp)
801010da:	e8 c5 08 00 00       	call   801019a4 <iunlock>
    return 0;
801010df:	b8 00 00 00 00       	mov    $0x0,%eax
801010e4:	eb 05                	jmp    801010eb <filestat+0x4d>
  }
  return -1;
801010e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801010eb:	c9                   	leave  
801010ec:	c3                   	ret    

801010ed <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801010ed:	55                   	push   %ebp
801010ee:	89 e5                	mov    %esp,%ebp
801010f0:	83 ec 28             	sub    $0x28,%esp
  int r;

  if(f->readable == 0)
801010f3:	8b 45 08             	mov    0x8(%ebp),%eax
801010f6:	0f b6 40 08          	movzbl 0x8(%eax),%eax
801010fa:	84 c0                	test   %al,%al
801010fc:	75 0a                	jne    80101108 <fileread+0x1b>
    return -1;
801010fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101103:	e9 9f 00 00 00       	jmp    801011a7 <fileread+0xba>
  if(f->type == FD_PIPE)
80101108:	8b 45 08             	mov    0x8(%ebp),%eax
8010110b:	8b 00                	mov    (%eax),%eax
8010110d:	83 f8 01             	cmp    $0x1,%eax
80101110:	75 1e                	jne    80101130 <fileread+0x43>
    return piperead(f->pipe, addr, n);
80101112:	8b 45 08             	mov    0x8(%ebp),%eax
80101115:	8b 40 0c             	mov    0xc(%eax),%eax
80101118:	8b 55 10             	mov    0x10(%ebp),%edx
8010111b:	89 54 24 08          	mov    %edx,0x8(%esp)
8010111f:	8b 55 0c             	mov    0xc(%ebp),%edx
80101122:	89 54 24 04          	mov    %edx,0x4(%esp)
80101126:	89 04 24             	mov    %eax,(%esp)
80101129:	e8 6e 2d 00 00       	call   80103e9c <piperead>
8010112e:	eb 77                	jmp    801011a7 <fileread+0xba>
  if(f->type == FD_INODE){
80101130:	8b 45 08             	mov    0x8(%ebp),%eax
80101133:	8b 00                	mov    (%eax),%eax
80101135:	83 f8 02             	cmp    $0x2,%eax
80101138:	75 61                	jne    8010119b <fileread+0xae>
    ilock(f->ip);
8010113a:	8b 45 08             	mov    0x8(%ebp),%eax
8010113d:	8b 40 10             	mov    0x10(%eax),%eax
80101140:	89 04 24             	mov    %eax,(%esp)
80101143:	e8 0e 07 00 00       	call   80101856 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101148:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010114b:	8b 45 08             	mov    0x8(%ebp),%eax
8010114e:	8b 50 14             	mov    0x14(%eax),%edx
80101151:	8b 45 08             	mov    0x8(%ebp),%eax
80101154:	8b 40 10             	mov    0x10(%eax),%eax
80101157:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010115b:	89 54 24 08          	mov    %edx,0x8(%esp)
8010115f:	8b 55 0c             	mov    0xc(%ebp),%edx
80101162:	89 54 24 04          	mov    %edx,0x4(%esp)
80101166:	89 04 24             	mov    %eax,(%esp)
80101169:	e8 f5 0b 00 00       	call   80101d63 <readi>
8010116e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101171:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101175:	7e 11                	jle    80101188 <fileread+0x9b>
      f->off += r;
80101177:	8b 45 08             	mov    0x8(%ebp),%eax
8010117a:	8b 50 14             	mov    0x14(%eax),%edx
8010117d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101180:	01 c2                	add    %eax,%edx
80101182:	8b 45 08             	mov    0x8(%ebp),%eax
80101185:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
80101188:	8b 45 08             	mov    0x8(%ebp),%eax
8010118b:	8b 40 10             	mov    0x10(%eax),%eax
8010118e:	89 04 24             	mov    %eax,(%esp)
80101191:	e8 0e 08 00 00       	call   801019a4 <iunlock>
    return r;
80101196:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101199:	eb 0c                	jmp    801011a7 <fileread+0xba>
  }
  panic("fileread");
8010119b:	c7 04 24 9e 87 10 80 	movl   $0x8010879e,(%esp)
801011a2:	e8 93 f3 ff ff       	call   8010053a <panic>
}
801011a7:	c9                   	leave  
801011a8:	c3                   	ret    

801011a9 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011a9:	55                   	push   %ebp
801011aa:	89 e5                	mov    %esp,%ebp
801011ac:	53                   	push   %ebx
801011ad:	83 ec 24             	sub    $0x24,%esp
  int r;

  if(f->writable == 0)
801011b0:	8b 45 08             	mov    0x8(%ebp),%eax
801011b3:	0f b6 40 09          	movzbl 0x9(%eax),%eax
801011b7:	84 c0                	test   %al,%al
801011b9:	75 0a                	jne    801011c5 <filewrite+0x1c>
    return -1;
801011bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011c0:	e9 20 01 00 00       	jmp    801012e5 <filewrite+0x13c>
  if(f->type == FD_PIPE)
801011c5:	8b 45 08             	mov    0x8(%ebp),%eax
801011c8:	8b 00                	mov    (%eax),%eax
801011ca:	83 f8 01             	cmp    $0x1,%eax
801011cd:	75 21                	jne    801011f0 <filewrite+0x47>
    return pipewrite(f->pipe, addr, n);
801011cf:	8b 45 08             	mov    0x8(%ebp),%eax
801011d2:	8b 40 0c             	mov    0xc(%eax),%eax
801011d5:	8b 55 10             	mov    0x10(%ebp),%edx
801011d8:	89 54 24 08          	mov    %edx,0x8(%esp)
801011dc:	8b 55 0c             	mov    0xc(%ebp),%edx
801011df:	89 54 24 04          	mov    %edx,0x4(%esp)
801011e3:	89 04 24             	mov    %eax,(%esp)
801011e6:	e8 c2 2b 00 00       	call   80103dad <pipewrite>
801011eb:	e9 f5 00 00 00       	jmp    801012e5 <filewrite+0x13c>
  if(f->type == FD_INODE){
801011f0:	8b 45 08             	mov    0x8(%ebp),%eax
801011f3:	8b 00                	mov    (%eax),%eax
801011f5:	83 f8 02             	cmp    $0x2,%eax
801011f8:	0f 85 db 00 00 00    	jne    801012d9 <filewrite+0x130>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
801011fe:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
80101205:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
8010120c:	e9 a8 00 00 00       	jmp    801012b9 <filewrite+0x110>
      int n1 = n - i;
80101211:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101214:	8b 55 10             	mov    0x10(%ebp),%edx
80101217:	29 c2                	sub    %eax,%edx
80101219:	89 d0                	mov    %edx,%eax
8010121b:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
8010121e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101221:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80101224:	7e 06                	jle    8010122c <filewrite+0x83>
        n1 = max;
80101226:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101229:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_trans();
8010122c:	e8 b5 1f 00 00       	call   801031e6 <begin_trans>
      ilock(f->ip);
80101231:	8b 45 08             	mov    0x8(%ebp),%eax
80101234:	8b 40 10             	mov    0x10(%eax),%eax
80101237:	89 04 24             	mov    %eax,(%esp)
8010123a:	e8 17 06 00 00       	call   80101856 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010123f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80101242:	8b 45 08             	mov    0x8(%ebp),%eax
80101245:	8b 50 14             	mov    0x14(%eax),%edx
80101248:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010124b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010124e:	01 c3                	add    %eax,%ebx
80101250:	8b 45 08             	mov    0x8(%ebp),%eax
80101253:	8b 40 10             	mov    0x10(%eax),%eax
80101256:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010125a:	89 54 24 08          	mov    %edx,0x8(%esp)
8010125e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101262:	89 04 24             	mov    %eax,(%esp)
80101265:	e8 5d 0c 00 00       	call   80101ec7 <writei>
8010126a:	89 45 e8             	mov    %eax,-0x18(%ebp)
8010126d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101271:	7e 11                	jle    80101284 <filewrite+0xdb>
        f->off += r;
80101273:	8b 45 08             	mov    0x8(%ebp),%eax
80101276:	8b 50 14             	mov    0x14(%eax),%edx
80101279:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010127c:	01 c2                	add    %eax,%edx
8010127e:	8b 45 08             	mov    0x8(%ebp),%eax
80101281:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
80101284:	8b 45 08             	mov    0x8(%ebp),%eax
80101287:	8b 40 10             	mov    0x10(%eax),%eax
8010128a:	89 04 24             	mov    %eax,(%esp)
8010128d:	e8 12 07 00 00       	call   801019a4 <iunlock>
      commit_trans();
80101292:	e8 98 1f 00 00       	call   8010322f <commit_trans>

      if(r < 0)
80101297:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010129b:	79 02                	jns    8010129f <filewrite+0xf6>
        break;
8010129d:	eb 26                	jmp    801012c5 <filewrite+0x11c>
      if(r != n1)
8010129f:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012a2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801012a5:	74 0c                	je     801012b3 <filewrite+0x10a>
        panic("short filewrite");
801012a7:	c7 04 24 a7 87 10 80 	movl   $0x801087a7,(%esp)
801012ae:	e8 87 f2 ff ff       	call   8010053a <panic>
      i += r;
801012b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012b6:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801012b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012bc:	3b 45 10             	cmp    0x10(%ebp),%eax
801012bf:	0f 8c 4c ff ff ff    	jl     80101211 <filewrite+0x68>
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801012c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012c8:	3b 45 10             	cmp    0x10(%ebp),%eax
801012cb:	75 05                	jne    801012d2 <filewrite+0x129>
801012cd:	8b 45 10             	mov    0x10(%ebp),%eax
801012d0:	eb 05                	jmp    801012d7 <filewrite+0x12e>
801012d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012d7:	eb 0c                	jmp    801012e5 <filewrite+0x13c>
  }
  panic("filewrite");
801012d9:	c7 04 24 b7 87 10 80 	movl   $0x801087b7,(%esp)
801012e0:	e8 55 f2 ff ff       	call   8010053a <panic>
}
801012e5:	83 c4 24             	add    $0x24,%esp
801012e8:	5b                   	pop    %ebx
801012e9:	5d                   	pop    %ebp
801012ea:	c3                   	ret    
801012eb:	90                   	nop

801012ec <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801012ec:	55                   	push   %ebp
801012ed:	89 e5                	mov    %esp,%ebp
801012ef:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
801012f2:	8b 45 08             	mov    0x8(%ebp),%eax
801012f5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801012fc:	00 
801012fd:	89 04 24             	mov    %eax,(%esp)
80101300:	e8 a1 ee ff ff       	call   801001a6 <bread>
80101305:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101308:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010130b:	83 c0 18             	add    $0x18,%eax
8010130e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80101315:	00 
80101316:	89 44 24 04          	mov    %eax,0x4(%esp)
8010131a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010131d:	89 04 24             	mov    %eax,(%esp)
80101320:	e8 80 40 00 00       	call   801053a5 <memmove>
  brelse(bp);
80101325:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101328:	89 04 24             	mov    %eax,(%esp)
8010132b:	e8 e7 ee ff ff       	call   80100217 <brelse>
}
80101330:	c9                   	leave  
80101331:	c3                   	ret    

80101332 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
80101332:	55                   	push   %ebp
80101333:	89 e5                	mov    %esp,%ebp
80101335:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
80101338:	8b 55 0c             	mov    0xc(%ebp),%edx
8010133b:	8b 45 08             	mov    0x8(%ebp),%eax
8010133e:	89 54 24 04          	mov    %edx,0x4(%esp)
80101342:	89 04 24             	mov    %eax,(%esp)
80101345:	e8 5c ee ff ff       	call   801001a6 <bread>
8010134a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
8010134d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101350:	83 c0 18             	add    $0x18,%eax
80101353:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
8010135a:	00 
8010135b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101362:	00 
80101363:	89 04 24             	mov    %eax,(%esp)
80101366:	e8 6b 3f 00 00       	call   801052d6 <memset>
  log_write(bp);
8010136b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010136e:	89 04 24             	mov    %eax,(%esp)
80101371:	e8 11 1f 00 00       	call   80103287 <log_write>
  brelse(bp);
80101376:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101379:	89 04 24             	mov    %eax,(%esp)
8010137c:	e8 96 ee ff ff       	call   80100217 <brelse>
}
80101381:	c9                   	leave  
80101382:	c3                   	ret    

80101383 <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101383:	55                   	push   %ebp
80101384:	89 e5                	mov    %esp,%ebp
80101386:	83 ec 38             	sub    $0x38,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
80101389:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  readsb(dev, &sb);
80101390:	8b 45 08             	mov    0x8(%ebp),%eax
80101393:	8d 55 d8             	lea    -0x28(%ebp),%edx
80101396:	89 54 24 04          	mov    %edx,0x4(%esp)
8010139a:	89 04 24             	mov    %eax,(%esp)
8010139d:	e8 4a ff ff ff       	call   801012ec <readsb>
  for(b = 0; b < sb.size; b += BPB){
801013a2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801013a9:	e9 07 01 00 00       	jmp    801014b5 <balloc+0x132>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
801013ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013b1:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801013b7:	85 c0                	test   %eax,%eax
801013b9:	0f 48 c2             	cmovs  %edx,%eax
801013bc:	c1 f8 0c             	sar    $0xc,%eax
801013bf:	8b 55 e0             	mov    -0x20(%ebp),%edx
801013c2:	c1 ea 03             	shr    $0x3,%edx
801013c5:	01 d0                	add    %edx,%eax
801013c7:	83 c0 03             	add    $0x3,%eax
801013ca:	89 44 24 04          	mov    %eax,0x4(%esp)
801013ce:	8b 45 08             	mov    0x8(%ebp),%eax
801013d1:	89 04 24             	mov    %eax,(%esp)
801013d4:	e8 cd ed ff ff       	call   801001a6 <bread>
801013d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013dc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801013e3:	e9 9d 00 00 00       	jmp    80101485 <balloc+0x102>
      m = 1 << (bi % 8);
801013e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801013eb:	99                   	cltd   
801013ec:	c1 ea 1d             	shr    $0x1d,%edx
801013ef:	01 d0                	add    %edx,%eax
801013f1:	83 e0 07             	and    $0x7,%eax
801013f4:	29 d0                	sub    %edx,%eax
801013f6:	ba 01 00 00 00       	mov    $0x1,%edx
801013fb:	89 c1                	mov    %eax,%ecx
801013fd:	d3 e2                	shl    %cl,%edx
801013ff:	89 d0                	mov    %edx,%eax
80101401:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101404:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101407:	8d 50 07             	lea    0x7(%eax),%edx
8010140a:	85 c0                	test   %eax,%eax
8010140c:	0f 48 c2             	cmovs  %edx,%eax
8010140f:	c1 f8 03             	sar    $0x3,%eax
80101412:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101415:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
8010141a:	0f b6 c0             	movzbl %al,%eax
8010141d:	23 45 e8             	and    -0x18(%ebp),%eax
80101420:	85 c0                	test   %eax,%eax
80101422:	75 5d                	jne    80101481 <balloc+0xfe>
        bp->data[bi/8] |= m;  // Mark block in use.
80101424:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101427:	8d 50 07             	lea    0x7(%eax),%edx
8010142a:	85 c0                	test   %eax,%eax
8010142c:	0f 48 c2             	cmovs  %edx,%eax
8010142f:	c1 f8 03             	sar    $0x3,%eax
80101432:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101435:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
8010143a:	89 d1                	mov    %edx,%ecx
8010143c:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010143f:	09 ca                	or     %ecx,%edx
80101441:	89 d1                	mov    %edx,%ecx
80101443:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101446:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
8010144a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010144d:	89 04 24             	mov    %eax,(%esp)
80101450:	e8 32 1e 00 00       	call   80103287 <log_write>
        brelse(bp);
80101455:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101458:	89 04 24             	mov    %eax,(%esp)
8010145b:	e8 b7 ed ff ff       	call   80100217 <brelse>
        bzero(dev, b + bi);
80101460:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101463:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101466:	01 c2                	add    %eax,%edx
80101468:	8b 45 08             	mov    0x8(%ebp),%eax
8010146b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010146f:	89 04 24             	mov    %eax,(%esp)
80101472:	e8 bb fe ff ff       	call   80101332 <bzero>
        return b + bi;
80101477:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010147a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010147d:	01 d0                	add    %edx,%eax
8010147f:	eb 4e                	jmp    801014cf <balloc+0x14c>

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101481:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101485:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
8010148c:	7f 15                	jg     801014a3 <balloc+0x120>
8010148e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101491:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101494:	01 d0                	add    %edx,%eax
80101496:	89 c2                	mov    %eax,%edx
80101498:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010149b:	39 c2                	cmp    %eax,%edx
8010149d:	0f 82 45 ff ff ff    	jb     801013e8 <balloc+0x65>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801014a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801014a6:	89 04 24             	mov    %eax,(%esp)
801014a9:	e8 69 ed ff ff       	call   80100217 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
801014ae:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801014b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014b8:	8b 45 d8             	mov    -0x28(%ebp),%eax
801014bb:	39 c2                	cmp    %eax,%edx
801014bd:	0f 82 eb fe ff ff    	jb     801013ae <balloc+0x2b>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801014c3:	c7 04 24 c1 87 10 80 	movl   $0x801087c1,(%esp)
801014ca:	e8 6b f0 ff ff       	call   8010053a <panic>
}
801014cf:	c9                   	leave  
801014d0:	c3                   	ret    

801014d1 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
801014d1:	55                   	push   %ebp
801014d2:	89 e5                	mov    %esp,%ebp
801014d4:	83 ec 38             	sub    $0x38,%esp
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
801014d7:	8d 45 dc             	lea    -0x24(%ebp),%eax
801014da:	89 44 24 04          	mov    %eax,0x4(%esp)
801014de:	8b 45 08             	mov    0x8(%ebp),%eax
801014e1:	89 04 24             	mov    %eax,(%esp)
801014e4:	e8 03 fe ff ff       	call   801012ec <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
801014e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801014ec:	c1 e8 0c             	shr    $0xc,%eax
801014ef:	89 c2                	mov    %eax,%edx
801014f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801014f4:	c1 e8 03             	shr    $0x3,%eax
801014f7:	01 d0                	add    %edx,%eax
801014f9:	8d 50 03             	lea    0x3(%eax),%edx
801014fc:	8b 45 08             	mov    0x8(%ebp),%eax
801014ff:	89 54 24 04          	mov    %edx,0x4(%esp)
80101503:	89 04 24             	mov    %eax,(%esp)
80101506:	e8 9b ec ff ff       	call   801001a6 <bread>
8010150b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
8010150e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101511:	25 ff 0f 00 00       	and    $0xfff,%eax
80101516:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101519:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010151c:	99                   	cltd   
8010151d:	c1 ea 1d             	shr    $0x1d,%edx
80101520:	01 d0                	add    %edx,%eax
80101522:	83 e0 07             	and    $0x7,%eax
80101525:	29 d0                	sub    %edx,%eax
80101527:	ba 01 00 00 00       	mov    $0x1,%edx
8010152c:	89 c1                	mov    %eax,%ecx
8010152e:	d3 e2                	shl    %cl,%edx
80101530:	89 d0                	mov    %edx,%eax
80101532:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
80101535:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101538:	8d 50 07             	lea    0x7(%eax),%edx
8010153b:	85 c0                	test   %eax,%eax
8010153d:	0f 48 c2             	cmovs  %edx,%eax
80101540:	c1 f8 03             	sar    $0x3,%eax
80101543:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101546:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
8010154b:	0f b6 c0             	movzbl %al,%eax
8010154e:	23 45 ec             	and    -0x14(%ebp),%eax
80101551:	85 c0                	test   %eax,%eax
80101553:	75 0c                	jne    80101561 <bfree+0x90>
    panic("freeing free block");
80101555:	c7 04 24 d7 87 10 80 	movl   $0x801087d7,(%esp)
8010155c:	e8 d9 ef ff ff       	call   8010053a <panic>
  bp->data[bi/8] &= ~m;
80101561:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101564:	8d 50 07             	lea    0x7(%eax),%edx
80101567:	85 c0                	test   %eax,%eax
80101569:	0f 48 c2             	cmovs  %edx,%eax
8010156c:	c1 f8 03             	sar    $0x3,%eax
8010156f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101572:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101577:	8b 4d ec             	mov    -0x14(%ebp),%ecx
8010157a:	f7 d1                	not    %ecx
8010157c:	21 ca                	and    %ecx,%edx
8010157e:	89 d1                	mov    %edx,%ecx
80101580:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101583:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
80101587:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010158a:	89 04 24             	mov    %eax,(%esp)
8010158d:	e8 f5 1c 00 00       	call   80103287 <log_write>
  brelse(bp);
80101592:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101595:	89 04 24             	mov    %eax,(%esp)
80101598:	e8 7a ec ff ff       	call   80100217 <brelse>
}
8010159d:	c9                   	leave  
8010159e:	c3                   	ret    

8010159f <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
8010159f:	55                   	push   %ebp
801015a0:	89 e5                	mov    %esp,%ebp
801015a2:	83 ec 18             	sub    $0x18,%esp
  initlock(&icache.lock, "icache");
801015a5:	c7 44 24 04 ea 87 10 	movl   $0x801087ea,0x4(%esp)
801015ac:	80 
801015ad:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
801015b4:	e8 a5 3a 00 00       	call   8010505e <initlock>
}
801015b9:	c9                   	leave  
801015ba:	c3                   	ret    

801015bb <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801015bb:	55                   	push   %ebp
801015bc:	89 e5                	mov    %esp,%ebp
801015be:	83 ec 38             	sub    $0x38,%esp
801015c1:	8b 45 0c             	mov    0xc(%ebp),%eax
801015c4:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
801015c8:	8b 45 08             	mov    0x8(%ebp),%eax
801015cb:	8d 55 dc             	lea    -0x24(%ebp),%edx
801015ce:	89 54 24 04          	mov    %edx,0x4(%esp)
801015d2:	89 04 24             	mov    %eax,(%esp)
801015d5:	e8 12 fd ff ff       	call   801012ec <readsb>

  for(inum = 1; inum < sb.ninodes; inum++){
801015da:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
801015e1:	e9 98 00 00 00       	jmp    8010167e <ialloc+0xc3>
    bp = bread(dev, IBLOCK(inum));
801015e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015e9:	c1 e8 03             	shr    $0x3,%eax
801015ec:	83 c0 02             	add    $0x2,%eax
801015ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801015f3:	8b 45 08             	mov    0x8(%ebp),%eax
801015f6:	89 04 24             	mov    %eax,(%esp)
801015f9:	e8 a8 eb ff ff       	call   801001a6 <bread>
801015fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101601:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101604:	8d 50 18             	lea    0x18(%eax),%edx
80101607:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010160a:	83 e0 07             	and    $0x7,%eax
8010160d:	c1 e0 06             	shl    $0x6,%eax
80101610:	01 d0                	add    %edx,%eax
80101612:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
80101615:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101618:	0f b7 00             	movzwl (%eax),%eax
8010161b:	66 85 c0             	test   %ax,%ax
8010161e:	75 4f                	jne    8010166f <ialloc+0xb4>
      memset(dip, 0, sizeof(*dip));
80101620:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
80101627:	00 
80101628:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010162f:	00 
80101630:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101633:	89 04 24             	mov    %eax,(%esp)
80101636:	e8 9b 3c 00 00       	call   801052d6 <memset>
      dip->type = type;
8010163b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010163e:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
80101642:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
80101645:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101648:	89 04 24             	mov    %eax,(%esp)
8010164b:	e8 37 1c 00 00       	call   80103287 <log_write>
      brelse(bp);
80101650:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101653:	89 04 24             	mov    %eax,(%esp)
80101656:	e8 bc eb ff ff       	call   80100217 <brelse>
      return iget(dev, inum);
8010165b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010165e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101662:	8b 45 08             	mov    0x8(%ebp),%eax
80101665:	89 04 24             	mov    %eax,(%esp)
80101668:	e8 e5 00 00 00       	call   80101752 <iget>
8010166d:	eb 29                	jmp    80101698 <ialloc+0xdd>
    }
    brelse(bp);
8010166f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101672:	89 04 24             	mov    %eax,(%esp)
80101675:	e8 9d eb ff ff       	call   80100217 <brelse>
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
8010167a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010167e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101681:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101684:	39 c2                	cmp    %eax,%edx
80101686:	0f 82 5a ff ff ff    	jb     801015e6 <ialloc+0x2b>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
8010168c:	c7 04 24 f1 87 10 80 	movl   $0x801087f1,(%esp)
80101693:	e8 a2 ee ff ff       	call   8010053a <panic>
}
80101698:	c9                   	leave  
80101699:	c3                   	ret    

8010169a <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
8010169a:	55                   	push   %ebp
8010169b:	89 e5                	mov    %esp,%ebp
8010169d:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
801016a0:	8b 45 08             	mov    0x8(%ebp),%eax
801016a3:	8b 40 04             	mov    0x4(%eax),%eax
801016a6:	c1 e8 03             	shr    $0x3,%eax
801016a9:	8d 50 02             	lea    0x2(%eax),%edx
801016ac:	8b 45 08             	mov    0x8(%ebp),%eax
801016af:	8b 00                	mov    (%eax),%eax
801016b1:	89 54 24 04          	mov    %edx,0x4(%esp)
801016b5:	89 04 24             	mov    %eax,(%esp)
801016b8:	e8 e9 ea ff ff       	call   801001a6 <bread>
801016bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016c3:	8d 50 18             	lea    0x18(%eax),%edx
801016c6:	8b 45 08             	mov    0x8(%ebp),%eax
801016c9:	8b 40 04             	mov    0x4(%eax),%eax
801016cc:	83 e0 07             	and    $0x7,%eax
801016cf:	c1 e0 06             	shl    $0x6,%eax
801016d2:	01 d0                	add    %edx,%eax
801016d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
801016d7:	8b 45 08             	mov    0x8(%ebp),%eax
801016da:	0f b7 50 10          	movzwl 0x10(%eax),%edx
801016de:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016e1:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801016e4:	8b 45 08             	mov    0x8(%ebp),%eax
801016e7:	0f b7 50 12          	movzwl 0x12(%eax),%edx
801016eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016ee:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
801016f2:	8b 45 08             	mov    0x8(%ebp),%eax
801016f5:	0f b7 50 14          	movzwl 0x14(%eax),%edx
801016f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016fc:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101700:	8b 45 08             	mov    0x8(%ebp),%eax
80101703:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101707:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010170a:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
8010170e:	8b 45 08             	mov    0x8(%ebp),%eax
80101711:	8b 50 18             	mov    0x18(%eax),%edx
80101714:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101717:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010171a:	8b 45 08             	mov    0x8(%ebp),%eax
8010171d:	8d 50 1c             	lea    0x1c(%eax),%edx
80101720:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101723:	83 c0 0c             	add    $0xc,%eax
80101726:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010172d:	00 
8010172e:	89 54 24 04          	mov    %edx,0x4(%esp)
80101732:	89 04 24             	mov    %eax,(%esp)
80101735:	e8 6b 3c 00 00       	call   801053a5 <memmove>
  log_write(bp);
8010173a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010173d:	89 04 24             	mov    %eax,(%esp)
80101740:	e8 42 1b 00 00       	call   80103287 <log_write>
  brelse(bp);
80101745:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101748:	89 04 24             	mov    %eax,(%esp)
8010174b:	e8 c7 ea ff ff       	call   80100217 <brelse>
}
80101750:	c9                   	leave  
80101751:	c3                   	ret    

80101752 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101752:	55                   	push   %ebp
80101753:	89 e5                	mov    %esp,%ebp
80101755:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101758:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
8010175f:	e8 1b 39 00 00       	call   8010507f <acquire>

  // Is the inode already cached?
  empty = 0;
80101764:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010176b:	c7 45 f4 b4 e8 10 80 	movl   $0x8010e8b4,-0xc(%ebp)
80101772:	eb 59                	jmp    801017cd <iget+0x7b>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101774:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101777:	8b 40 08             	mov    0x8(%eax),%eax
8010177a:	85 c0                	test   %eax,%eax
8010177c:	7e 35                	jle    801017b3 <iget+0x61>
8010177e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101781:	8b 00                	mov    (%eax),%eax
80101783:	3b 45 08             	cmp    0x8(%ebp),%eax
80101786:	75 2b                	jne    801017b3 <iget+0x61>
80101788:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010178b:	8b 40 04             	mov    0x4(%eax),%eax
8010178e:	3b 45 0c             	cmp    0xc(%ebp),%eax
80101791:	75 20                	jne    801017b3 <iget+0x61>
      ip->ref++;
80101793:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101796:	8b 40 08             	mov    0x8(%eax),%eax
80101799:	8d 50 01             	lea    0x1(%eax),%edx
8010179c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010179f:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
801017a2:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
801017a9:	e8 33 39 00 00       	call   801050e1 <release>
      return ip;
801017ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017b1:	eb 6f                	jmp    80101822 <iget+0xd0>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801017b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801017b7:	75 10                	jne    801017c9 <iget+0x77>
801017b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017bc:	8b 40 08             	mov    0x8(%eax),%eax
801017bf:	85 c0                	test   %eax,%eax
801017c1:	75 06                	jne    801017c9 <iget+0x77>
      empty = ip;
801017c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017c6:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801017c9:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
801017cd:	81 7d f4 54 f8 10 80 	cmpl   $0x8010f854,-0xc(%ebp)
801017d4:	72 9e                	jb     80101774 <iget+0x22>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801017d6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801017da:	75 0c                	jne    801017e8 <iget+0x96>
    panic("iget: no inodes");
801017dc:	c7 04 24 03 88 10 80 	movl   $0x80108803,(%esp)
801017e3:	e8 52 ed ff ff       	call   8010053a <panic>

  ip = empty;
801017e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
801017ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017f1:	8b 55 08             	mov    0x8(%ebp),%edx
801017f4:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
801017f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017f9:	8b 55 0c             	mov    0xc(%ebp),%edx
801017fc:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
801017ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101802:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
80101809:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010180c:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
80101813:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
8010181a:	e8 c2 38 00 00       	call   801050e1 <release>

  return ip;
8010181f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80101822:	c9                   	leave  
80101823:	c3                   	ret    

80101824 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101824:	55                   	push   %ebp
80101825:	89 e5                	mov    %esp,%ebp
80101827:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
8010182a:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101831:	e8 49 38 00 00       	call   8010507f <acquire>
  ip->ref++;
80101836:	8b 45 08             	mov    0x8(%ebp),%eax
80101839:	8b 40 08             	mov    0x8(%eax),%eax
8010183c:	8d 50 01             	lea    0x1(%eax),%edx
8010183f:	8b 45 08             	mov    0x8(%ebp),%eax
80101842:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101845:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
8010184c:	e8 90 38 00 00       	call   801050e1 <release>
  return ip;
80101851:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101854:	c9                   	leave  
80101855:	c3                   	ret    

80101856 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101856:	55                   	push   %ebp
80101857:	89 e5                	mov    %esp,%ebp
80101859:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
8010185c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101860:	74 0a                	je     8010186c <ilock+0x16>
80101862:	8b 45 08             	mov    0x8(%ebp),%eax
80101865:	8b 40 08             	mov    0x8(%eax),%eax
80101868:	85 c0                	test   %eax,%eax
8010186a:	7f 0c                	jg     80101878 <ilock+0x22>
    panic("ilock");
8010186c:	c7 04 24 13 88 10 80 	movl   $0x80108813,(%esp)
80101873:	e8 c2 ec ff ff       	call   8010053a <panic>

  acquire(&icache.lock);
80101878:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
8010187f:	e8 fb 37 00 00       	call   8010507f <acquire>
  while(ip->flags & I_BUSY)
80101884:	eb 13                	jmp    80101899 <ilock+0x43>
    sleep(ip, &icache.lock);
80101886:	c7 44 24 04 80 e8 10 	movl   $0x8010e880,0x4(%esp)
8010188d:	80 
8010188e:	8b 45 08             	mov    0x8(%ebp),%eax
80101891:	89 04 24             	mov    %eax,(%esp)
80101894:	e8 75 34 00 00       	call   80104d0e <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
80101899:	8b 45 08             	mov    0x8(%ebp),%eax
8010189c:	8b 40 0c             	mov    0xc(%eax),%eax
8010189f:	83 e0 01             	and    $0x1,%eax
801018a2:	85 c0                	test   %eax,%eax
801018a4:	75 e0                	jne    80101886 <ilock+0x30>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
801018a6:	8b 45 08             	mov    0x8(%ebp),%eax
801018a9:	8b 40 0c             	mov    0xc(%eax),%eax
801018ac:	83 c8 01             	or     $0x1,%eax
801018af:	89 c2                	mov    %eax,%edx
801018b1:	8b 45 08             	mov    0x8(%ebp),%eax
801018b4:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
801018b7:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
801018be:	e8 1e 38 00 00       	call   801050e1 <release>

  if(!(ip->flags & I_VALID)){
801018c3:	8b 45 08             	mov    0x8(%ebp),%eax
801018c6:	8b 40 0c             	mov    0xc(%eax),%eax
801018c9:	83 e0 02             	and    $0x2,%eax
801018cc:	85 c0                	test   %eax,%eax
801018ce:	0f 85 ce 00 00 00    	jne    801019a2 <ilock+0x14c>
    bp = bread(ip->dev, IBLOCK(ip->inum));
801018d4:	8b 45 08             	mov    0x8(%ebp),%eax
801018d7:	8b 40 04             	mov    0x4(%eax),%eax
801018da:	c1 e8 03             	shr    $0x3,%eax
801018dd:	8d 50 02             	lea    0x2(%eax),%edx
801018e0:	8b 45 08             	mov    0x8(%ebp),%eax
801018e3:	8b 00                	mov    (%eax),%eax
801018e5:	89 54 24 04          	mov    %edx,0x4(%esp)
801018e9:	89 04 24             	mov    %eax,(%esp)
801018ec:	e8 b5 e8 ff ff       	call   801001a6 <bread>
801018f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018f7:	8d 50 18             	lea    0x18(%eax),%edx
801018fa:	8b 45 08             	mov    0x8(%ebp),%eax
801018fd:	8b 40 04             	mov    0x4(%eax),%eax
80101900:	83 e0 07             	and    $0x7,%eax
80101903:	c1 e0 06             	shl    $0x6,%eax
80101906:	01 d0                	add    %edx,%eax
80101908:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
8010190b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010190e:	0f b7 10             	movzwl (%eax),%edx
80101911:	8b 45 08             	mov    0x8(%ebp),%eax
80101914:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
80101918:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010191b:	0f b7 50 02          	movzwl 0x2(%eax),%edx
8010191f:	8b 45 08             	mov    0x8(%ebp),%eax
80101922:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
80101926:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101929:	0f b7 50 04          	movzwl 0x4(%eax),%edx
8010192d:	8b 45 08             	mov    0x8(%ebp),%eax
80101930:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
80101934:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101937:	0f b7 50 06          	movzwl 0x6(%eax),%edx
8010193b:	8b 45 08             	mov    0x8(%ebp),%eax
8010193e:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
80101942:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101945:	8b 50 08             	mov    0x8(%eax),%edx
80101948:	8b 45 08             	mov    0x8(%ebp),%eax
8010194b:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010194e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101951:	8d 50 0c             	lea    0xc(%eax),%edx
80101954:	8b 45 08             	mov    0x8(%ebp),%eax
80101957:	83 c0 1c             	add    $0x1c,%eax
8010195a:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101961:	00 
80101962:	89 54 24 04          	mov    %edx,0x4(%esp)
80101966:	89 04 24             	mov    %eax,(%esp)
80101969:	e8 37 3a 00 00       	call   801053a5 <memmove>
    brelse(bp);
8010196e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101971:	89 04 24             	mov    %eax,(%esp)
80101974:	e8 9e e8 ff ff       	call   80100217 <brelse>
    ip->flags |= I_VALID;
80101979:	8b 45 08             	mov    0x8(%ebp),%eax
8010197c:	8b 40 0c             	mov    0xc(%eax),%eax
8010197f:	83 c8 02             	or     $0x2,%eax
80101982:	89 c2                	mov    %eax,%edx
80101984:	8b 45 08             	mov    0x8(%ebp),%eax
80101987:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
8010198a:	8b 45 08             	mov    0x8(%ebp),%eax
8010198d:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101991:	66 85 c0             	test   %ax,%ax
80101994:	75 0c                	jne    801019a2 <ilock+0x14c>
      panic("ilock: no type");
80101996:	c7 04 24 19 88 10 80 	movl   $0x80108819,(%esp)
8010199d:	e8 98 eb ff ff       	call   8010053a <panic>
  }
}
801019a2:	c9                   	leave  
801019a3:	c3                   	ret    

801019a4 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
801019a4:	55                   	push   %ebp
801019a5:	89 e5                	mov    %esp,%ebp
801019a7:	83 ec 18             	sub    $0x18,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
801019aa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801019ae:	74 17                	je     801019c7 <iunlock+0x23>
801019b0:	8b 45 08             	mov    0x8(%ebp),%eax
801019b3:	8b 40 0c             	mov    0xc(%eax),%eax
801019b6:	83 e0 01             	and    $0x1,%eax
801019b9:	85 c0                	test   %eax,%eax
801019bb:	74 0a                	je     801019c7 <iunlock+0x23>
801019bd:	8b 45 08             	mov    0x8(%ebp),%eax
801019c0:	8b 40 08             	mov    0x8(%eax),%eax
801019c3:	85 c0                	test   %eax,%eax
801019c5:	7f 0c                	jg     801019d3 <iunlock+0x2f>
    panic("iunlock");
801019c7:	c7 04 24 28 88 10 80 	movl   $0x80108828,(%esp)
801019ce:	e8 67 eb ff ff       	call   8010053a <panic>

  acquire(&icache.lock);
801019d3:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
801019da:	e8 a0 36 00 00       	call   8010507f <acquire>
  ip->flags &= ~I_BUSY;
801019df:	8b 45 08             	mov    0x8(%ebp),%eax
801019e2:	8b 40 0c             	mov    0xc(%eax),%eax
801019e5:	83 e0 fe             	and    $0xfffffffe,%eax
801019e8:	89 c2                	mov    %eax,%edx
801019ea:	8b 45 08             	mov    0x8(%ebp),%eax
801019ed:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
801019f0:	8b 45 08             	mov    0x8(%ebp),%eax
801019f3:	89 04 24             	mov    %eax,(%esp)
801019f6:	e8 57 34 00 00       	call   80104e52 <wakeup>
  release(&icache.lock);
801019fb:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101a02:	e8 da 36 00 00       	call   801050e1 <release>
}
80101a07:	c9                   	leave  
80101a08:	c3                   	ret    

80101a09 <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
80101a09:	55                   	push   %ebp
80101a0a:	89 e5                	mov    %esp,%ebp
80101a0c:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80101a0f:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101a16:	e8 64 36 00 00       	call   8010507f <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101a1b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a1e:	8b 40 08             	mov    0x8(%eax),%eax
80101a21:	83 f8 01             	cmp    $0x1,%eax
80101a24:	0f 85 93 00 00 00    	jne    80101abd <iput+0xb4>
80101a2a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a2d:	8b 40 0c             	mov    0xc(%eax),%eax
80101a30:	83 e0 02             	and    $0x2,%eax
80101a33:	85 c0                	test   %eax,%eax
80101a35:	0f 84 82 00 00 00    	je     80101abd <iput+0xb4>
80101a3b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a3e:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101a42:	66 85 c0             	test   %ax,%ax
80101a45:	75 76                	jne    80101abd <iput+0xb4>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
80101a47:	8b 45 08             	mov    0x8(%ebp),%eax
80101a4a:	8b 40 0c             	mov    0xc(%eax),%eax
80101a4d:	83 e0 01             	and    $0x1,%eax
80101a50:	85 c0                	test   %eax,%eax
80101a52:	74 0c                	je     80101a60 <iput+0x57>
      panic("iput busy");
80101a54:	c7 04 24 30 88 10 80 	movl   $0x80108830,(%esp)
80101a5b:	e8 da ea ff ff       	call   8010053a <panic>
    ip->flags |= I_BUSY;
80101a60:	8b 45 08             	mov    0x8(%ebp),%eax
80101a63:	8b 40 0c             	mov    0xc(%eax),%eax
80101a66:	83 c8 01             	or     $0x1,%eax
80101a69:	89 c2                	mov    %eax,%edx
80101a6b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6e:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101a71:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101a78:	e8 64 36 00 00       	call   801050e1 <release>
    itrunc(ip);
80101a7d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a80:	89 04 24             	mov    %eax,(%esp)
80101a83:	e8 7d 01 00 00       	call   80101c05 <itrunc>
    ip->type = 0;
80101a88:	8b 45 08             	mov    0x8(%ebp),%eax
80101a8b:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101a91:	8b 45 08             	mov    0x8(%ebp),%eax
80101a94:	89 04 24             	mov    %eax,(%esp)
80101a97:	e8 fe fb ff ff       	call   8010169a <iupdate>
    acquire(&icache.lock);
80101a9c:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101aa3:	e8 d7 35 00 00       	call   8010507f <acquire>
    ip->flags = 0;
80101aa8:	8b 45 08             	mov    0x8(%ebp),%eax
80101aab:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101ab2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ab5:	89 04 24             	mov    %eax,(%esp)
80101ab8:	e8 95 33 00 00       	call   80104e52 <wakeup>
  }
  ip->ref--;
80101abd:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac0:	8b 40 08             	mov    0x8(%eax),%eax
80101ac3:	8d 50 ff             	lea    -0x1(%eax),%edx
80101ac6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac9:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101acc:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101ad3:	e8 09 36 00 00       	call   801050e1 <release>
}
80101ad8:	c9                   	leave  
80101ad9:	c3                   	ret    

80101ada <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101ada:	55                   	push   %ebp
80101adb:	89 e5                	mov    %esp,%ebp
80101add:	83 ec 18             	sub    $0x18,%esp
  iunlock(ip);
80101ae0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae3:	89 04 24             	mov    %eax,(%esp)
80101ae6:	e8 b9 fe ff ff       	call   801019a4 <iunlock>
  iput(ip);
80101aeb:	8b 45 08             	mov    0x8(%ebp),%eax
80101aee:	89 04 24             	mov    %eax,(%esp)
80101af1:	e8 13 ff ff ff       	call   80101a09 <iput>
}
80101af6:	c9                   	leave  
80101af7:	c3                   	ret    

80101af8 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101af8:	55                   	push   %ebp
80101af9:	89 e5                	mov    %esp,%ebp
80101afb:	53                   	push   %ebx
80101afc:	83 ec 24             	sub    $0x24,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101aff:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101b03:	77 3e                	ja     80101b43 <bmap+0x4b>
    if((addr = ip->addrs[bn]) == 0)
80101b05:	8b 45 08             	mov    0x8(%ebp),%eax
80101b08:	8b 55 0c             	mov    0xc(%ebp),%edx
80101b0b:	83 c2 04             	add    $0x4,%edx
80101b0e:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101b12:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101b15:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101b19:	75 20                	jne    80101b3b <bmap+0x43>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101b1b:	8b 45 08             	mov    0x8(%ebp),%eax
80101b1e:	8b 00                	mov    (%eax),%eax
80101b20:	89 04 24             	mov    %eax,(%esp)
80101b23:	e8 5b f8 ff ff       	call   80101383 <balloc>
80101b28:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101b2b:	8b 45 08             	mov    0x8(%ebp),%eax
80101b2e:	8b 55 0c             	mov    0xc(%ebp),%edx
80101b31:	8d 4a 04             	lea    0x4(%edx),%ecx
80101b34:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101b37:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101b3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b3e:	e9 bc 00 00 00       	jmp    80101bff <bmap+0x107>
  }
  bn -= NDIRECT;
80101b43:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101b47:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101b4b:	0f 87 a2 00 00 00    	ja     80101bf3 <bmap+0xfb>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101b51:	8b 45 08             	mov    0x8(%ebp),%eax
80101b54:	8b 40 4c             	mov    0x4c(%eax),%eax
80101b57:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101b5a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101b5e:	75 19                	jne    80101b79 <bmap+0x81>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101b60:	8b 45 08             	mov    0x8(%ebp),%eax
80101b63:	8b 00                	mov    (%eax),%eax
80101b65:	89 04 24             	mov    %eax,(%esp)
80101b68:	e8 16 f8 ff ff       	call   80101383 <balloc>
80101b6d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101b70:	8b 45 08             	mov    0x8(%ebp),%eax
80101b73:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101b76:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101b79:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7c:	8b 00                	mov    (%eax),%eax
80101b7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101b81:	89 54 24 04          	mov    %edx,0x4(%esp)
80101b85:	89 04 24             	mov    %eax,(%esp)
80101b88:	e8 19 e6 ff ff       	call   801001a6 <bread>
80101b8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101b90:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b93:	83 c0 18             	add    $0x18,%eax
80101b96:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101b99:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b9c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101ba3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ba6:	01 d0                	add    %edx,%eax
80101ba8:	8b 00                	mov    (%eax),%eax
80101baa:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101bb1:	75 30                	jne    80101be3 <bmap+0xeb>
      a[bn] = addr = balloc(ip->dev);
80101bb3:	8b 45 0c             	mov    0xc(%ebp),%eax
80101bb6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101bbd:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101bc0:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101bc3:	8b 45 08             	mov    0x8(%ebp),%eax
80101bc6:	8b 00                	mov    (%eax),%eax
80101bc8:	89 04 24             	mov    %eax,(%esp)
80101bcb:	e8 b3 f7 ff ff       	call   80101383 <balloc>
80101bd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bd6:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101bdb:	89 04 24             	mov    %eax,(%esp)
80101bde:	e8 a4 16 00 00       	call   80103287 <log_write>
    }
    brelse(bp);
80101be3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101be6:	89 04 24             	mov    %eax,(%esp)
80101be9:	e8 29 e6 ff ff       	call   80100217 <brelse>
    return addr;
80101bee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bf1:	eb 0c                	jmp    80101bff <bmap+0x107>
  }

  panic("bmap: out of range");
80101bf3:	c7 04 24 3a 88 10 80 	movl   $0x8010883a,(%esp)
80101bfa:	e8 3b e9 ff ff       	call   8010053a <panic>
}
80101bff:	83 c4 24             	add    $0x24,%esp
80101c02:	5b                   	pop    %ebx
80101c03:	5d                   	pop    %ebp
80101c04:	c3                   	ret    

80101c05 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101c05:	55                   	push   %ebp
80101c06:	89 e5                	mov    %esp,%ebp
80101c08:	83 ec 28             	sub    $0x28,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101c0b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101c12:	eb 44                	jmp    80101c58 <itrunc+0x53>
    if(ip->addrs[i]){
80101c14:	8b 45 08             	mov    0x8(%ebp),%eax
80101c17:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c1a:	83 c2 04             	add    $0x4,%edx
80101c1d:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101c21:	85 c0                	test   %eax,%eax
80101c23:	74 2f                	je     80101c54 <itrunc+0x4f>
      bfree(ip->dev, ip->addrs[i]);
80101c25:	8b 45 08             	mov    0x8(%ebp),%eax
80101c28:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c2b:	83 c2 04             	add    $0x4,%edx
80101c2e:	8b 54 90 0c          	mov    0xc(%eax,%edx,4),%edx
80101c32:	8b 45 08             	mov    0x8(%ebp),%eax
80101c35:	8b 00                	mov    (%eax),%eax
80101c37:	89 54 24 04          	mov    %edx,0x4(%esp)
80101c3b:	89 04 24             	mov    %eax,(%esp)
80101c3e:	e8 8e f8 ff ff       	call   801014d1 <bfree>
      ip->addrs[i] = 0;
80101c43:	8b 45 08             	mov    0x8(%ebp),%eax
80101c46:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c49:	83 c2 04             	add    $0x4,%edx
80101c4c:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101c53:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101c54:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101c58:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101c5c:	7e b6                	jle    80101c14 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101c5e:	8b 45 08             	mov    0x8(%ebp),%eax
80101c61:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c64:	85 c0                	test   %eax,%eax
80101c66:	0f 84 9b 00 00 00    	je     80101d07 <itrunc+0x102>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101c6c:	8b 45 08             	mov    0x8(%ebp),%eax
80101c6f:	8b 50 4c             	mov    0x4c(%eax),%edx
80101c72:	8b 45 08             	mov    0x8(%ebp),%eax
80101c75:	8b 00                	mov    (%eax),%eax
80101c77:	89 54 24 04          	mov    %edx,0x4(%esp)
80101c7b:	89 04 24             	mov    %eax,(%esp)
80101c7e:	e8 23 e5 ff ff       	call   801001a6 <bread>
80101c83:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101c86:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c89:	83 c0 18             	add    $0x18,%eax
80101c8c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101c8f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101c96:	eb 3b                	jmp    80101cd3 <itrunc+0xce>
      if(a[j])
80101c98:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c9b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101ca2:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101ca5:	01 d0                	add    %edx,%eax
80101ca7:	8b 00                	mov    (%eax),%eax
80101ca9:	85 c0                	test   %eax,%eax
80101cab:	74 22                	je     80101ccf <itrunc+0xca>
        bfree(ip->dev, a[j]);
80101cad:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cb0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101cb7:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101cba:	01 d0                	add    %edx,%eax
80101cbc:	8b 10                	mov    (%eax),%edx
80101cbe:	8b 45 08             	mov    0x8(%ebp),%eax
80101cc1:	8b 00                	mov    (%eax),%eax
80101cc3:	89 54 24 04          	mov    %edx,0x4(%esp)
80101cc7:	89 04 24             	mov    %eax,(%esp)
80101cca:	e8 02 f8 ff ff       	call   801014d1 <bfree>
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101ccf:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101cd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cd6:	83 f8 7f             	cmp    $0x7f,%eax
80101cd9:	76 bd                	jbe    80101c98 <itrunc+0x93>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101cdb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101cde:	89 04 24             	mov    %eax,(%esp)
80101ce1:	e8 31 e5 ff ff       	call   80100217 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101ce6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ce9:	8b 50 4c             	mov    0x4c(%eax),%edx
80101cec:	8b 45 08             	mov    0x8(%ebp),%eax
80101cef:	8b 00                	mov    (%eax),%eax
80101cf1:	89 54 24 04          	mov    %edx,0x4(%esp)
80101cf5:	89 04 24             	mov    %eax,(%esp)
80101cf8:	e8 d4 f7 ff ff       	call   801014d1 <bfree>
    ip->addrs[NDIRECT] = 0;
80101cfd:	8b 45 08             	mov    0x8(%ebp),%eax
80101d00:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101d07:	8b 45 08             	mov    0x8(%ebp),%eax
80101d0a:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101d11:	8b 45 08             	mov    0x8(%ebp),%eax
80101d14:	89 04 24             	mov    %eax,(%esp)
80101d17:	e8 7e f9 ff ff       	call   8010169a <iupdate>
}
80101d1c:	c9                   	leave  
80101d1d:	c3                   	ret    

80101d1e <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101d1e:	55                   	push   %ebp
80101d1f:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101d21:	8b 45 08             	mov    0x8(%ebp),%eax
80101d24:	8b 00                	mov    (%eax),%eax
80101d26:	89 c2                	mov    %eax,%edx
80101d28:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d2b:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101d2e:	8b 45 08             	mov    0x8(%ebp),%eax
80101d31:	8b 50 04             	mov    0x4(%eax),%edx
80101d34:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d37:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101d3a:	8b 45 08             	mov    0x8(%ebp),%eax
80101d3d:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101d41:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d44:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101d47:	8b 45 08             	mov    0x8(%ebp),%eax
80101d4a:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101d4e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d51:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101d55:	8b 45 08             	mov    0x8(%ebp),%eax
80101d58:	8b 50 18             	mov    0x18(%eax),%edx
80101d5b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d5e:	89 50 10             	mov    %edx,0x10(%eax)
}
80101d61:	5d                   	pop    %ebp
80101d62:	c3                   	ret    

80101d63 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101d63:	55                   	push   %ebp
80101d64:	89 e5                	mov    %esp,%ebp
80101d66:	83 ec 28             	sub    $0x28,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101d69:	8b 45 08             	mov    0x8(%ebp),%eax
80101d6c:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101d70:	66 83 f8 03          	cmp    $0x3,%ax
80101d74:	75 60                	jne    80101dd6 <readi+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101d76:	8b 45 08             	mov    0x8(%ebp),%eax
80101d79:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101d7d:	66 85 c0             	test   %ax,%ax
80101d80:	78 20                	js     80101da2 <readi+0x3f>
80101d82:	8b 45 08             	mov    0x8(%ebp),%eax
80101d85:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101d89:	66 83 f8 09          	cmp    $0x9,%ax
80101d8d:	7f 13                	jg     80101da2 <readi+0x3f>
80101d8f:	8b 45 08             	mov    0x8(%ebp),%eax
80101d92:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101d96:	98                   	cwtl   
80101d97:	8b 04 c5 20 e8 10 80 	mov    -0x7fef17e0(,%eax,8),%eax
80101d9e:	85 c0                	test   %eax,%eax
80101da0:	75 0a                	jne    80101dac <readi+0x49>
      return -1;
80101da2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101da7:	e9 19 01 00 00       	jmp    80101ec5 <readi+0x162>
    return devsw[ip->major].read(ip, dst, n);
80101dac:	8b 45 08             	mov    0x8(%ebp),%eax
80101daf:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101db3:	98                   	cwtl   
80101db4:	8b 04 c5 20 e8 10 80 	mov    -0x7fef17e0(,%eax,8),%eax
80101dbb:	8b 55 14             	mov    0x14(%ebp),%edx
80101dbe:	89 54 24 08          	mov    %edx,0x8(%esp)
80101dc2:	8b 55 0c             	mov    0xc(%ebp),%edx
80101dc5:	89 54 24 04          	mov    %edx,0x4(%esp)
80101dc9:	8b 55 08             	mov    0x8(%ebp),%edx
80101dcc:	89 14 24             	mov    %edx,(%esp)
80101dcf:	ff d0                	call   *%eax
80101dd1:	e9 ef 00 00 00       	jmp    80101ec5 <readi+0x162>
  }

  if(off > ip->size || off + n < off)
80101dd6:	8b 45 08             	mov    0x8(%ebp),%eax
80101dd9:	8b 40 18             	mov    0x18(%eax),%eax
80101ddc:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ddf:	72 0d                	jb     80101dee <readi+0x8b>
80101de1:	8b 45 14             	mov    0x14(%ebp),%eax
80101de4:	8b 55 10             	mov    0x10(%ebp),%edx
80101de7:	01 d0                	add    %edx,%eax
80101de9:	3b 45 10             	cmp    0x10(%ebp),%eax
80101dec:	73 0a                	jae    80101df8 <readi+0x95>
    return -1;
80101dee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101df3:	e9 cd 00 00 00       	jmp    80101ec5 <readi+0x162>
  if(off + n > ip->size)
80101df8:	8b 45 14             	mov    0x14(%ebp),%eax
80101dfb:	8b 55 10             	mov    0x10(%ebp),%edx
80101dfe:	01 c2                	add    %eax,%edx
80101e00:	8b 45 08             	mov    0x8(%ebp),%eax
80101e03:	8b 40 18             	mov    0x18(%eax),%eax
80101e06:	39 c2                	cmp    %eax,%edx
80101e08:	76 0c                	jbe    80101e16 <readi+0xb3>
    n = ip->size - off;
80101e0a:	8b 45 08             	mov    0x8(%ebp),%eax
80101e0d:	8b 40 18             	mov    0x18(%eax),%eax
80101e10:	2b 45 10             	sub    0x10(%ebp),%eax
80101e13:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101e16:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101e1d:	e9 94 00 00 00       	jmp    80101eb6 <readi+0x153>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e22:	8b 45 10             	mov    0x10(%ebp),%eax
80101e25:	c1 e8 09             	shr    $0x9,%eax
80101e28:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e2c:	8b 45 08             	mov    0x8(%ebp),%eax
80101e2f:	89 04 24             	mov    %eax,(%esp)
80101e32:	e8 c1 fc ff ff       	call   80101af8 <bmap>
80101e37:	8b 55 08             	mov    0x8(%ebp),%edx
80101e3a:	8b 12                	mov    (%edx),%edx
80101e3c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e40:	89 14 24             	mov    %edx,(%esp)
80101e43:	e8 5e e3 ff ff       	call   801001a6 <bread>
80101e48:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101e4b:	8b 45 10             	mov    0x10(%ebp),%eax
80101e4e:	25 ff 01 00 00       	and    $0x1ff,%eax
80101e53:	89 c2                	mov    %eax,%edx
80101e55:	b8 00 02 00 00       	mov    $0x200,%eax
80101e5a:	29 d0                	sub    %edx,%eax
80101e5c:	89 c2                	mov    %eax,%edx
80101e5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101e61:	8b 4d 14             	mov    0x14(%ebp),%ecx
80101e64:	29 c1                	sub    %eax,%ecx
80101e66:	89 c8                	mov    %ecx,%eax
80101e68:	39 c2                	cmp    %eax,%edx
80101e6a:	0f 46 c2             	cmovbe %edx,%eax
80101e6d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101e70:	8b 45 10             	mov    0x10(%ebp),%eax
80101e73:	25 ff 01 00 00       	and    $0x1ff,%eax
80101e78:	8d 50 10             	lea    0x10(%eax),%edx
80101e7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e7e:	01 d0                	add    %edx,%eax
80101e80:	8d 50 08             	lea    0x8(%eax),%edx
80101e83:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101e86:	89 44 24 08          	mov    %eax,0x8(%esp)
80101e8a:	89 54 24 04          	mov    %edx,0x4(%esp)
80101e8e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e91:	89 04 24             	mov    %eax,(%esp)
80101e94:	e8 0c 35 00 00       	call   801053a5 <memmove>
    brelse(bp);
80101e99:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e9c:	89 04 24             	mov    %eax,(%esp)
80101e9f:	e8 73 e3 ff ff       	call   80100217 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ea4:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ea7:	01 45 f4             	add    %eax,-0xc(%ebp)
80101eaa:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ead:	01 45 10             	add    %eax,0x10(%ebp)
80101eb0:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101eb3:	01 45 0c             	add    %eax,0xc(%ebp)
80101eb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101eb9:	3b 45 14             	cmp    0x14(%ebp),%eax
80101ebc:	0f 82 60 ff ff ff    	jb     80101e22 <readi+0xbf>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101ec2:	8b 45 14             	mov    0x14(%ebp),%eax
}
80101ec5:	c9                   	leave  
80101ec6:	c3                   	ret    

80101ec7 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ec7:	55                   	push   %ebp
80101ec8:	89 e5                	mov    %esp,%ebp
80101eca:	83 ec 28             	sub    $0x28,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ecd:	8b 45 08             	mov    0x8(%ebp),%eax
80101ed0:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101ed4:	66 83 f8 03          	cmp    $0x3,%ax
80101ed8:	75 60                	jne    80101f3a <writei+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101eda:	8b 45 08             	mov    0x8(%ebp),%eax
80101edd:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101ee1:	66 85 c0             	test   %ax,%ax
80101ee4:	78 20                	js     80101f06 <writei+0x3f>
80101ee6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ee9:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101eed:	66 83 f8 09          	cmp    $0x9,%ax
80101ef1:	7f 13                	jg     80101f06 <writei+0x3f>
80101ef3:	8b 45 08             	mov    0x8(%ebp),%eax
80101ef6:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101efa:	98                   	cwtl   
80101efb:	8b 04 c5 24 e8 10 80 	mov    -0x7fef17dc(,%eax,8),%eax
80101f02:	85 c0                	test   %eax,%eax
80101f04:	75 0a                	jne    80101f10 <writei+0x49>
      return -1;
80101f06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f0b:	e9 44 01 00 00       	jmp    80102054 <writei+0x18d>
    return devsw[ip->major].write(ip, src, n);
80101f10:	8b 45 08             	mov    0x8(%ebp),%eax
80101f13:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f17:	98                   	cwtl   
80101f18:	8b 04 c5 24 e8 10 80 	mov    -0x7fef17dc(,%eax,8),%eax
80101f1f:	8b 55 14             	mov    0x14(%ebp),%edx
80101f22:	89 54 24 08          	mov    %edx,0x8(%esp)
80101f26:	8b 55 0c             	mov    0xc(%ebp),%edx
80101f29:	89 54 24 04          	mov    %edx,0x4(%esp)
80101f2d:	8b 55 08             	mov    0x8(%ebp),%edx
80101f30:	89 14 24             	mov    %edx,(%esp)
80101f33:	ff d0                	call   *%eax
80101f35:	e9 1a 01 00 00       	jmp    80102054 <writei+0x18d>
  }

  if(off > ip->size || off + n < off)
80101f3a:	8b 45 08             	mov    0x8(%ebp),%eax
80101f3d:	8b 40 18             	mov    0x18(%eax),%eax
80101f40:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f43:	72 0d                	jb     80101f52 <writei+0x8b>
80101f45:	8b 45 14             	mov    0x14(%ebp),%eax
80101f48:	8b 55 10             	mov    0x10(%ebp),%edx
80101f4b:	01 d0                	add    %edx,%eax
80101f4d:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f50:	73 0a                	jae    80101f5c <writei+0x95>
    return -1;
80101f52:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f57:	e9 f8 00 00 00       	jmp    80102054 <writei+0x18d>
  if(off + n > MAXFILE*BSIZE)
80101f5c:	8b 45 14             	mov    0x14(%ebp),%eax
80101f5f:	8b 55 10             	mov    0x10(%ebp),%edx
80101f62:	01 d0                	add    %edx,%eax
80101f64:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101f69:	76 0a                	jbe    80101f75 <writei+0xae>
    return -1;
80101f6b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f70:	e9 df 00 00 00       	jmp    80102054 <writei+0x18d>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101f75:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101f7c:	e9 9f 00 00 00       	jmp    80102020 <writei+0x159>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f81:	8b 45 10             	mov    0x10(%ebp),%eax
80101f84:	c1 e8 09             	shr    $0x9,%eax
80101f87:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f8b:	8b 45 08             	mov    0x8(%ebp),%eax
80101f8e:	89 04 24             	mov    %eax,(%esp)
80101f91:	e8 62 fb ff ff       	call   80101af8 <bmap>
80101f96:	8b 55 08             	mov    0x8(%ebp),%edx
80101f99:	8b 12                	mov    (%edx),%edx
80101f9b:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f9f:	89 14 24             	mov    %edx,(%esp)
80101fa2:	e8 ff e1 ff ff       	call   801001a6 <bread>
80101fa7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101faa:	8b 45 10             	mov    0x10(%ebp),%eax
80101fad:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fb2:	89 c2                	mov    %eax,%edx
80101fb4:	b8 00 02 00 00       	mov    $0x200,%eax
80101fb9:	29 d0                	sub    %edx,%eax
80101fbb:	89 c2                	mov    %eax,%edx
80101fbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101fc0:	8b 4d 14             	mov    0x14(%ebp),%ecx
80101fc3:	29 c1                	sub    %eax,%ecx
80101fc5:	89 c8                	mov    %ecx,%eax
80101fc7:	39 c2                	cmp    %eax,%edx
80101fc9:	0f 46 c2             	cmovbe %edx,%eax
80101fcc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
80101fcf:	8b 45 10             	mov    0x10(%ebp),%eax
80101fd2:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fd7:	8d 50 10             	lea    0x10(%eax),%edx
80101fda:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101fdd:	01 d0                	add    %edx,%eax
80101fdf:	8d 50 08             	lea    0x8(%eax),%edx
80101fe2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fe5:	89 44 24 08          	mov    %eax,0x8(%esp)
80101fe9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101fec:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ff0:	89 14 24             	mov    %edx,(%esp)
80101ff3:	e8 ad 33 00 00       	call   801053a5 <memmove>
    log_write(bp);
80101ff8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ffb:	89 04 24             	mov    %eax,(%esp)
80101ffe:	e8 84 12 00 00       	call   80103287 <log_write>
    brelse(bp);
80102003:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102006:	89 04 24             	mov    %eax,(%esp)
80102009:	e8 09 e2 ff ff       	call   80100217 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010200e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102011:	01 45 f4             	add    %eax,-0xc(%ebp)
80102014:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102017:	01 45 10             	add    %eax,0x10(%ebp)
8010201a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010201d:	01 45 0c             	add    %eax,0xc(%ebp)
80102020:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102023:	3b 45 14             	cmp    0x14(%ebp),%eax
80102026:	0f 82 55 ff ff ff    	jb     80101f81 <writei+0xba>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
8010202c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102030:	74 1f                	je     80102051 <writei+0x18a>
80102032:	8b 45 08             	mov    0x8(%ebp),%eax
80102035:	8b 40 18             	mov    0x18(%eax),%eax
80102038:	3b 45 10             	cmp    0x10(%ebp),%eax
8010203b:	73 14                	jae    80102051 <writei+0x18a>
    ip->size = off;
8010203d:	8b 45 08             	mov    0x8(%ebp),%eax
80102040:	8b 55 10             	mov    0x10(%ebp),%edx
80102043:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
80102046:	8b 45 08             	mov    0x8(%ebp),%eax
80102049:	89 04 24             	mov    %eax,(%esp)
8010204c:	e8 49 f6 ff ff       	call   8010169a <iupdate>
  }
  return n;
80102051:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102054:	c9                   	leave  
80102055:	c3                   	ret    

80102056 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102056:	55                   	push   %ebp
80102057:	89 e5                	mov    %esp,%ebp
80102059:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
8010205c:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80102063:	00 
80102064:	8b 45 0c             	mov    0xc(%ebp),%eax
80102067:	89 44 24 04          	mov    %eax,0x4(%esp)
8010206b:	8b 45 08             	mov    0x8(%ebp),%eax
8010206e:	89 04 24             	mov    %eax,(%esp)
80102071:	e8 d2 33 00 00       	call   80105448 <strncmp>
}
80102076:	c9                   	leave  
80102077:	c3                   	ret    

80102078 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102078:	55                   	push   %ebp
80102079:	89 e5                	mov    %esp,%ebp
8010207b:	83 ec 38             	sub    $0x38,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010207e:	8b 45 08             	mov    0x8(%ebp),%eax
80102081:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102085:	66 83 f8 01          	cmp    $0x1,%ax
80102089:	74 0c                	je     80102097 <dirlookup+0x1f>
    panic("dirlookup not DIR");
8010208b:	c7 04 24 4d 88 10 80 	movl   $0x8010884d,(%esp)
80102092:	e8 a3 e4 ff ff       	call   8010053a <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
80102097:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010209e:	e9 88 00 00 00       	jmp    8010212b <dirlookup+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020a3:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801020aa:	00 
801020ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801020ae:	89 44 24 08          	mov    %eax,0x8(%esp)
801020b2:	8d 45 e0             	lea    -0x20(%ebp),%eax
801020b5:	89 44 24 04          	mov    %eax,0x4(%esp)
801020b9:	8b 45 08             	mov    0x8(%ebp),%eax
801020bc:	89 04 24             	mov    %eax,(%esp)
801020bf:	e8 9f fc ff ff       	call   80101d63 <readi>
801020c4:	83 f8 10             	cmp    $0x10,%eax
801020c7:	74 0c                	je     801020d5 <dirlookup+0x5d>
      panic("dirlink read");
801020c9:	c7 04 24 5f 88 10 80 	movl   $0x8010885f,(%esp)
801020d0:	e8 65 e4 ff ff       	call   8010053a <panic>
    if(de.inum == 0)
801020d5:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801020d9:	66 85 c0             	test   %ax,%ax
801020dc:	75 02                	jne    801020e0 <dirlookup+0x68>
      continue;
801020de:	eb 47                	jmp    80102127 <dirlookup+0xaf>
    if(namecmp(name, de.name) == 0){
801020e0:	8d 45 e0             	lea    -0x20(%ebp),%eax
801020e3:	83 c0 02             	add    $0x2,%eax
801020e6:	89 44 24 04          	mov    %eax,0x4(%esp)
801020ea:	8b 45 0c             	mov    0xc(%ebp),%eax
801020ed:	89 04 24             	mov    %eax,(%esp)
801020f0:	e8 61 ff ff ff       	call   80102056 <namecmp>
801020f5:	85 c0                	test   %eax,%eax
801020f7:	75 2e                	jne    80102127 <dirlookup+0xaf>
      // entry matches path element
      if(poff)
801020f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801020fd:	74 08                	je     80102107 <dirlookup+0x8f>
        *poff = off;
801020ff:	8b 45 10             	mov    0x10(%ebp),%eax
80102102:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102105:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102107:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010210b:	0f b7 c0             	movzwl %ax,%eax
8010210e:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
80102111:	8b 45 08             	mov    0x8(%ebp),%eax
80102114:	8b 00                	mov    (%eax),%eax
80102116:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102119:	89 54 24 04          	mov    %edx,0x4(%esp)
8010211d:	89 04 24             	mov    %eax,(%esp)
80102120:	e8 2d f6 ff ff       	call   80101752 <iget>
80102125:	eb 18                	jmp    8010213f <dirlookup+0xc7>
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102127:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
8010212b:	8b 45 08             	mov    0x8(%ebp),%eax
8010212e:	8b 40 18             	mov    0x18(%eax),%eax
80102131:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80102134:	0f 87 69 ff ff ff    	ja     801020a3 <dirlookup+0x2b>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
8010213a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010213f:	c9                   	leave  
80102140:	c3                   	ret    

80102141 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102141:	55                   	push   %ebp
80102142:	89 e5                	mov    %esp,%ebp
80102144:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102147:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010214e:	00 
8010214f:	8b 45 0c             	mov    0xc(%ebp),%eax
80102152:	89 44 24 04          	mov    %eax,0x4(%esp)
80102156:	8b 45 08             	mov    0x8(%ebp),%eax
80102159:	89 04 24             	mov    %eax,(%esp)
8010215c:	e8 17 ff ff ff       	call   80102078 <dirlookup>
80102161:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102164:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102168:	74 15                	je     8010217f <dirlink+0x3e>
    iput(ip);
8010216a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010216d:	89 04 24             	mov    %eax,(%esp)
80102170:	e8 94 f8 ff ff       	call   80101a09 <iput>
    return -1;
80102175:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010217a:	e9 b7 00 00 00       	jmp    80102236 <dirlink+0xf5>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010217f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102186:	eb 46                	jmp    801021ce <dirlink+0x8d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102188:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010218b:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80102192:	00 
80102193:	89 44 24 08          	mov    %eax,0x8(%esp)
80102197:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010219a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010219e:	8b 45 08             	mov    0x8(%ebp),%eax
801021a1:	89 04 24             	mov    %eax,(%esp)
801021a4:	e8 ba fb ff ff       	call   80101d63 <readi>
801021a9:	83 f8 10             	cmp    $0x10,%eax
801021ac:	74 0c                	je     801021ba <dirlink+0x79>
      panic("dirlink read");
801021ae:	c7 04 24 5f 88 10 80 	movl   $0x8010885f,(%esp)
801021b5:	e8 80 e3 ff ff       	call   8010053a <panic>
    if(de.inum == 0)
801021ba:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021be:	66 85 c0             	test   %ax,%ax
801021c1:	75 02                	jne    801021c5 <dirlink+0x84>
      break;
801021c3:	eb 16                	jmp    801021db <dirlink+0x9a>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801021c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801021c8:	83 c0 10             	add    $0x10,%eax
801021cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
801021ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021d1:	8b 45 08             	mov    0x8(%ebp),%eax
801021d4:	8b 40 18             	mov    0x18(%eax),%eax
801021d7:	39 c2                	cmp    %eax,%edx
801021d9:	72 ad                	jb     80102188 <dirlink+0x47>
      panic("dirlink read");
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
801021db:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801021e2:	00 
801021e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801021e6:	89 44 24 04          	mov    %eax,0x4(%esp)
801021ea:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021ed:	83 c0 02             	add    $0x2,%eax
801021f0:	89 04 24             	mov    %eax,(%esp)
801021f3:	e8 a6 32 00 00       	call   8010549e <strncpy>
  de.inum = inum;
801021f8:	8b 45 10             	mov    0x10(%ebp),%eax
801021fb:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102202:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80102209:	00 
8010220a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010220e:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102211:	89 44 24 04          	mov    %eax,0x4(%esp)
80102215:	8b 45 08             	mov    0x8(%ebp),%eax
80102218:	89 04 24             	mov    %eax,(%esp)
8010221b:	e8 a7 fc ff ff       	call   80101ec7 <writei>
80102220:	83 f8 10             	cmp    $0x10,%eax
80102223:	74 0c                	je     80102231 <dirlink+0xf0>
    panic("dirlink");
80102225:	c7 04 24 6c 88 10 80 	movl   $0x8010886c,(%esp)
8010222c:	e8 09 e3 ff ff       	call   8010053a <panic>
  
  return 0;
80102231:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102236:	c9                   	leave  
80102237:	c3                   	ret    

80102238 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102238:	55                   	push   %ebp
80102239:	89 e5                	mov    %esp,%ebp
8010223b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int len;

  while(*path == '/')
8010223e:	eb 04                	jmp    80102244 <skipelem+0xc>
    path++;
80102240:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80102244:	8b 45 08             	mov    0x8(%ebp),%eax
80102247:	0f b6 00             	movzbl (%eax),%eax
8010224a:	3c 2f                	cmp    $0x2f,%al
8010224c:	74 f2                	je     80102240 <skipelem+0x8>
    path++;
  if(*path == 0)
8010224e:	8b 45 08             	mov    0x8(%ebp),%eax
80102251:	0f b6 00             	movzbl (%eax),%eax
80102254:	84 c0                	test   %al,%al
80102256:	75 0a                	jne    80102262 <skipelem+0x2a>
    return 0;
80102258:	b8 00 00 00 00       	mov    $0x0,%eax
8010225d:	e9 86 00 00 00       	jmp    801022e8 <skipelem+0xb0>
  s = path;
80102262:	8b 45 08             	mov    0x8(%ebp),%eax
80102265:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102268:	eb 04                	jmp    8010226e <skipelem+0x36>
    path++;
8010226a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
8010226e:	8b 45 08             	mov    0x8(%ebp),%eax
80102271:	0f b6 00             	movzbl (%eax),%eax
80102274:	3c 2f                	cmp    $0x2f,%al
80102276:	74 0a                	je     80102282 <skipelem+0x4a>
80102278:	8b 45 08             	mov    0x8(%ebp),%eax
8010227b:	0f b6 00             	movzbl (%eax),%eax
8010227e:	84 c0                	test   %al,%al
80102280:	75 e8                	jne    8010226a <skipelem+0x32>
    path++;
  len = path - s;
80102282:	8b 55 08             	mov    0x8(%ebp),%edx
80102285:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102288:	29 c2                	sub    %eax,%edx
8010228a:	89 d0                	mov    %edx,%eax
8010228c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
8010228f:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80102293:	7e 1c                	jle    801022b1 <skipelem+0x79>
    memmove(name, s, DIRSIZ);
80102295:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
8010229c:	00 
8010229d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022a0:	89 44 24 04          	mov    %eax,0x4(%esp)
801022a4:	8b 45 0c             	mov    0xc(%ebp),%eax
801022a7:	89 04 24             	mov    %eax,(%esp)
801022aa:	e8 f6 30 00 00       	call   801053a5 <memmove>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801022af:	eb 2a                	jmp    801022db <skipelem+0xa3>
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
801022b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801022b4:	89 44 24 08          	mov    %eax,0x8(%esp)
801022b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022bb:	89 44 24 04          	mov    %eax,0x4(%esp)
801022bf:	8b 45 0c             	mov    0xc(%ebp),%eax
801022c2:	89 04 24             	mov    %eax,(%esp)
801022c5:	e8 db 30 00 00       	call   801053a5 <memmove>
    name[len] = 0;
801022ca:	8b 55 f0             	mov    -0x10(%ebp),%edx
801022cd:	8b 45 0c             	mov    0xc(%ebp),%eax
801022d0:	01 d0                	add    %edx,%eax
801022d2:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801022d5:	eb 04                	jmp    801022db <skipelem+0xa3>
    path++;
801022d7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801022db:	8b 45 08             	mov    0x8(%ebp),%eax
801022de:	0f b6 00             	movzbl (%eax),%eax
801022e1:	3c 2f                	cmp    $0x2f,%al
801022e3:	74 f2                	je     801022d7 <skipelem+0x9f>
    path++;
  return path;
801022e5:	8b 45 08             	mov    0x8(%ebp),%eax
}
801022e8:	c9                   	leave  
801022e9:	c3                   	ret    

801022ea <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801022ea:	55                   	push   %ebp
801022eb:	89 e5                	mov    %esp,%ebp
801022ed:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *next;

  if(*path == '/')
801022f0:	8b 45 08             	mov    0x8(%ebp),%eax
801022f3:	0f b6 00             	movzbl (%eax),%eax
801022f6:	3c 2f                	cmp    $0x2f,%al
801022f8:	75 1c                	jne    80102316 <namex+0x2c>
    ip = iget(ROOTDEV, ROOTINO);
801022fa:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102301:	00 
80102302:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80102309:	e8 44 f4 ff ff       	call   80101752 <iget>
8010230e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
80102311:	e9 af 00 00 00       	jmp    801023c5 <namex+0xdb>
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80102316:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010231c:	8b 40 68             	mov    0x68(%eax),%eax
8010231f:	89 04 24             	mov    %eax,(%esp)
80102322:	e8 fd f4 ff ff       	call   80101824 <idup>
80102327:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
8010232a:	e9 96 00 00 00       	jmp    801023c5 <namex+0xdb>
    ilock(ip);
8010232f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102332:	89 04 24             	mov    %eax,(%esp)
80102335:	e8 1c f5 ff ff       	call   80101856 <ilock>
    if(ip->type != T_DIR){
8010233a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010233d:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102341:	66 83 f8 01          	cmp    $0x1,%ax
80102345:	74 15                	je     8010235c <namex+0x72>
      iunlockput(ip);
80102347:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010234a:	89 04 24             	mov    %eax,(%esp)
8010234d:	e8 88 f7 ff ff       	call   80101ada <iunlockput>
      return 0;
80102352:	b8 00 00 00 00       	mov    $0x0,%eax
80102357:	e9 a3 00 00 00       	jmp    801023ff <namex+0x115>
    }
    if(nameiparent && *path == '\0'){
8010235c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102360:	74 1d                	je     8010237f <namex+0x95>
80102362:	8b 45 08             	mov    0x8(%ebp),%eax
80102365:	0f b6 00             	movzbl (%eax),%eax
80102368:	84 c0                	test   %al,%al
8010236a:	75 13                	jne    8010237f <namex+0x95>
      // Stop one level early.
      iunlock(ip);
8010236c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010236f:	89 04 24             	mov    %eax,(%esp)
80102372:	e8 2d f6 ff ff       	call   801019a4 <iunlock>
      return ip;
80102377:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010237a:	e9 80 00 00 00       	jmp    801023ff <namex+0x115>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
8010237f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80102386:	00 
80102387:	8b 45 10             	mov    0x10(%ebp),%eax
8010238a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010238e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102391:	89 04 24             	mov    %eax,(%esp)
80102394:	e8 df fc ff ff       	call   80102078 <dirlookup>
80102399:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010239c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801023a0:	75 12                	jne    801023b4 <namex+0xca>
      iunlockput(ip);
801023a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023a5:	89 04 24             	mov    %eax,(%esp)
801023a8:	e8 2d f7 ff ff       	call   80101ada <iunlockput>
      return 0;
801023ad:	b8 00 00 00 00       	mov    $0x0,%eax
801023b2:	eb 4b                	jmp    801023ff <namex+0x115>
    }
    iunlockput(ip);
801023b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023b7:	89 04 24             	mov    %eax,(%esp)
801023ba:	e8 1b f7 ff ff       	call   80101ada <iunlockput>
    ip = next;
801023bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801023c5:	8b 45 10             	mov    0x10(%ebp),%eax
801023c8:	89 44 24 04          	mov    %eax,0x4(%esp)
801023cc:	8b 45 08             	mov    0x8(%ebp),%eax
801023cf:	89 04 24             	mov    %eax,(%esp)
801023d2:	e8 61 fe ff ff       	call   80102238 <skipelem>
801023d7:	89 45 08             	mov    %eax,0x8(%ebp)
801023da:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801023de:	0f 85 4b ff ff ff    	jne    8010232f <namex+0x45>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801023e4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801023e8:	74 12                	je     801023fc <namex+0x112>
    iput(ip);
801023ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023ed:	89 04 24             	mov    %eax,(%esp)
801023f0:	e8 14 f6 ff ff       	call   80101a09 <iput>
    return 0;
801023f5:	b8 00 00 00 00       	mov    $0x0,%eax
801023fa:	eb 03                	jmp    801023ff <namex+0x115>
  }
  return ip;
801023fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801023ff:	c9                   	leave  
80102400:	c3                   	ret    

80102401 <namei>:

struct inode*
namei(char *path)
{
80102401:	55                   	push   %ebp
80102402:	89 e5                	mov    %esp,%ebp
80102404:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102407:	8d 45 ea             	lea    -0x16(%ebp),%eax
8010240a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010240e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102415:	00 
80102416:	8b 45 08             	mov    0x8(%ebp),%eax
80102419:	89 04 24             	mov    %eax,(%esp)
8010241c:	e8 c9 fe ff ff       	call   801022ea <namex>
}
80102421:	c9                   	leave  
80102422:	c3                   	ret    

80102423 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102423:	55                   	push   %ebp
80102424:	89 e5                	mov    %esp,%ebp
80102426:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 1, name);
80102429:	8b 45 0c             	mov    0xc(%ebp),%eax
8010242c:	89 44 24 08          	mov    %eax,0x8(%esp)
80102430:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102437:	00 
80102438:	8b 45 08             	mov    0x8(%ebp),%eax
8010243b:	89 04 24             	mov    %eax,(%esp)
8010243e:	e8 a7 fe ff ff       	call   801022ea <namex>
}
80102443:	c9                   	leave  
80102444:	c3                   	ret    
80102445:	66 90                	xchg   %ax,%ax
80102447:	90                   	nop

80102448 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102448:	55                   	push   %ebp
80102449:	89 e5                	mov    %esp,%ebp
8010244b:	83 ec 14             	sub    $0x14,%esp
8010244e:	8b 45 08             	mov    0x8(%ebp),%eax
80102451:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102455:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102459:	89 c2                	mov    %eax,%edx
8010245b:	ec                   	in     (%dx),%al
8010245c:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
8010245f:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102463:	c9                   	leave  
80102464:	c3                   	ret    

80102465 <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
80102465:	55                   	push   %ebp
80102466:	89 e5                	mov    %esp,%ebp
80102468:	57                   	push   %edi
80102469:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
8010246a:	8b 55 08             	mov    0x8(%ebp),%edx
8010246d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102470:	8b 45 10             	mov    0x10(%ebp),%eax
80102473:	89 cb                	mov    %ecx,%ebx
80102475:	89 df                	mov    %ebx,%edi
80102477:	89 c1                	mov    %eax,%ecx
80102479:	fc                   	cld    
8010247a:	f3 6d                	rep insl (%dx),%es:(%edi)
8010247c:	89 c8                	mov    %ecx,%eax
8010247e:	89 fb                	mov    %edi,%ebx
80102480:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102483:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
80102486:	5b                   	pop    %ebx
80102487:	5f                   	pop    %edi
80102488:	5d                   	pop    %ebp
80102489:	c3                   	ret    

8010248a <outb>:

static inline void
outb(ushort port, uchar data)
{
8010248a:	55                   	push   %ebp
8010248b:	89 e5                	mov    %esp,%ebp
8010248d:	83 ec 08             	sub    $0x8,%esp
80102490:	8b 55 08             	mov    0x8(%ebp),%edx
80102493:	8b 45 0c             	mov    0xc(%ebp),%eax
80102496:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010249a:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010249d:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801024a1:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801024a5:	ee                   	out    %al,(%dx)
}
801024a6:	c9                   	leave  
801024a7:	c3                   	ret    

801024a8 <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
801024a8:	55                   	push   %ebp
801024a9:	89 e5                	mov    %esp,%ebp
801024ab:	56                   	push   %esi
801024ac:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801024ad:	8b 55 08             	mov    0x8(%ebp),%edx
801024b0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801024b3:	8b 45 10             	mov    0x10(%ebp),%eax
801024b6:	89 cb                	mov    %ecx,%ebx
801024b8:	89 de                	mov    %ebx,%esi
801024ba:	89 c1                	mov    %eax,%ecx
801024bc:	fc                   	cld    
801024bd:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801024bf:	89 c8                	mov    %ecx,%eax
801024c1:	89 f3                	mov    %esi,%ebx
801024c3:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801024c6:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
801024c9:	5b                   	pop    %ebx
801024ca:	5e                   	pop    %esi
801024cb:	5d                   	pop    %ebp
801024cc:	c3                   	ret    

801024cd <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801024cd:	55                   	push   %ebp
801024ce:	89 e5                	mov    %esp,%ebp
801024d0:	83 ec 14             	sub    $0x14,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
801024d3:	90                   	nop
801024d4:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801024db:	e8 68 ff ff ff       	call   80102448 <inb>
801024e0:	0f b6 c0             	movzbl %al,%eax
801024e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
801024e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
801024e9:	25 c0 00 00 00       	and    $0xc0,%eax
801024ee:	83 f8 40             	cmp    $0x40,%eax
801024f1:	75 e1                	jne    801024d4 <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801024f3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801024f7:	74 11                	je     8010250a <idewait+0x3d>
801024f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
801024fc:	83 e0 21             	and    $0x21,%eax
801024ff:	85 c0                	test   %eax,%eax
80102501:	74 07                	je     8010250a <idewait+0x3d>
    return -1;
80102503:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102508:	eb 05                	jmp    8010250f <idewait+0x42>
  return 0;
8010250a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010250f:	c9                   	leave  
80102510:	c3                   	ret    

80102511 <ideinit>:

void
ideinit(void)
{
80102511:	55                   	push   %ebp
80102512:	89 e5                	mov    %esp,%ebp
80102514:	83 ec 28             	sub    $0x28,%esp
  int i;

  initlock(&idelock, "ide");
80102517:	c7 44 24 04 74 88 10 	movl   $0x80108874,0x4(%esp)
8010251e:	80 
8010251f:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
80102526:	e8 33 2b 00 00       	call   8010505e <initlock>
  picenable(IRQ_IDE);
8010252b:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102532:	e8 32 15 00 00       	call   80103a69 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102537:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
8010253c:	83 e8 01             	sub    $0x1,%eax
8010253f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102543:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
8010254a:	e8 0d 04 00 00       	call   8010295c <ioapicenable>
  idewait(0);
8010254f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80102556:	e8 72 ff ff ff       	call   801024cd <idewait>
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
8010255b:	c7 44 24 04 f0 00 00 	movl   $0xf0,0x4(%esp)
80102562:	00 
80102563:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
8010256a:	e8 1b ff ff ff       	call   8010248a <outb>
  for(i=0; i<1000; i++){
8010256f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102576:	eb 20                	jmp    80102598 <ideinit+0x87>
    if(inb(0x1f7) != 0){
80102578:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
8010257f:	e8 c4 fe ff ff       	call   80102448 <inb>
80102584:	84 c0                	test   %al,%al
80102586:	74 0c                	je     80102594 <ideinit+0x83>
      havedisk1 = 1;
80102588:	c7 05 58 b6 10 80 01 	movl   $0x1,0x8010b658
8010258f:	00 00 00 
      break;
80102592:	eb 0d                	jmp    801025a1 <ideinit+0x90>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102594:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102598:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
8010259f:	7e d7                	jle    80102578 <ideinit+0x67>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801025a1:	c7 44 24 04 e0 00 00 	movl   $0xe0,0x4(%esp)
801025a8:	00 
801025a9:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
801025b0:	e8 d5 fe ff ff       	call   8010248a <outb>
}
801025b5:	c9                   	leave  
801025b6:	c3                   	ret    

801025b7 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801025b7:	55                   	push   %ebp
801025b8:	89 e5                	mov    %esp,%ebp
801025ba:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
801025bd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801025c1:	75 0c                	jne    801025cf <idestart+0x18>
    panic("idestart");
801025c3:	c7 04 24 78 88 10 80 	movl   $0x80108878,(%esp)
801025ca:	e8 6b df ff ff       	call   8010053a <panic>

  idewait(0);
801025cf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801025d6:	e8 f2 fe ff ff       	call   801024cd <idewait>
  outb(0x3f6, 0);  // generate interrupt
801025db:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801025e2:	00 
801025e3:	c7 04 24 f6 03 00 00 	movl   $0x3f6,(%esp)
801025ea:	e8 9b fe ff ff       	call   8010248a <outb>
  outb(0x1f2, 1);  // number of sectors
801025ef:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801025f6:	00 
801025f7:	c7 04 24 f2 01 00 00 	movl   $0x1f2,(%esp)
801025fe:	e8 87 fe ff ff       	call   8010248a <outb>
  outb(0x1f3, b->sector & 0xff);
80102603:	8b 45 08             	mov    0x8(%ebp),%eax
80102606:	8b 40 08             	mov    0x8(%eax),%eax
80102609:	0f b6 c0             	movzbl %al,%eax
8010260c:	89 44 24 04          	mov    %eax,0x4(%esp)
80102610:	c7 04 24 f3 01 00 00 	movl   $0x1f3,(%esp)
80102617:	e8 6e fe ff ff       	call   8010248a <outb>
  outb(0x1f4, (b->sector >> 8) & 0xff);
8010261c:	8b 45 08             	mov    0x8(%ebp),%eax
8010261f:	8b 40 08             	mov    0x8(%eax),%eax
80102622:	c1 e8 08             	shr    $0x8,%eax
80102625:	0f b6 c0             	movzbl %al,%eax
80102628:	89 44 24 04          	mov    %eax,0x4(%esp)
8010262c:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
80102633:	e8 52 fe ff ff       	call   8010248a <outb>
  outb(0x1f5, (b->sector >> 16) & 0xff);
80102638:	8b 45 08             	mov    0x8(%ebp),%eax
8010263b:	8b 40 08             	mov    0x8(%eax),%eax
8010263e:	c1 e8 10             	shr    $0x10,%eax
80102641:	0f b6 c0             	movzbl %al,%eax
80102644:	89 44 24 04          	mov    %eax,0x4(%esp)
80102648:	c7 04 24 f5 01 00 00 	movl   $0x1f5,(%esp)
8010264f:	e8 36 fe ff ff       	call   8010248a <outb>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
80102654:	8b 45 08             	mov    0x8(%ebp),%eax
80102657:	8b 40 04             	mov    0x4(%eax),%eax
8010265a:	83 e0 01             	and    $0x1,%eax
8010265d:	c1 e0 04             	shl    $0x4,%eax
80102660:	89 c2                	mov    %eax,%edx
80102662:	8b 45 08             	mov    0x8(%ebp),%eax
80102665:	8b 40 08             	mov    0x8(%eax),%eax
80102668:	c1 e8 18             	shr    $0x18,%eax
8010266b:	83 e0 0f             	and    $0xf,%eax
8010266e:	09 d0                	or     %edx,%eax
80102670:	83 c8 e0             	or     $0xffffffe0,%eax
80102673:	0f b6 c0             	movzbl %al,%eax
80102676:	89 44 24 04          	mov    %eax,0x4(%esp)
8010267a:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102681:	e8 04 fe ff ff       	call   8010248a <outb>
  if(b->flags & B_DIRTY){
80102686:	8b 45 08             	mov    0x8(%ebp),%eax
80102689:	8b 00                	mov    (%eax),%eax
8010268b:	83 e0 04             	and    $0x4,%eax
8010268e:	85 c0                	test   %eax,%eax
80102690:	74 34                	je     801026c6 <idestart+0x10f>
    outb(0x1f7, IDE_CMD_WRITE);
80102692:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%esp)
80102699:	00 
8010269a:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801026a1:	e8 e4 fd ff ff       	call   8010248a <outb>
    outsl(0x1f0, b->data, 512/4);
801026a6:	8b 45 08             	mov    0x8(%ebp),%eax
801026a9:	83 c0 18             	add    $0x18,%eax
801026ac:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
801026b3:	00 
801026b4:	89 44 24 04          	mov    %eax,0x4(%esp)
801026b8:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
801026bf:	e8 e4 fd ff ff       	call   801024a8 <outsl>
801026c4:	eb 14                	jmp    801026da <idestart+0x123>
  } else {
    outb(0x1f7, IDE_CMD_READ);
801026c6:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
801026cd:	00 
801026ce:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801026d5:	e8 b0 fd ff ff       	call   8010248a <outb>
  }
}
801026da:	c9                   	leave  
801026db:	c3                   	ret    

801026dc <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801026dc:	55                   	push   %ebp
801026dd:	89 e5                	mov    %esp,%ebp
801026df:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801026e2:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
801026e9:	e8 91 29 00 00       	call   8010507f <acquire>
  if((b = idequeue) == 0){
801026ee:	a1 54 b6 10 80       	mov    0x8010b654,%eax
801026f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801026fa:	75 11                	jne    8010270d <ideintr+0x31>
    release(&idelock);
801026fc:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
80102703:	e8 d9 29 00 00       	call   801050e1 <release>
    // cprintf("spurious IDE interrupt\n");
    return;
80102708:	e9 90 00 00 00       	jmp    8010279d <ideintr+0xc1>
  }
  idequeue = b->qnext;
8010270d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102710:	8b 40 14             	mov    0x14(%eax),%eax
80102713:	a3 54 b6 10 80       	mov    %eax,0x8010b654

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102718:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010271b:	8b 00                	mov    (%eax),%eax
8010271d:	83 e0 04             	and    $0x4,%eax
80102720:	85 c0                	test   %eax,%eax
80102722:	75 2e                	jne    80102752 <ideintr+0x76>
80102724:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010272b:	e8 9d fd ff ff       	call   801024cd <idewait>
80102730:	85 c0                	test   %eax,%eax
80102732:	78 1e                	js     80102752 <ideintr+0x76>
    insl(0x1f0, b->data, 512/4);
80102734:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102737:	83 c0 18             	add    $0x18,%eax
8010273a:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80102741:	00 
80102742:	89 44 24 04          	mov    %eax,0x4(%esp)
80102746:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
8010274d:	e8 13 fd ff ff       	call   80102465 <insl>
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102752:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102755:	8b 00                	mov    (%eax),%eax
80102757:	83 c8 02             	or     $0x2,%eax
8010275a:	89 c2                	mov    %eax,%edx
8010275c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010275f:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
80102761:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102764:	8b 00                	mov    (%eax),%eax
80102766:	83 e0 fb             	and    $0xfffffffb,%eax
80102769:	89 c2                	mov    %eax,%edx
8010276b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010276e:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80102770:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102773:	89 04 24             	mov    %eax,(%esp)
80102776:	e8 d7 26 00 00       	call   80104e52 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
8010277b:	a1 54 b6 10 80       	mov    0x8010b654,%eax
80102780:	85 c0                	test   %eax,%eax
80102782:	74 0d                	je     80102791 <ideintr+0xb5>
    idestart(idequeue);
80102784:	a1 54 b6 10 80       	mov    0x8010b654,%eax
80102789:	89 04 24             	mov    %eax,(%esp)
8010278c:	e8 26 fe ff ff       	call   801025b7 <idestart>

  release(&idelock);
80102791:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
80102798:	e8 44 29 00 00       	call   801050e1 <release>
}
8010279d:	c9                   	leave  
8010279e:	c3                   	ret    

8010279f <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
8010279f:	55                   	push   %ebp
801027a0:	89 e5                	mov    %esp,%ebp
801027a2:	83 ec 28             	sub    $0x28,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
801027a5:	8b 45 08             	mov    0x8(%ebp),%eax
801027a8:	8b 00                	mov    (%eax),%eax
801027aa:	83 e0 01             	and    $0x1,%eax
801027ad:	85 c0                	test   %eax,%eax
801027af:	75 0c                	jne    801027bd <iderw+0x1e>
    panic("iderw: buf not busy");
801027b1:	c7 04 24 81 88 10 80 	movl   $0x80108881,(%esp)
801027b8:	e8 7d dd ff ff       	call   8010053a <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801027bd:	8b 45 08             	mov    0x8(%ebp),%eax
801027c0:	8b 00                	mov    (%eax),%eax
801027c2:	83 e0 06             	and    $0x6,%eax
801027c5:	83 f8 02             	cmp    $0x2,%eax
801027c8:	75 0c                	jne    801027d6 <iderw+0x37>
    panic("iderw: nothing to do");
801027ca:	c7 04 24 95 88 10 80 	movl   $0x80108895,(%esp)
801027d1:	e8 64 dd ff ff       	call   8010053a <panic>
  if(b->dev != 0 && !havedisk1)
801027d6:	8b 45 08             	mov    0x8(%ebp),%eax
801027d9:	8b 40 04             	mov    0x4(%eax),%eax
801027dc:	85 c0                	test   %eax,%eax
801027de:	74 15                	je     801027f5 <iderw+0x56>
801027e0:	a1 58 b6 10 80       	mov    0x8010b658,%eax
801027e5:	85 c0                	test   %eax,%eax
801027e7:	75 0c                	jne    801027f5 <iderw+0x56>
    panic("iderw: ide disk 1 not present");
801027e9:	c7 04 24 aa 88 10 80 	movl   $0x801088aa,(%esp)
801027f0:	e8 45 dd ff ff       	call   8010053a <panic>

  acquire(&idelock);  //DOC:acquire-lock
801027f5:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
801027fc:	e8 7e 28 00 00       	call   8010507f <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80102801:	8b 45 08             	mov    0x8(%ebp),%eax
80102804:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010280b:	c7 45 f4 54 b6 10 80 	movl   $0x8010b654,-0xc(%ebp)
80102812:	eb 0b                	jmp    8010281f <iderw+0x80>
80102814:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102817:	8b 00                	mov    (%eax),%eax
80102819:	83 c0 14             	add    $0x14,%eax
8010281c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010281f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102822:	8b 00                	mov    (%eax),%eax
80102824:	85 c0                	test   %eax,%eax
80102826:	75 ec                	jne    80102814 <iderw+0x75>
    ;
  *pp = b;
80102828:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010282b:	8b 55 08             	mov    0x8(%ebp),%edx
8010282e:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
80102830:	a1 54 b6 10 80       	mov    0x8010b654,%eax
80102835:	3b 45 08             	cmp    0x8(%ebp),%eax
80102838:	75 0d                	jne    80102847 <iderw+0xa8>
    idestart(b);
8010283a:	8b 45 08             	mov    0x8(%ebp),%eax
8010283d:	89 04 24             	mov    %eax,(%esp)
80102840:	e8 72 fd ff ff       	call   801025b7 <idestart>
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102845:	eb 15                	jmp    8010285c <iderw+0xbd>
80102847:	eb 13                	jmp    8010285c <iderw+0xbd>
    sleep(b, &idelock);
80102849:	c7 44 24 04 20 b6 10 	movl   $0x8010b620,0x4(%esp)
80102850:	80 
80102851:	8b 45 08             	mov    0x8(%ebp),%eax
80102854:	89 04 24             	mov    %eax,(%esp)
80102857:	e8 b2 24 00 00       	call   80104d0e <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010285c:	8b 45 08             	mov    0x8(%ebp),%eax
8010285f:	8b 00                	mov    (%eax),%eax
80102861:	83 e0 06             	and    $0x6,%eax
80102864:	83 f8 02             	cmp    $0x2,%eax
80102867:	75 e0                	jne    80102849 <iderw+0xaa>
    sleep(b, &idelock);
  }

  release(&idelock);
80102869:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
80102870:	e8 6c 28 00 00       	call   801050e1 <release>
}
80102875:	c9                   	leave  
80102876:	c3                   	ret    
80102877:	90                   	nop

80102878 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102878:	55                   	push   %ebp
80102879:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
8010287b:	a1 54 f8 10 80       	mov    0x8010f854,%eax
80102880:	8b 55 08             	mov    0x8(%ebp),%edx
80102883:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102885:	a1 54 f8 10 80       	mov    0x8010f854,%eax
8010288a:	8b 40 10             	mov    0x10(%eax),%eax
}
8010288d:	5d                   	pop    %ebp
8010288e:	c3                   	ret    

8010288f <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
8010288f:	55                   	push   %ebp
80102890:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102892:	a1 54 f8 10 80       	mov    0x8010f854,%eax
80102897:	8b 55 08             	mov    0x8(%ebp),%edx
8010289a:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
8010289c:	a1 54 f8 10 80       	mov    0x8010f854,%eax
801028a1:	8b 55 0c             	mov    0xc(%ebp),%edx
801028a4:	89 50 10             	mov    %edx,0x10(%eax)
}
801028a7:	5d                   	pop    %ebp
801028a8:	c3                   	ret    

801028a9 <ioapicinit>:

void
ioapicinit(void)
{
801028a9:	55                   	push   %ebp
801028aa:	89 e5                	mov    %esp,%ebp
801028ac:	83 ec 28             	sub    $0x28,%esp
  int i, id, maxintr;

  if(!ismp)
801028af:	a1 24 f9 10 80       	mov    0x8010f924,%eax
801028b4:	85 c0                	test   %eax,%eax
801028b6:	75 05                	jne    801028bd <ioapicinit+0x14>
    return;
801028b8:	e9 9d 00 00 00       	jmp    8010295a <ioapicinit+0xb1>

  ioapic = (volatile struct ioapic*)IOAPIC;
801028bd:	c7 05 54 f8 10 80 00 	movl   $0xfec00000,0x8010f854
801028c4:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801028c7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801028ce:	e8 a5 ff ff ff       	call   80102878 <ioapicread>
801028d3:	c1 e8 10             	shr    $0x10,%eax
801028d6:	25 ff 00 00 00       	and    $0xff,%eax
801028db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
801028de:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801028e5:	e8 8e ff ff ff       	call   80102878 <ioapicread>
801028ea:	c1 e8 18             	shr    $0x18,%eax
801028ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
801028f0:	0f b6 05 20 f9 10 80 	movzbl 0x8010f920,%eax
801028f7:	0f b6 c0             	movzbl %al,%eax
801028fa:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801028fd:	74 0c                	je     8010290b <ioapicinit+0x62>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801028ff:	c7 04 24 c8 88 10 80 	movl   $0x801088c8,(%esp)
80102906:	e8 95 da ff ff       	call   801003a0 <cprintf>

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010290b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102912:	eb 3e                	jmp    80102952 <ioapicinit+0xa9>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102914:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102917:	83 c0 20             	add    $0x20,%eax
8010291a:	0d 00 00 01 00       	or     $0x10000,%eax
8010291f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102922:	83 c2 08             	add    $0x8,%edx
80102925:	01 d2                	add    %edx,%edx
80102927:	89 44 24 04          	mov    %eax,0x4(%esp)
8010292b:	89 14 24             	mov    %edx,(%esp)
8010292e:	e8 5c ff ff ff       	call   8010288f <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102933:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102936:	83 c0 08             	add    $0x8,%eax
80102939:	01 c0                	add    %eax,%eax
8010293b:	83 c0 01             	add    $0x1,%eax
8010293e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102945:	00 
80102946:	89 04 24             	mov    %eax,(%esp)
80102949:	e8 41 ff ff ff       	call   8010288f <ioapicwrite>
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010294e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102952:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102955:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102958:	7e ba                	jle    80102914 <ioapicinit+0x6b>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010295a:	c9                   	leave  
8010295b:	c3                   	ret    

8010295c <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
8010295c:	55                   	push   %ebp
8010295d:	89 e5                	mov    %esp,%ebp
8010295f:	83 ec 08             	sub    $0x8,%esp
  if(!ismp)
80102962:	a1 24 f9 10 80       	mov    0x8010f924,%eax
80102967:	85 c0                	test   %eax,%eax
80102969:	75 02                	jne    8010296d <ioapicenable+0x11>
    return;
8010296b:	eb 37                	jmp    801029a4 <ioapicenable+0x48>

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010296d:	8b 45 08             	mov    0x8(%ebp),%eax
80102970:	83 c0 20             	add    $0x20,%eax
80102973:	8b 55 08             	mov    0x8(%ebp),%edx
80102976:	83 c2 08             	add    $0x8,%edx
80102979:	01 d2                	add    %edx,%edx
8010297b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010297f:	89 14 24             	mov    %edx,(%esp)
80102982:	e8 08 ff ff ff       	call   8010288f <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102987:	8b 45 0c             	mov    0xc(%ebp),%eax
8010298a:	c1 e0 18             	shl    $0x18,%eax
8010298d:	8b 55 08             	mov    0x8(%ebp),%edx
80102990:	83 c2 08             	add    $0x8,%edx
80102993:	01 d2                	add    %edx,%edx
80102995:	83 c2 01             	add    $0x1,%edx
80102998:	89 44 24 04          	mov    %eax,0x4(%esp)
8010299c:	89 14 24             	mov    %edx,(%esp)
8010299f:	e8 eb fe ff ff       	call   8010288f <ioapicwrite>
}
801029a4:	c9                   	leave  
801029a5:	c3                   	ret    
801029a6:	66 90                	xchg   %ax,%ax

801029a8 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
801029a8:	55                   	push   %ebp
801029a9:	89 e5                	mov    %esp,%ebp
801029ab:	8b 45 08             	mov    0x8(%ebp),%eax
801029ae:	05 00 00 00 80       	add    $0x80000000,%eax
801029b3:	5d                   	pop    %ebp
801029b4:	c3                   	ret    

801029b5 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801029b5:	55                   	push   %ebp
801029b6:	89 e5                	mov    %esp,%ebp
801029b8:	83 ec 18             	sub    $0x18,%esp
  initlock(&kmem.lock, "kmem");
801029bb:	c7 44 24 04 fa 88 10 	movl   $0x801088fa,0x4(%esp)
801029c2:	80 
801029c3:	c7 04 24 60 f8 10 80 	movl   $0x8010f860,(%esp)
801029ca:	e8 8f 26 00 00       	call   8010505e <initlock>
  kmem.use_lock = 0;
801029cf:	c7 05 94 f8 10 80 00 	movl   $0x0,0x8010f894
801029d6:	00 00 00 
  freerange(vstart, vend);
801029d9:	8b 45 0c             	mov    0xc(%ebp),%eax
801029dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801029e0:	8b 45 08             	mov    0x8(%ebp),%eax
801029e3:	89 04 24             	mov    %eax,(%esp)
801029e6:	e8 26 00 00 00       	call   80102a11 <freerange>
}
801029eb:	c9                   	leave  
801029ec:	c3                   	ret    

801029ed <kinit2>:

void
kinit2(void *vstart, void *vend)
{
801029ed:	55                   	push   %ebp
801029ee:	89 e5                	mov    %esp,%ebp
801029f0:	83 ec 18             	sub    $0x18,%esp
  freerange(vstart, vend);
801029f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801029f6:	89 44 24 04          	mov    %eax,0x4(%esp)
801029fa:	8b 45 08             	mov    0x8(%ebp),%eax
801029fd:	89 04 24             	mov    %eax,(%esp)
80102a00:	e8 0c 00 00 00       	call   80102a11 <freerange>
  kmem.use_lock = 1;
80102a05:	c7 05 94 f8 10 80 01 	movl   $0x1,0x8010f894
80102a0c:	00 00 00 
}
80102a0f:	c9                   	leave  
80102a10:	c3                   	ret    

80102a11 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102a11:	55                   	push   %ebp
80102a12:	89 e5                	mov    %esp,%ebp
80102a14:	83 ec 28             	sub    $0x28,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102a17:	8b 45 08             	mov    0x8(%ebp),%eax
80102a1a:	05 ff 0f 00 00       	add    $0xfff,%eax
80102a1f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102a24:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a27:	eb 12                	jmp    80102a3b <freerange+0x2a>
    kfree(p);
80102a29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a2c:	89 04 24             	mov    %eax,(%esp)
80102a2f:	e8 16 00 00 00       	call   80102a4a <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a34:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102a3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a3e:	05 00 10 00 00       	add    $0x1000,%eax
80102a43:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102a46:	76 e1                	jbe    80102a29 <freerange+0x18>
    kfree(p);
}
80102a48:	c9                   	leave  
80102a49:	c3                   	ret    

80102a4a <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102a4a:	55                   	push   %ebp
80102a4b:	89 e5                	mov    %esp,%ebp
80102a4d:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102a50:	8b 45 08             	mov    0x8(%ebp),%eax
80102a53:	25 ff 0f 00 00       	and    $0xfff,%eax
80102a58:	85 c0                	test   %eax,%eax
80102a5a:	75 1b                	jne    80102a77 <kfree+0x2d>
80102a5c:	81 7d 08 5c 2a 11 80 	cmpl   $0x80112a5c,0x8(%ebp)
80102a63:	72 12                	jb     80102a77 <kfree+0x2d>
80102a65:	8b 45 08             	mov    0x8(%ebp),%eax
80102a68:	89 04 24             	mov    %eax,(%esp)
80102a6b:	e8 38 ff ff ff       	call   801029a8 <v2p>
80102a70:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102a75:	76 0c                	jbe    80102a83 <kfree+0x39>
    panic("kfree");
80102a77:	c7 04 24 ff 88 10 80 	movl   $0x801088ff,(%esp)
80102a7e:	e8 b7 da ff ff       	call   8010053a <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102a83:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80102a8a:	00 
80102a8b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102a92:	00 
80102a93:	8b 45 08             	mov    0x8(%ebp),%eax
80102a96:	89 04 24             	mov    %eax,(%esp)
80102a99:	e8 38 28 00 00       	call   801052d6 <memset>

  if(kmem.use_lock)
80102a9e:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102aa3:	85 c0                	test   %eax,%eax
80102aa5:	74 0c                	je     80102ab3 <kfree+0x69>
    acquire(&kmem.lock);
80102aa7:	c7 04 24 60 f8 10 80 	movl   $0x8010f860,(%esp)
80102aae:	e8 cc 25 00 00       	call   8010507f <acquire>
  r = (struct run*)v;
80102ab3:	8b 45 08             	mov    0x8(%ebp),%eax
80102ab6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102ab9:	8b 15 98 f8 10 80    	mov    0x8010f898,%edx
80102abf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ac2:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102ac4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ac7:	a3 98 f8 10 80       	mov    %eax,0x8010f898
  if(kmem.use_lock)
80102acc:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102ad1:	85 c0                	test   %eax,%eax
80102ad3:	74 0c                	je     80102ae1 <kfree+0x97>
    release(&kmem.lock);
80102ad5:	c7 04 24 60 f8 10 80 	movl   $0x8010f860,(%esp)
80102adc:	e8 00 26 00 00       	call   801050e1 <release>
}
80102ae1:	c9                   	leave  
80102ae2:	c3                   	ret    

80102ae3 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102ae3:	55                   	push   %ebp
80102ae4:	89 e5                	mov    %esp,%ebp
80102ae6:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if(kmem.use_lock)
80102ae9:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102aee:	85 c0                	test   %eax,%eax
80102af0:	74 0c                	je     80102afe <kalloc+0x1b>
    acquire(&kmem.lock);
80102af2:	c7 04 24 60 f8 10 80 	movl   $0x8010f860,(%esp)
80102af9:	e8 81 25 00 00       	call   8010507f <acquire>
  r = kmem.freelist;
80102afe:	a1 98 f8 10 80       	mov    0x8010f898,%eax
80102b03:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102b06:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102b0a:	74 0a                	je     80102b16 <kalloc+0x33>
    kmem.freelist = r->next;
80102b0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b0f:	8b 00                	mov    (%eax),%eax
80102b11:	a3 98 f8 10 80       	mov    %eax,0x8010f898
  if(kmem.use_lock)
80102b16:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102b1b:	85 c0                	test   %eax,%eax
80102b1d:	74 0c                	je     80102b2b <kalloc+0x48>
    release(&kmem.lock);
80102b1f:	c7 04 24 60 f8 10 80 	movl   $0x8010f860,(%esp)
80102b26:	e8 b6 25 00 00       	call   801050e1 <release>
  return (char*)r;
80102b2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102b2e:	c9                   	leave  
80102b2f:	c3                   	ret    

80102b30 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102b30:	55                   	push   %ebp
80102b31:	89 e5                	mov    %esp,%ebp
80102b33:	83 ec 14             	sub    $0x14,%esp
80102b36:	8b 45 08             	mov    0x8(%ebp),%eax
80102b39:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b3d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102b41:	89 c2                	mov    %eax,%edx
80102b43:	ec                   	in     (%dx),%al
80102b44:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102b47:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102b4b:	c9                   	leave  
80102b4c:	c3                   	ret    

80102b4d <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102b4d:	55                   	push   %ebp
80102b4e:	89 e5                	mov    %esp,%ebp
80102b50:	83 ec 14             	sub    $0x14,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102b53:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
80102b5a:	e8 d1 ff ff ff       	call   80102b30 <inb>
80102b5f:	0f b6 c0             	movzbl %al,%eax
80102b62:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b68:	83 e0 01             	and    $0x1,%eax
80102b6b:	85 c0                	test   %eax,%eax
80102b6d:	75 0a                	jne    80102b79 <kbdgetc+0x2c>
    return -1;
80102b6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102b74:	e9 25 01 00 00       	jmp    80102c9e <kbdgetc+0x151>
  data = inb(KBDATAP);
80102b79:	c7 04 24 60 00 00 00 	movl   $0x60,(%esp)
80102b80:	e8 ab ff ff ff       	call   80102b30 <inb>
80102b85:	0f b6 c0             	movzbl %al,%eax
80102b88:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102b8b:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102b92:	75 17                	jne    80102bab <kbdgetc+0x5e>
    shift |= E0ESC;
80102b94:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102b99:	83 c8 40             	or     $0x40,%eax
80102b9c:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
    return 0;
80102ba1:	b8 00 00 00 00       	mov    $0x0,%eax
80102ba6:	e9 f3 00 00 00       	jmp    80102c9e <kbdgetc+0x151>
  } else if(data & 0x80){
80102bab:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102bae:	25 80 00 00 00       	and    $0x80,%eax
80102bb3:	85 c0                	test   %eax,%eax
80102bb5:	74 45                	je     80102bfc <kbdgetc+0xaf>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102bb7:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102bbc:	83 e0 40             	and    $0x40,%eax
80102bbf:	85 c0                	test   %eax,%eax
80102bc1:	75 08                	jne    80102bcb <kbdgetc+0x7e>
80102bc3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102bc6:	83 e0 7f             	and    $0x7f,%eax
80102bc9:	eb 03                	jmp    80102bce <kbdgetc+0x81>
80102bcb:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102bce:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102bd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102bd4:	05 20 90 10 80       	add    $0x80109020,%eax
80102bd9:	0f b6 00             	movzbl (%eax),%eax
80102bdc:	83 c8 40             	or     $0x40,%eax
80102bdf:	0f b6 c0             	movzbl %al,%eax
80102be2:	f7 d0                	not    %eax
80102be4:	89 c2                	mov    %eax,%edx
80102be6:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102beb:	21 d0                	and    %edx,%eax
80102bed:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
    return 0;
80102bf2:	b8 00 00 00 00       	mov    $0x0,%eax
80102bf7:	e9 a2 00 00 00       	jmp    80102c9e <kbdgetc+0x151>
  } else if(shift & E0ESC){
80102bfc:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c01:	83 e0 40             	and    $0x40,%eax
80102c04:	85 c0                	test   %eax,%eax
80102c06:	74 14                	je     80102c1c <kbdgetc+0xcf>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102c08:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102c0f:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c14:	83 e0 bf             	and    $0xffffffbf,%eax
80102c17:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  }

  shift |= shiftcode[data];
80102c1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c1f:	05 20 90 10 80       	add    $0x80109020,%eax
80102c24:	0f b6 00             	movzbl (%eax),%eax
80102c27:	0f b6 d0             	movzbl %al,%edx
80102c2a:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c2f:	09 d0                	or     %edx,%eax
80102c31:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  shift ^= togglecode[data];
80102c36:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c39:	05 20 91 10 80       	add    $0x80109120,%eax
80102c3e:	0f b6 00             	movzbl (%eax),%eax
80102c41:	0f b6 d0             	movzbl %al,%edx
80102c44:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c49:	31 d0                	xor    %edx,%eax
80102c4b:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  c = charcode[shift & (CTL | SHIFT)][data];
80102c50:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c55:	83 e0 03             	and    $0x3,%eax
80102c58:	8b 14 85 20 95 10 80 	mov    -0x7fef6ae0(,%eax,4),%edx
80102c5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c62:	01 d0                	add    %edx,%eax
80102c64:	0f b6 00             	movzbl (%eax),%eax
80102c67:	0f b6 c0             	movzbl %al,%eax
80102c6a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102c6d:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c72:	83 e0 08             	and    $0x8,%eax
80102c75:	85 c0                	test   %eax,%eax
80102c77:	74 22                	je     80102c9b <kbdgetc+0x14e>
    if('a' <= c && c <= 'z')
80102c79:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102c7d:	76 0c                	jbe    80102c8b <kbdgetc+0x13e>
80102c7f:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102c83:	77 06                	ja     80102c8b <kbdgetc+0x13e>
      c += 'A' - 'a';
80102c85:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102c89:	eb 10                	jmp    80102c9b <kbdgetc+0x14e>
    else if('A' <= c && c <= 'Z')
80102c8b:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102c8f:	76 0a                	jbe    80102c9b <kbdgetc+0x14e>
80102c91:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102c95:	77 04                	ja     80102c9b <kbdgetc+0x14e>
      c += 'a' - 'A';
80102c97:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102c9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102c9e:	c9                   	leave  
80102c9f:	c3                   	ret    

80102ca0 <kbdintr>:

void
kbdintr(void)
{
80102ca0:	55                   	push   %ebp
80102ca1:	89 e5                	mov    %esp,%ebp
80102ca3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80102ca6:	c7 04 24 4d 2b 10 80 	movl   $0x80102b4d,(%esp)
80102cad:	e8 fb da ff ff       	call   801007ad <consoleintr>
}
80102cb2:	c9                   	leave  
80102cb3:	c3                   	ret    

80102cb4 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102cb4:	55                   	push   %ebp
80102cb5:	89 e5                	mov    %esp,%ebp
80102cb7:	83 ec 08             	sub    $0x8,%esp
80102cba:	8b 55 08             	mov    0x8(%ebp),%edx
80102cbd:	8b 45 0c             	mov    0xc(%ebp),%eax
80102cc0:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102cc4:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cc7:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102ccb:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102ccf:	ee                   	out    %al,(%dx)
}
80102cd0:	c9                   	leave  
80102cd1:	c3                   	ret    

80102cd2 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102cd2:	55                   	push   %ebp
80102cd3:	89 e5                	mov    %esp,%ebp
80102cd5:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102cd8:	9c                   	pushf  
80102cd9:	58                   	pop    %eax
80102cda:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102cdd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102ce0:	c9                   	leave  
80102ce1:	c3                   	ret    

80102ce2 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102ce2:	55                   	push   %ebp
80102ce3:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102ce5:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102cea:	8b 55 08             	mov    0x8(%ebp),%edx
80102ced:	c1 e2 02             	shl    $0x2,%edx
80102cf0:	01 c2                	add    %eax,%edx
80102cf2:	8b 45 0c             	mov    0xc(%ebp),%eax
80102cf5:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102cf7:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102cfc:	83 c0 20             	add    $0x20,%eax
80102cff:	8b 00                	mov    (%eax),%eax
}
80102d01:	5d                   	pop    %ebp
80102d02:	c3                   	ret    

80102d03 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102d03:	55                   	push   %ebp
80102d04:	89 e5                	mov    %esp,%ebp
80102d06:	83 ec 08             	sub    $0x8,%esp
  if(!lapic) 
80102d09:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102d0e:	85 c0                	test   %eax,%eax
80102d10:	75 05                	jne    80102d17 <lapicinit+0x14>
    return;
80102d12:	e9 43 01 00 00       	jmp    80102e5a <lapicinit+0x157>

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102d17:	c7 44 24 04 3f 01 00 	movl   $0x13f,0x4(%esp)
80102d1e:	00 
80102d1f:	c7 04 24 3c 00 00 00 	movl   $0x3c,(%esp)
80102d26:	e8 b7 ff ff ff       	call   80102ce2 <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102d2b:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
80102d32:	00 
80102d33:	c7 04 24 f8 00 00 00 	movl   $0xf8,(%esp)
80102d3a:	e8 a3 ff ff ff       	call   80102ce2 <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102d3f:	c7 44 24 04 20 00 02 	movl   $0x20020,0x4(%esp)
80102d46:	00 
80102d47:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102d4e:	e8 8f ff ff ff       	call   80102ce2 <lapicw>
  lapicw(TICR, 10000000); 
80102d53:	c7 44 24 04 80 96 98 	movl   $0x989680,0x4(%esp)
80102d5a:	00 
80102d5b:	c7 04 24 e0 00 00 00 	movl   $0xe0,(%esp)
80102d62:	e8 7b ff ff ff       	call   80102ce2 <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102d67:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102d6e:	00 
80102d6f:	c7 04 24 d4 00 00 00 	movl   $0xd4,(%esp)
80102d76:	e8 67 ff ff ff       	call   80102ce2 <lapicw>
  lapicw(LINT1, MASKED);
80102d7b:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102d82:	00 
80102d83:	c7 04 24 d8 00 00 00 	movl   $0xd8,(%esp)
80102d8a:	e8 53 ff ff ff       	call   80102ce2 <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102d8f:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102d94:	83 c0 30             	add    $0x30,%eax
80102d97:	8b 00                	mov    (%eax),%eax
80102d99:	c1 e8 10             	shr    $0x10,%eax
80102d9c:	0f b6 c0             	movzbl %al,%eax
80102d9f:	83 f8 03             	cmp    $0x3,%eax
80102da2:	76 14                	jbe    80102db8 <lapicinit+0xb5>
    lapicw(PCINT, MASKED);
80102da4:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102dab:	00 
80102dac:	c7 04 24 d0 00 00 00 	movl   $0xd0,(%esp)
80102db3:	e8 2a ff ff ff       	call   80102ce2 <lapicw>

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102db8:	c7 44 24 04 33 00 00 	movl   $0x33,0x4(%esp)
80102dbf:	00 
80102dc0:	c7 04 24 dc 00 00 00 	movl   $0xdc,(%esp)
80102dc7:	e8 16 ff ff ff       	call   80102ce2 <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102dcc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102dd3:	00 
80102dd4:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102ddb:	e8 02 ff ff ff       	call   80102ce2 <lapicw>
  lapicw(ESR, 0);
80102de0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102de7:	00 
80102de8:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102def:	e8 ee fe ff ff       	call   80102ce2 <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102df4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102dfb:	00 
80102dfc:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80102e03:	e8 da fe ff ff       	call   80102ce2 <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102e08:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e0f:	00 
80102e10:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102e17:	e8 c6 fe ff ff       	call   80102ce2 <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102e1c:	c7 44 24 04 00 85 08 	movl   $0x88500,0x4(%esp)
80102e23:	00 
80102e24:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102e2b:	e8 b2 fe ff ff       	call   80102ce2 <lapicw>
  while(lapic[ICRLO] & DELIVS)
80102e30:	90                   	nop
80102e31:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102e36:	05 00 03 00 00       	add    $0x300,%eax
80102e3b:	8b 00                	mov    (%eax),%eax
80102e3d:	25 00 10 00 00       	and    $0x1000,%eax
80102e42:	85 c0                	test   %eax,%eax
80102e44:	75 eb                	jne    80102e31 <lapicinit+0x12e>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102e46:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e4d:	00 
80102e4e:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80102e55:	e8 88 fe ff ff       	call   80102ce2 <lapicw>
}
80102e5a:	c9                   	leave  
80102e5b:	c3                   	ret    

80102e5c <cpunum>:

int
cpunum(void)
{
80102e5c:	55                   	push   %ebp
80102e5d:	89 e5                	mov    %esp,%ebp
80102e5f:	83 ec 18             	sub    $0x18,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102e62:	e8 6b fe ff ff       	call   80102cd2 <readeflags>
80102e67:	25 00 02 00 00       	and    $0x200,%eax
80102e6c:	85 c0                	test   %eax,%eax
80102e6e:	74 25                	je     80102e95 <cpunum+0x39>
    static int n;
    if(n++ == 0)
80102e70:	a1 60 b6 10 80       	mov    0x8010b660,%eax
80102e75:	8d 50 01             	lea    0x1(%eax),%edx
80102e78:	89 15 60 b6 10 80    	mov    %edx,0x8010b660
80102e7e:	85 c0                	test   %eax,%eax
80102e80:	75 13                	jne    80102e95 <cpunum+0x39>
      cprintf("cpu called from %x with interrupts enabled\n",
80102e82:	8b 45 04             	mov    0x4(%ebp),%eax
80102e85:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e89:	c7 04 24 08 89 10 80 	movl   $0x80108908,(%esp)
80102e90:	e8 0b d5 ff ff       	call   801003a0 <cprintf>
        __builtin_return_address(0));
  }

  if(lapic)
80102e95:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102e9a:	85 c0                	test   %eax,%eax
80102e9c:	74 0f                	je     80102ead <cpunum+0x51>
    return lapic[ID]>>24;
80102e9e:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102ea3:	83 c0 20             	add    $0x20,%eax
80102ea6:	8b 00                	mov    (%eax),%eax
80102ea8:	c1 e8 18             	shr    $0x18,%eax
80102eab:	eb 05                	jmp    80102eb2 <cpunum+0x56>
  return 0;
80102ead:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102eb2:	c9                   	leave  
80102eb3:	c3                   	ret    

80102eb4 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102eb4:	55                   	push   %ebp
80102eb5:	89 e5                	mov    %esp,%ebp
80102eb7:	83 ec 08             	sub    $0x8,%esp
  if(lapic)
80102eba:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102ebf:	85 c0                	test   %eax,%eax
80102ec1:	74 14                	je     80102ed7 <lapiceoi+0x23>
    lapicw(EOI, 0);
80102ec3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102eca:	00 
80102ecb:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80102ed2:	e8 0b fe ff ff       	call   80102ce2 <lapicw>
}
80102ed7:	c9                   	leave  
80102ed8:	c3                   	ret    

80102ed9 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102ed9:	55                   	push   %ebp
80102eda:	89 e5                	mov    %esp,%ebp
}
80102edc:	5d                   	pop    %ebp
80102edd:	c3                   	ret    

80102ede <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102ede:	55                   	push   %ebp
80102edf:	89 e5                	mov    %esp,%ebp
80102ee1:	83 ec 1c             	sub    $0x1c,%esp
80102ee4:	8b 45 08             	mov    0x8(%ebp),%eax
80102ee7:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
80102eea:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80102ef1:	00 
80102ef2:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
80102ef9:	e8 b6 fd ff ff       	call   80102cb4 <outb>
  outb(IO_RTC+1, 0x0A);
80102efe:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80102f05:	00 
80102f06:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
80102f0d:	e8 a2 fd ff ff       	call   80102cb4 <outb>
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80102f12:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80102f19:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102f1c:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80102f21:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102f24:	8d 50 02             	lea    0x2(%eax),%edx
80102f27:	8b 45 0c             	mov    0xc(%ebp),%eax
80102f2a:	c1 e8 04             	shr    $0x4,%eax
80102f2d:	66 89 02             	mov    %ax,(%edx)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102f30:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102f34:	c1 e0 18             	shl    $0x18,%eax
80102f37:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f3b:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102f42:	e8 9b fd ff ff       	call   80102ce2 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80102f47:	c7 44 24 04 00 c5 00 	movl   $0xc500,0x4(%esp)
80102f4e:	00 
80102f4f:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102f56:	e8 87 fd ff ff       	call   80102ce2 <lapicw>
  microdelay(200);
80102f5b:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102f62:	e8 72 ff ff ff       	call   80102ed9 <microdelay>
  lapicw(ICRLO, INIT | LEVEL);
80102f67:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
80102f6e:	00 
80102f6f:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102f76:	e8 67 fd ff ff       	call   80102ce2 <lapicw>
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80102f7b:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
80102f82:	e8 52 ff ff ff       	call   80102ed9 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80102f87:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80102f8e:	eb 40                	jmp    80102fd0 <lapicstartap+0xf2>
    lapicw(ICRHI, apicid<<24);
80102f90:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102f94:	c1 e0 18             	shl    $0x18,%eax
80102f97:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f9b:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102fa2:	e8 3b fd ff ff       	call   80102ce2 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
80102fa7:	8b 45 0c             	mov    0xc(%ebp),%eax
80102faa:	c1 e8 0c             	shr    $0xc,%eax
80102fad:	80 cc 06             	or     $0x6,%ah
80102fb0:	89 44 24 04          	mov    %eax,0x4(%esp)
80102fb4:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102fbb:	e8 22 fd ff ff       	call   80102ce2 <lapicw>
    microdelay(200);
80102fc0:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102fc7:	e8 0d ff ff ff       	call   80102ed9 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80102fcc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80102fd0:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80102fd4:	7e ba                	jle    80102f90 <lapicstartap+0xb2>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80102fd6:	c9                   	leave  
80102fd7:	c3                   	ret    

80102fd8 <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
80102fd8:	55                   	push   %ebp
80102fd9:	89 e5                	mov    %esp,%ebp
80102fdb:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102fde:	c7 44 24 04 34 89 10 	movl   $0x80108934,0x4(%esp)
80102fe5:	80 
80102fe6:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
80102fed:	e8 6c 20 00 00       	call   8010505e <initlock>
  readsb(ROOTDEV, &sb);
80102ff2:	8d 45 e8             	lea    -0x18(%ebp),%eax
80102ff5:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ff9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103000:	e8 e7 e2 ff ff       	call   801012ec <readsb>
  log.start = sb.size - sb.nlog;
80103005:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103008:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010300b:	29 c2                	sub    %eax,%edx
8010300d:	89 d0                	mov    %edx,%eax
8010300f:	a3 d4 f8 10 80       	mov    %eax,0x8010f8d4
  log.size = sb.nlog;
80103014:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103017:	a3 d8 f8 10 80       	mov    %eax,0x8010f8d8
  log.dev = ROOTDEV;
8010301c:	c7 05 e0 f8 10 80 01 	movl   $0x1,0x8010f8e0
80103023:	00 00 00 
  recover_from_log();
80103026:	e8 9a 01 00 00       	call   801031c5 <recover_from_log>
}
8010302b:	c9                   	leave  
8010302c:	c3                   	ret    

8010302d <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
8010302d:	55                   	push   %ebp
8010302e:	89 e5                	mov    %esp,%ebp
80103030:	83 ec 28             	sub    $0x28,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103033:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010303a:	e9 8c 00 00 00       	jmp    801030cb <install_trans+0x9e>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
8010303f:	8b 15 d4 f8 10 80    	mov    0x8010f8d4,%edx
80103045:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103048:	01 d0                	add    %edx,%eax
8010304a:	83 c0 01             	add    $0x1,%eax
8010304d:	89 c2                	mov    %eax,%edx
8010304f:	a1 e0 f8 10 80       	mov    0x8010f8e0,%eax
80103054:	89 54 24 04          	mov    %edx,0x4(%esp)
80103058:	89 04 24             	mov    %eax,(%esp)
8010305b:	e8 46 d1 ff ff       	call   801001a6 <bread>
80103060:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
80103063:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103066:	83 c0 10             	add    $0x10,%eax
80103069:	8b 04 85 a8 f8 10 80 	mov    -0x7fef0758(,%eax,4),%eax
80103070:	89 c2                	mov    %eax,%edx
80103072:	a1 e0 f8 10 80       	mov    0x8010f8e0,%eax
80103077:	89 54 24 04          	mov    %edx,0x4(%esp)
8010307b:	89 04 24             	mov    %eax,(%esp)
8010307e:	e8 23 d1 ff ff       	call   801001a6 <bread>
80103083:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103086:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103089:	8d 50 18             	lea    0x18(%eax),%edx
8010308c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010308f:	83 c0 18             	add    $0x18,%eax
80103092:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80103099:	00 
8010309a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010309e:	89 04 24             	mov    %eax,(%esp)
801030a1:	e8 ff 22 00 00       	call   801053a5 <memmove>
    bwrite(dbuf);  // write dst to disk
801030a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801030a9:	89 04 24             	mov    %eax,(%esp)
801030ac:	e8 2c d1 ff ff       	call   801001dd <bwrite>
    brelse(lbuf); 
801030b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801030b4:	89 04 24             	mov    %eax,(%esp)
801030b7:	e8 5b d1 ff ff       	call   80100217 <brelse>
    brelse(dbuf);
801030bc:	8b 45 ec             	mov    -0x14(%ebp),%eax
801030bf:	89 04 24             	mov    %eax,(%esp)
801030c2:	e8 50 d1 ff ff       	call   80100217 <brelse>
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801030c7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801030cb:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
801030d0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801030d3:	0f 8f 66 ff ff ff    	jg     8010303f <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
801030d9:	c9                   	leave  
801030da:	c3                   	ret    

801030db <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
801030db:	55                   	push   %ebp
801030dc:	89 e5                	mov    %esp,%ebp
801030de:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
801030e1:	a1 d4 f8 10 80       	mov    0x8010f8d4,%eax
801030e6:	89 c2                	mov    %eax,%edx
801030e8:	a1 e0 f8 10 80       	mov    0x8010f8e0,%eax
801030ed:	89 54 24 04          	mov    %edx,0x4(%esp)
801030f1:	89 04 24             	mov    %eax,(%esp)
801030f4:	e8 ad d0 ff ff       	call   801001a6 <bread>
801030f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
801030fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801030ff:	83 c0 18             	add    $0x18,%eax
80103102:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103105:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103108:	8b 00                	mov    (%eax),%eax
8010310a:	a3 e4 f8 10 80       	mov    %eax,0x8010f8e4
  for (i = 0; i < log.lh.n; i++) {
8010310f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103116:	eb 1b                	jmp    80103133 <read_head+0x58>
    log.lh.sector[i] = lh->sector[i];
80103118:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010311b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010311e:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103122:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103125:	83 c2 10             	add    $0x10,%edx
80103128:	89 04 95 a8 f8 10 80 	mov    %eax,-0x7fef0758(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
8010312f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103133:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
80103138:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010313b:	7f db                	jg     80103118 <read_head+0x3d>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
8010313d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103140:	89 04 24             	mov    %eax,(%esp)
80103143:	e8 cf d0 ff ff       	call   80100217 <brelse>
}
80103148:	c9                   	leave  
80103149:	c3                   	ret    

8010314a <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
8010314a:	55                   	push   %ebp
8010314b:	89 e5                	mov    %esp,%ebp
8010314d:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
80103150:	a1 d4 f8 10 80       	mov    0x8010f8d4,%eax
80103155:	89 c2                	mov    %eax,%edx
80103157:	a1 e0 f8 10 80       	mov    0x8010f8e0,%eax
8010315c:	89 54 24 04          	mov    %edx,0x4(%esp)
80103160:	89 04 24             	mov    %eax,(%esp)
80103163:	e8 3e d0 ff ff       	call   801001a6 <bread>
80103168:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
8010316b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010316e:	83 c0 18             	add    $0x18,%eax
80103171:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
80103174:	8b 15 e4 f8 10 80    	mov    0x8010f8e4,%edx
8010317a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010317d:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
8010317f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103186:	eb 1b                	jmp    801031a3 <write_head+0x59>
    hb->sector[i] = log.lh.sector[i];
80103188:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010318b:	83 c0 10             	add    $0x10,%eax
8010318e:	8b 0c 85 a8 f8 10 80 	mov    -0x7fef0758(,%eax,4),%ecx
80103195:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103198:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010319b:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
8010319f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801031a3:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
801031a8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801031ab:	7f db                	jg     80103188 <write_head+0x3e>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
801031ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
801031b0:	89 04 24             	mov    %eax,(%esp)
801031b3:	e8 25 d0 ff ff       	call   801001dd <bwrite>
  brelse(buf);
801031b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801031bb:	89 04 24             	mov    %eax,(%esp)
801031be:	e8 54 d0 ff ff       	call   80100217 <brelse>
}
801031c3:	c9                   	leave  
801031c4:	c3                   	ret    

801031c5 <recover_from_log>:

static void
recover_from_log(void)
{
801031c5:	55                   	push   %ebp
801031c6:	89 e5                	mov    %esp,%ebp
801031c8:	83 ec 08             	sub    $0x8,%esp
  read_head();      
801031cb:	e8 0b ff ff ff       	call   801030db <read_head>
  install_trans(); // if committed, copy from log to disk
801031d0:	e8 58 fe ff ff       	call   8010302d <install_trans>
  log.lh.n = 0;
801031d5:	c7 05 e4 f8 10 80 00 	movl   $0x0,0x8010f8e4
801031dc:	00 00 00 
  write_head(); // clear the log
801031df:	e8 66 ff ff ff       	call   8010314a <write_head>
}
801031e4:	c9                   	leave  
801031e5:	c3                   	ret    

801031e6 <begin_trans>:

void
begin_trans(void)
{
801031e6:	55                   	push   %ebp
801031e7:	89 e5                	mov    %esp,%ebp
801031e9:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
801031ec:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
801031f3:	e8 87 1e 00 00       	call   8010507f <acquire>
  while (log.busy) {
801031f8:	eb 14                	jmp    8010320e <begin_trans+0x28>
    sleep(&log, &log.lock);
801031fa:	c7 44 24 04 a0 f8 10 	movl   $0x8010f8a0,0x4(%esp)
80103201:	80 
80103202:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
80103209:	e8 00 1b 00 00       	call   80104d0e <sleep>

void
begin_trans(void)
{
  acquire(&log.lock);
  while (log.busy) {
8010320e:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
80103213:	85 c0                	test   %eax,%eax
80103215:	75 e3                	jne    801031fa <begin_trans+0x14>
    sleep(&log, &log.lock);
  }
  log.busy = 1;
80103217:	c7 05 dc f8 10 80 01 	movl   $0x1,0x8010f8dc
8010321e:	00 00 00 
  release(&log.lock);
80103221:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
80103228:	e8 b4 1e 00 00       	call   801050e1 <release>
}
8010322d:	c9                   	leave  
8010322e:	c3                   	ret    

8010322f <commit_trans>:

void
commit_trans(void)
{
8010322f:	55                   	push   %ebp
80103230:	89 e5                	mov    %esp,%ebp
80103232:	83 ec 18             	sub    $0x18,%esp
  if (log.lh.n > 0) {
80103235:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
8010323a:	85 c0                	test   %eax,%eax
8010323c:	7e 19                	jle    80103257 <commit_trans+0x28>
    write_head();    // Write header to disk -- the real commit
8010323e:	e8 07 ff ff ff       	call   8010314a <write_head>
    install_trans(); // Now install writes to home locations
80103243:	e8 e5 fd ff ff       	call   8010302d <install_trans>
    log.lh.n = 0; 
80103248:	c7 05 e4 f8 10 80 00 	movl   $0x0,0x8010f8e4
8010324f:	00 00 00 
    write_head();    // Erase the transaction from the log
80103252:	e8 f3 fe ff ff       	call   8010314a <write_head>
  }
  
  acquire(&log.lock);
80103257:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
8010325e:	e8 1c 1e 00 00       	call   8010507f <acquire>
  log.busy = 0;
80103263:	c7 05 dc f8 10 80 00 	movl   $0x0,0x8010f8dc
8010326a:	00 00 00 
  wakeup(&log);
8010326d:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
80103274:	e8 d9 1b 00 00       	call   80104e52 <wakeup>
  release(&log.lock);
80103279:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
80103280:	e8 5c 1e 00 00       	call   801050e1 <release>
}
80103285:	c9                   	leave  
80103286:	c3                   	ret    

80103287 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103287:	55                   	push   %ebp
80103288:	89 e5                	mov    %esp,%ebp
8010328a:	83 ec 28             	sub    $0x28,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010328d:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
80103292:	83 f8 09             	cmp    $0x9,%eax
80103295:	7f 12                	jg     801032a9 <log_write+0x22>
80103297:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
8010329c:	8b 15 d8 f8 10 80    	mov    0x8010f8d8,%edx
801032a2:	83 ea 01             	sub    $0x1,%edx
801032a5:	39 d0                	cmp    %edx,%eax
801032a7:	7c 0c                	jl     801032b5 <log_write+0x2e>
    panic("too big a transaction");
801032a9:	c7 04 24 38 89 10 80 	movl   $0x80108938,(%esp)
801032b0:	e8 85 d2 ff ff       	call   8010053a <panic>
  if (!log.busy)
801032b5:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
801032ba:	85 c0                	test   %eax,%eax
801032bc:	75 0c                	jne    801032ca <log_write+0x43>
    panic("write outside of trans");
801032be:	c7 04 24 4e 89 10 80 	movl   $0x8010894e,(%esp)
801032c5:	e8 70 d2 ff ff       	call   8010053a <panic>

  for (i = 0; i < log.lh.n; i++) {
801032ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801032d1:	eb 1f                	jmp    801032f2 <log_write+0x6b>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
801032d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801032d6:	83 c0 10             	add    $0x10,%eax
801032d9:	8b 04 85 a8 f8 10 80 	mov    -0x7fef0758(,%eax,4),%eax
801032e0:	89 c2                	mov    %eax,%edx
801032e2:	8b 45 08             	mov    0x8(%ebp),%eax
801032e5:	8b 40 08             	mov    0x8(%eax),%eax
801032e8:	39 c2                	cmp    %eax,%edx
801032ea:	75 02                	jne    801032ee <log_write+0x67>
      break;
801032ec:	eb 0e                	jmp    801032fc <log_write+0x75>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
  if (!log.busy)
    panic("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
801032ee:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801032f2:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
801032f7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801032fa:	7f d7                	jg     801032d3 <log_write+0x4c>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
  }
  log.lh.sector[i] = b->sector;
801032fc:	8b 45 08             	mov    0x8(%ebp),%eax
801032ff:	8b 40 08             	mov    0x8(%eax),%eax
80103302:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103305:	83 c2 10             	add    $0x10,%edx
80103308:	89 04 95 a8 f8 10 80 	mov    %eax,-0x7fef0758(,%edx,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
8010330f:	8b 15 d4 f8 10 80    	mov    0x8010f8d4,%edx
80103315:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103318:	01 d0                	add    %edx,%eax
8010331a:	83 c0 01             	add    $0x1,%eax
8010331d:	89 c2                	mov    %eax,%edx
8010331f:	8b 45 08             	mov    0x8(%ebp),%eax
80103322:	8b 40 04             	mov    0x4(%eax),%eax
80103325:	89 54 24 04          	mov    %edx,0x4(%esp)
80103329:	89 04 24             	mov    %eax,(%esp)
8010332c:	e8 75 ce ff ff       	call   801001a6 <bread>
80103331:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
80103334:	8b 45 08             	mov    0x8(%ebp),%eax
80103337:	8d 50 18             	lea    0x18(%eax),%edx
8010333a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010333d:	83 c0 18             	add    $0x18,%eax
80103340:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80103347:	00 
80103348:	89 54 24 04          	mov    %edx,0x4(%esp)
8010334c:	89 04 24             	mov    %eax,(%esp)
8010334f:	e8 51 20 00 00       	call   801053a5 <memmove>
  bwrite(lbuf);
80103354:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103357:	89 04 24             	mov    %eax,(%esp)
8010335a:	e8 7e ce ff ff       	call   801001dd <bwrite>
  brelse(lbuf);
8010335f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103362:	89 04 24             	mov    %eax,(%esp)
80103365:	e8 ad ce ff ff       	call   80100217 <brelse>
  if (i == log.lh.n)
8010336a:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
8010336f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103372:	75 0d                	jne    80103381 <log_write+0xfa>
    log.lh.n++;
80103374:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
80103379:	83 c0 01             	add    $0x1,%eax
8010337c:	a3 e4 f8 10 80       	mov    %eax,0x8010f8e4
  b->flags |= B_DIRTY; // XXX prevent eviction
80103381:	8b 45 08             	mov    0x8(%ebp),%eax
80103384:	8b 00                	mov    (%eax),%eax
80103386:	83 c8 04             	or     $0x4,%eax
80103389:	89 c2                	mov    %eax,%edx
8010338b:	8b 45 08             	mov    0x8(%ebp),%eax
8010338e:	89 10                	mov    %edx,(%eax)
}
80103390:	c9                   	leave  
80103391:	c3                   	ret    
80103392:	66 90                	xchg   %ax,%ax

80103394 <v2p>:
80103394:	55                   	push   %ebp
80103395:	89 e5                	mov    %esp,%ebp
80103397:	8b 45 08             	mov    0x8(%ebp),%eax
8010339a:	05 00 00 00 80       	add    $0x80000000,%eax
8010339f:	5d                   	pop    %ebp
801033a0:	c3                   	ret    

801033a1 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801033a1:	55                   	push   %ebp
801033a2:	89 e5                	mov    %esp,%ebp
801033a4:	8b 45 08             	mov    0x8(%ebp),%eax
801033a7:	05 00 00 00 80       	add    $0x80000000,%eax
801033ac:	5d                   	pop    %ebp
801033ad:	c3                   	ret    

801033ae <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
801033ae:	55                   	push   %ebp
801033af:	89 e5                	mov    %esp,%ebp
801033b1:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801033b4:	8b 55 08             	mov    0x8(%ebp),%edx
801033b7:	8b 45 0c             	mov    0xc(%ebp),%eax
801033ba:	8b 4d 08             	mov    0x8(%ebp),%ecx
801033bd:	f0 87 02             	lock xchg %eax,(%edx)
801033c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801033c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801033c6:	c9                   	leave  
801033c7:	c3                   	ret    

801033c8 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
801033c8:	55                   	push   %ebp
801033c9:	89 e5                	mov    %esp,%ebp
801033cb:	83 e4 f0             	and    $0xfffffff0,%esp
801033ce:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801033d1:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
801033d8:	80 
801033d9:	c7 04 24 5c 2a 11 80 	movl   $0x80112a5c,(%esp)
801033e0:	e8 d0 f5 ff ff       	call   801029b5 <kinit1>
  kvmalloc();      // kernel page table
801033e5:	e8 90 4b 00 00       	call   80107f7a <kvmalloc>
  mpinit();        // collect info about this machine
801033ea:	e8 47 04 00 00       	call   80103836 <mpinit>
  lapicinit();
801033ef:	e8 0f f9 ff ff       	call   80102d03 <lapicinit>
  seginit();       // set up segments
801033f4:	e8 14 45 00 00       	call   8010790d <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
801033f9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801033ff:	0f b6 00             	movzbl (%eax),%eax
80103402:	0f b6 c0             	movzbl %al,%eax
80103405:	89 44 24 04          	mov    %eax,0x4(%esp)
80103409:	c7 04 24 65 89 10 80 	movl   $0x80108965,(%esp)
80103410:	e8 8b cf ff ff       	call   801003a0 <cprintf>
  picinit();       // interrupt controller
80103415:	e8 7d 06 00 00       	call   80103a97 <picinit>
  ioapicinit();    // another interrupt controller
8010341a:	e8 8a f4 ff ff       	call   801028a9 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
8010341f:	e8 5d d6 ff ff       	call   80100a81 <consoleinit>
  uartinit();      // serial port
80103424:	e8 2e 38 00 00       	call   80106c57 <uartinit>
  pinit();         // process table
80103429:	e8 fa 0b 00 00       	call   80104028 <pinit>
  tvinit();        // trap vectors
8010342e:	e8 d3 33 00 00       	call   80106806 <tvinit>
  binit();         // buffer cache
80103433:	e8 fc cb ff ff       	call   80100034 <binit>
  fileinit();      // file table
80103438:	e8 c7 da ff ff       	call   80100f04 <fileinit>
  iinit();         // inode cache
8010343d:	e8 5d e1 ff ff       	call   8010159f <iinit>
  ideinit();       // disk
80103442:	e8 ca f0 ff ff       	call   80102511 <ideinit>
  if(!ismp)
80103447:	a1 24 f9 10 80       	mov    0x8010f924,%eax
8010344c:	85 c0                	test   %eax,%eax
8010344e:	75 05                	jne    80103455 <main+0x8d>
    timerinit();   // uniprocessor timer
80103450:	e8 f9 32 00 00       	call   8010674e <timerinit>
  startothers();   // start other processors
80103455:	e8 7f 00 00 00       	call   801034d9 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
8010345a:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80103461:	8e 
80103462:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103469:	e8 7f f5 ff ff       	call   801029ed <kinit2>
  userinit();      // first user process
8010346e:	e8 e7 0c 00 00       	call   8010415a <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
80103473:	e8 1a 00 00 00       	call   80103492 <mpmain>

80103478 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103478:	55                   	push   %ebp
80103479:	89 e5                	mov    %esp,%ebp
8010347b:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
8010347e:	e8 0e 4b 00 00       	call   80107f91 <switchkvm>
  seginit();
80103483:	e8 85 44 00 00       	call   8010790d <seginit>
  lapicinit();
80103488:	e8 76 f8 ff ff       	call   80102d03 <lapicinit>
  mpmain();
8010348d:	e8 00 00 00 00       	call   80103492 <mpmain>

80103492 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103492:	55                   	push   %ebp
80103493:	89 e5                	mov    %esp,%ebp
80103495:	83 ec 18             	sub    $0x18,%esp
  cprintf("cpu%d: starting\n", cpu->id);
80103498:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010349e:	0f b6 00             	movzbl (%eax),%eax
801034a1:	0f b6 c0             	movzbl %al,%eax
801034a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801034a8:	c7 04 24 7c 89 10 80 	movl   $0x8010897c,(%esp)
801034af:	e8 ec ce ff ff       	call   801003a0 <cprintf>
  idtinit();       // load idt register
801034b4:	e8 c1 34 00 00       	call   8010697a <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
801034b9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801034bf:	05 a8 00 00 00       	add    $0xa8,%eax
801034c4:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801034cb:	00 
801034cc:	89 04 24             	mov    %eax,(%esp)
801034cf:	e8 da fe ff ff       	call   801033ae <xchg>
  scheduler();     // start running processes
801034d4:	e8 60 15 00 00       	call   80104a39 <scheduler>

801034d9 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
801034d9:	55                   	push   %ebp
801034da:	89 e5                	mov    %esp,%ebp
801034dc:	53                   	push   %ebx
801034dd:	83 ec 24             	sub    $0x24,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
801034e0:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
801034e7:	e8 b5 fe ff ff       	call   801033a1 <p2v>
801034ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801034ef:	b8 8a 00 00 00       	mov    $0x8a,%eax
801034f4:	89 44 24 08          	mov    %eax,0x8(%esp)
801034f8:	c7 44 24 04 2c b5 10 	movl   $0x8010b52c,0x4(%esp)
801034ff:	80 
80103500:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103503:	89 04 24             	mov    %eax,(%esp)
80103506:	e8 9a 1e 00 00       	call   801053a5 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010350b:	c7 45 f4 40 f9 10 80 	movl   $0x8010f940,-0xc(%ebp)
80103512:	e9 85 00 00 00       	jmp    8010359c <startothers+0xc3>
    if(c == cpus+cpunum())  // We've started already.
80103517:	e8 40 f9 ff ff       	call   80102e5c <cpunum>
8010351c:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103522:	05 40 f9 10 80       	add    $0x8010f940,%eax
80103527:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010352a:	75 02                	jne    8010352e <startothers+0x55>
      continue;
8010352c:	eb 67                	jmp    80103595 <startothers+0xbc>

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
8010352e:	e8 b0 f5 ff ff       	call   80102ae3 <kalloc>
80103533:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103536:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103539:	83 e8 04             	sub    $0x4,%eax
8010353c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010353f:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103545:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103547:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010354a:	83 e8 08             	sub    $0x8,%eax
8010354d:	c7 00 78 34 10 80    	movl   $0x80103478,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
80103553:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103556:	8d 58 f4             	lea    -0xc(%eax),%ebx
80103559:	c7 04 24 00 a0 10 80 	movl   $0x8010a000,(%esp)
80103560:	e8 2f fe ff ff       	call   80103394 <v2p>
80103565:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
80103567:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010356a:	89 04 24             	mov    %eax,(%esp)
8010356d:	e8 22 fe ff ff       	call   80103394 <v2p>
80103572:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103575:	0f b6 12             	movzbl (%edx),%edx
80103578:	0f b6 d2             	movzbl %dl,%edx
8010357b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010357f:	89 14 24             	mov    %edx,(%esp)
80103582:	e8 57 f9 ff ff       	call   80102ede <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103587:	90                   	nop
80103588:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010358b:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103591:	85 c0                	test   %eax,%eax
80103593:	74 f3                	je     80103588 <startothers+0xaf>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103595:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
8010359c:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801035a1:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801035a7:	05 40 f9 10 80       	add    $0x8010f940,%eax
801035ac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801035af:	0f 87 62 ff ff ff    	ja     80103517 <startothers+0x3e>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
801035b5:	83 c4 24             	add    $0x24,%esp
801035b8:	5b                   	pop    %ebx
801035b9:	5d                   	pop    %ebp
801035ba:	c3                   	ret    
801035bb:	90                   	nop

801035bc <p2v>:
801035bc:	55                   	push   %ebp
801035bd:	89 e5                	mov    %esp,%ebp
801035bf:	8b 45 08             	mov    0x8(%ebp),%eax
801035c2:	05 00 00 00 80       	add    $0x80000000,%eax
801035c7:	5d                   	pop    %ebp
801035c8:	c3                   	ret    

801035c9 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801035c9:	55                   	push   %ebp
801035ca:	89 e5                	mov    %esp,%ebp
801035cc:	83 ec 14             	sub    $0x14,%esp
801035cf:	8b 45 08             	mov    0x8(%ebp),%eax
801035d2:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035d6:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801035da:	89 c2                	mov    %eax,%edx
801035dc:	ec                   	in     (%dx),%al
801035dd:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801035e0:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801035e4:	c9                   	leave  
801035e5:	c3                   	ret    

801035e6 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801035e6:	55                   	push   %ebp
801035e7:	89 e5                	mov    %esp,%ebp
801035e9:	83 ec 08             	sub    $0x8,%esp
801035ec:	8b 55 08             	mov    0x8(%ebp),%edx
801035ef:	8b 45 0c             	mov    0xc(%ebp),%eax
801035f2:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801035f6:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035f9:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801035fd:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103601:	ee                   	out    %al,(%dx)
}
80103602:	c9                   	leave  
80103603:	c3                   	ret    

80103604 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103604:	55                   	push   %ebp
80103605:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103607:	a1 64 b6 10 80       	mov    0x8010b664,%eax
8010360c:	89 c2                	mov    %eax,%edx
8010360e:	b8 40 f9 10 80       	mov    $0x8010f940,%eax
80103613:	29 c2                	sub    %eax,%edx
80103615:	89 d0                	mov    %edx,%eax
80103617:	c1 f8 02             	sar    $0x2,%eax
8010361a:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103620:	5d                   	pop    %ebp
80103621:	c3                   	ret    

80103622 <sum>:

static uchar
sum(uchar *addr, int len)
{
80103622:	55                   	push   %ebp
80103623:	89 e5                	mov    %esp,%ebp
80103625:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103628:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
8010362f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103636:	eb 15                	jmp    8010364d <sum+0x2b>
    sum += addr[i];
80103638:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010363b:	8b 45 08             	mov    0x8(%ebp),%eax
8010363e:	01 d0                	add    %edx,%eax
80103640:	0f b6 00             	movzbl (%eax),%eax
80103643:	0f b6 c0             	movzbl %al,%eax
80103646:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103649:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010364d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103650:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103653:	7c e3                	jl     80103638 <sum+0x16>
    sum += addr[i];
  return sum;
80103655:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103658:	c9                   	leave  
80103659:	c3                   	ret    

8010365a <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010365a:	55                   	push   %ebp
8010365b:	89 e5                	mov    %esp,%ebp
8010365d:	83 ec 28             	sub    $0x28,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103660:	8b 45 08             	mov    0x8(%ebp),%eax
80103663:	89 04 24             	mov    %eax,(%esp)
80103666:	e8 51 ff ff ff       	call   801035bc <p2v>
8010366b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
8010366e:	8b 55 0c             	mov    0xc(%ebp),%edx
80103671:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103674:	01 d0                	add    %edx,%eax
80103676:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103679:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010367c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010367f:	eb 3f                	jmp    801036c0 <mpsearch1+0x66>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103681:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80103688:	00 
80103689:	c7 44 24 04 90 89 10 	movl   $0x80108990,0x4(%esp)
80103690:	80 
80103691:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103694:	89 04 24             	mov    %eax,(%esp)
80103697:	e8 b1 1c 00 00       	call   8010534d <memcmp>
8010369c:	85 c0                	test   %eax,%eax
8010369e:	75 1c                	jne    801036bc <mpsearch1+0x62>
801036a0:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
801036a7:	00 
801036a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036ab:	89 04 24             	mov    %eax,(%esp)
801036ae:	e8 6f ff ff ff       	call   80103622 <sum>
801036b3:	84 c0                	test   %al,%al
801036b5:	75 05                	jne    801036bc <mpsearch1+0x62>
      return (struct mp*)p;
801036b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036ba:	eb 11                	jmp    801036cd <mpsearch1+0x73>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801036bc:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801036c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036c3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801036c6:	72 b9                	jb     80103681 <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
801036c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
801036cd:	c9                   	leave  
801036ce:	c3                   	ret    

801036cf <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
801036cf:	55                   	push   %ebp
801036d0:	89 e5                	mov    %esp,%ebp
801036d2:	83 ec 28             	sub    $0x28,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
801036d5:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801036dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036df:	83 c0 0f             	add    $0xf,%eax
801036e2:	0f b6 00             	movzbl (%eax),%eax
801036e5:	0f b6 c0             	movzbl %al,%eax
801036e8:	c1 e0 08             	shl    $0x8,%eax
801036eb:	89 c2                	mov    %eax,%edx
801036ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036f0:	83 c0 0e             	add    $0xe,%eax
801036f3:	0f b6 00             	movzbl (%eax),%eax
801036f6:	0f b6 c0             	movzbl %al,%eax
801036f9:	09 d0                	or     %edx,%eax
801036fb:	c1 e0 04             	shl    $0x4,%eax
801036fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103701:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103705:	74 21                	je     80103728 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103707:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
8010370e:	00 
8010370f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103712:	89 04 24             	mov    %eax,(%esp)
80103715:	e8 40 ff ff ff       	call   8010365a <mpsearch1>
8010371a:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010371d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103721:	74 50                	je     80103773 <mpsearch+0xa4>
      return mp;
80103723:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103726:	eb 5f                	jmp    80103787 <mpsearch+0xb8>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103728:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010372b:	83 c0 14             	add    $0x14,%eax
8010372e:	0f b6 00             	movzbl (%eax),%eax
80103731:	0f b6 c0             	movzbl %al,%eax
80103734:	c1 e0 08             	shl    $0x8,%eax
80103737:	89 c2                	mov    %eax,%edx
80103739:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010373c:	83 c0 13             	add    $0x13,%eax
8010373f:	0f b6 00             	movzbl (%eax),%eax
80103742:	0f b6 c0             	movzbl %al,%eax
80103745:	09 d0                	or     %edx,%eax
80103747:	c1 e0 0a             	shl    $0xa,%eax
8010374a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
8010374d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103750:	2d 00 04 00 00       	sub    $0x400,%eax
80103755:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
8010375c:	00 
8010375d:	89 04 24             	mov    %eax,(%esp)
80103760:	e8 f5 fe ff ff       	call   8010365a <mpsearch1>
80103765:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103768:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010376c:	74 05                	je     80103773 <mpsearch+0xa4>
      return mp;
8010376e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103771:	eb 14                	jmp    80103787 <mpsearch+0xb8>
  }
  return mpsearch1(0xF0000, 0x10000);
80103773:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
8010377a:	00 
8010377b:	c7 04 24 00 00 0f 00 	movl   $0xf0000,(%esp)
80103782:	e8 d3 fe ff ff       	call   8010365a <mpsearch1>
}
80103787:	c9                   	leave  
80103788:	c3                   	ret    

80103789 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103789:	55                   	push   %ebp
8010378a:	89 e5                	mov    %esp,%ebp
8010378c:	83 ec 28             	sub    $0x28,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010378f:	e8 3b ff ff ff       	call   801036cf <mpsearch>
80103794:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103797:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010379b:	74 0a                	je     801037a7 <mpconfig+0x1e>
8010379d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037a0:	8b 40 04             	mov    0x4(%eax),%eax
801037a3:	85 c0                	test   %eax,%eax
801037a5:	75 0a                	jne    801037b1 <mpconfig+0x28>
    return 0;
801037a7:	b8 00 00 00 00       	mov    $0x0,%eax
801037ac:	e9 83 00 00 00       	jmp    80103834 <mpconfig+0xab>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
801037b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037b4:	8b 40 04             	mov    0x4(%eax),%eax
801037b7:	89 04 24             	mov    %eax,(%esp)
801037ba:	e8 fd fd ff ff       	call   801035bc <p2v>
801037bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801037c2:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
801037c9:	00 
801037ca:	c7 44 24 04 95 89 10 	movl   $0x80108995,0x4(%esp)
801037d1:	80 
801037d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801037d5:	89 04 24             	mov    %eax,(%esp)
801037d8:	e8 70 1b 00 00       	call   8010534d <memcmp>
801037dd:	85 c0                	test   %eax,%eax
801037df:	74 07                	je     801037e8 <mpconfig+0x5f>
    return 0;
801037e1:	b8 00 00 00 00       	mov    $0x0,%eax
801037e6:	eb 4c                	jmp    80103834 <mpconfig+0xab>
  if(conf->version != 1 && conf->version != 4)
801037e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801037eb:	0f b6 40 06          	movzbl 0x6(%eax),%eax
801037ef:	3c 01                	cmp    $0x1,%al
801037f1:	74 12                	je     80103805 <mpconfig+0x7c>
801037f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801037f6:	0f b6 40 06          	movzbl 0x6(%eax),%eax
801037fa:	3c 04                	cmp    $0x4,%al
801037fc:	74 07                	je     80103805 <mpconfig+0x7c>
    return 0;
801037fe:	b8 00 00 00 00       	mov    $0x0,%eax
80103803:	eb 2f                	jmp    80103834 <mpconfig+0xab>
  if(sum((uchar*)conf, conf->length) != 0)
80103805:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103808:	0f b7 40 04          	movzwl 0x4(%eax),%eax
8010380c:	0f b7 c0             	movzwl %ax,%eax
8010380f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103813:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103816:	89 04 24             	mov    %eax,(%esp)
80103819:	e8 04 fe ff ff       	call   80103622 <sum>
8010381e:	84 c0                	test   %al,%al
80103820:	74 07                	je     80103829 <mpconfig+0xa0>
    return 0;
80103822:	b8 00 00 00 00       	mov    $0x0,%eax
80103827:	eb 0b                	jmp    80103834 <mpconfig+0xab>
  *pmp = mp;
80103829:	8b 45 08             	mov    0x8(%ebp),%eax
8010382c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010382f:	89 10                	mov    %edx,(%eax)
  return conf;
80103831:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103834:	c9                   	leave  
80103835:	c3                   	ret    

80103836 <mpinit>:

void
mpinit(void)
{
80103836:	55                   	push   %ebp
80103837:	89 e5                	mov    %esp,%ebp
80103839:	83 ec 38             	sub    $0x38,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
8010383c:	c7 05 64 b6 10 80 40 	movl   $0x8010f940,0x8010b664
80103843:	f9 10 80 
  if((conf = mpconfig(&mp)) == 0)
80103846:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103849:	89 04 24             	mov    %eax,(%esp)
8010384c:	e8 38 ff ff ff       	call   80103789 <mpconfig>
80103851:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103854:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103858:	75 05                	jne    8010385f <mpinit+0x29>
    return;
8010385a:	e9 9c 01 00 00       	jmp    801039fb <mpinit+0x1c5>
  ismp = 1;
8010385f:	c7 05 24 f9 10 80 01 	movl   $0x1,0x8010f924
80103866:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103869:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010386c:	8b 40 24             	mov    0x24(%eax),%eax
8010386f:	a3 9c f8 10 80       	mov    %eax,0x8010f89c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103874:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103877:	83 c0 2c             	add    $0x2c,%eax
8010387a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010387d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103880:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103884:	0f b7 d0             	movzwl %ax,%edx
80103887:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010388a:	01 d0                	add    %edx,%eax
8010388c:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010388f:	e9 f4 00 00 00       	jmp    80103988 <mpinit+0x152>
    switch(*p){
80103894:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103897:	0f b6 00             	movzbl (%eax),%eax
8010389a:	0f b6 c0             	movzbl %al,%eax
8010389d:	83 f8 04             	cmp    $0x4,%eax
801038a0:	0f 87 bf 00 00 00    	ja     80103965 <mpinit+0x12f>
801038a6:	8b 04 85 d8 89 10 80 	mov    -0x7fef7628(,%eax,4),%eax
801038ad:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
801038af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
801038b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801038b8:	0f b6 40 01          	movzbl 0x1(%eax),%eax
801038bc:	0f b6 d0             	movzbl %al,%edx
801038bf:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801038c4:	39 c2                	cmp    %eax,%edx
801038c6:	74 2d                	je     801038f5 <mpinit+0xbf>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
801038c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
801038cb:	0f b6 40 01          	movzbl 0x1(%eax),%eax
801038cf:	0f b6 d0             	movzbl %al,%edx
801038d2:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801038d7:	89 54 24 08          	mov    %edx,0x8(%esp)
801038db:	89 44 24 04          	mov    %eax,0x4(%esp)
801038df:	c7 04 24 9a 89 10 80 	movl   $0x8010899a,(%esp)
801038e6:	e8 b5 ca ff ff       	call   801003a0 <cprintf>
        ismp = 0;
801038eb:	c7 05 24 f9 10 80 00 	movl   $0x0,0x8010f924
801038f2:	00 00 00 
      }
      if(proc->flags & MPBOOT)
801038f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801038f8:	0f b6 40 03          	movzbl 0x3(%eax),%eax
801038fc:	0f b6 c0             	movzbl %al,%eax
801038ff:	83 e0 02             	and    $0x2,%eax
80103902:	85 c0                	test   %eax,%eax
80103904:	74 15                	je     8010391b <mpinit+0xe5>
        bcpu = &cpus[ncpu];
80103906:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
8010390b:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103911:	05 40 f9 10 80       	add    $0x8010f940,%eax
80103916:	a3 64 b6 10 80       	mov    %eax,0x8010b664
      cpus[ncpu].id = ncpu;
8010391b:	8b 15 20 ff 10 80    	mov    0x8010ff20,%edx
80103921:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
80103926:	69 d2 bc 00 00 00    	imul   $0xbc,%edx,%edx
8010392c:	81 c2 40 f9 10 80    	add    $0x8010f940,%edx
80103932:	88 02                	mov    %al,(%edx)
      ncpu++;
80103934:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
80103939:	83 c0 01             	add    $0x1,%eax
8010393c:	a3 20 ff 10 80       	mov    %eax,0x8010ff20
      p += sizeof(struct mpproc);
80103941:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103945:	eb 41                	jmp    80103988 <mpinit+0x152>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103947:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010394a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
8010394d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103950:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103954:	a2 20 f9 10 80       	mov    %al,0x8010f920
      p += sizeof(struct mpioapic);
80103959:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
8010395d:	eb 29                	jmp    80103988 <mpinit+0x152>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010395f:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103963:	eb 23                	jmp    80103988 <mpinit+0x152>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103965:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103968:	0f b6 00             	movzbl (%eax),%eax
8010396b:	0f b6 c0             	movzbl %al,%eax
8010396e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103972:	c7 04 24 b8 89 10 80 	movl   $0x801089b8,(%esp)
80103979:	e8 22 ca ff ff       	call   801003a0 <cprintf>
      ismp = 0;
8010397e:	c7 05 24 f9 10 80 00 	movl   $0x0,0x8010f924
80103985:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103988:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010398b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010398e:	0f 82 00 ff ff ff    	jb     80103894 <mpinit+0x5e>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103994:	a1 24 f9 10 80       	mov    0x8010f924,%eax
80103999:	85 c0                	test   %eax,%eax
8010399b:	75 1d                	jne    801039ba <mpinit+0x184>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
8010399d:	c7 05 20 ff 10 80 01 	movl   $0x1,0x8010ff20
801039a4:	00 00 00 
    lapic = 0;
801039a7:	c7 05 9c f8 10 80 00 	movl   $0x0,0x8010f89c
801039ae:	00 00 00 
    ioapicid = 0;
801039b1:	c6 05 20 f9 10 80 00 	movb   $0x0,0x8010f920
    return;
801039b8:	eb 41                	jmp    801039fb <mpinit+0x1c5>
  }

  if(mp->imcrp){
801039ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
801039bd:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
801039c1:	84 c0                	test   %al,%al
801039c3:	74 36                	je     801039fb <mpinit+0x1c5>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
801039c5:	c7 44 24 04 70 00 00 	movl   $0x70,0x4(%esp)
801039cc:	00 
801039cd:	c7 04 24 22 00 00 00 	movl   $0x22,(%esp)
801039d4:	e8 0d fc ff ff       	call   801035e6 <outb>
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801039d9:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
801039e0:	e8 e4 fb ff ff       	call   801035c9 <inb>
801039e5:	83 c8 01             	or     $0x1,%eax
801039e8:	0f b6 c0             	movzbl %al,%eax
801039eb:	89 44 24 04          	mov    %eax,0x4(%esp)
801039ef:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
801039f6:	e8 eb fb ff ff       	call   801035e6 <outb>
  }
}
801039fb:	c9                   	leave  
801039fc:	c3                   	ret    
801039fd:	66 90                	xchg   %ax,%ax
801039ff:	90                   	nop

80103a00 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	83 ec 08             	sub    $0x8,%esp
80103a06:	8b 55 08             	mov    0x8(%ebp),%edx
80103a09:	8b 45 0c             	mov    0xc(%ebp),%eax
80103a0c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103a10:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a13:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103a17:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103a1b:	ee                   	out    %al,(%dx)
}
80103a1c:	c9                   	leave  
80103a1d:	c3                   	ret    

80103a1e <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103a1e:	55                   	push   %ebp
80103a1f:	89 e5                	mov    %esp,%ebp
80103a21:	83 ec 0c             	sub    $0xc,%esp
80103a24:	8b 45 08             	mov    0x8(%ebp),%eax
80103a27:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103a2b:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103a2f:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
  outb(IO_PIC1+1, mask);
80103a35:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103a39:	0f b6 c0             	movzbl %al,%eax
80103a3c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a40:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103a47:	e8 b4 ff ff ff       	call   80103a00 <outb>
  outb(IO_PIC2+1, mask >> 8);
80103a4c:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103a50:	66 c1 e8 08          	shr    $0x8,%ax
80103a54:	0f b6 c0             	movzbl %al,%eax
80103a57:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a5b:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103a62:	e8 99 ff ff ff       	call   80103a00 <outb>
}
80103a67:	c9                   	leave  
80103a68:	c3                   	ret    

80103a69 <picenable>:

void
picenable(int irq)
{
80103a69:	55                   	push   %ebp
80103a6a:	89 e5                	mov    %esp,%ebp
80103a6c:	83 ec 04             	sub    $0x4,%esp
  picsetmask(irqmask & ~(1<<irq));
80103a6f:	8b 45 08             	mov    0x8(%ebp),%eax
80103a72:	ba 01 00 00 00       	mov    $0x1,%edx
80103a77:	89 c1                	mov    %eax,%ecx
80103a79:	d3 e2                	shl    %cl,%edx
80103a7b:	89 d0                	mov    %edx,%eax
80103a7d:	f7 d0                	not    %eax
80103a7f:	89 c2                	mov    %eax,%edx
80103a81:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103a88:	21 d0                	and    %edx,%eax
80103a8a:	0f b7 c0             	movzwl %ax,%eax
80103a8d:	89 04 24             	mov    %eax,(%esp)
80103a90:	e8 89 ff ff ff       	call   80103a1e <picsetmask>
}
80103a95:	c9                   	leave  
80103a96:	c3                   	ret    

80103a97 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103a97:	55                   	push   %ebp
80103a98:	89 e5                	mov    %esp,%ebp
80103a9a:	83 ec 08             	sub    $0x8,%esp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103a9d:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80103aa4:	00 
80103aa5:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103aac:	e8 4f ff ff ff       	call   80103a00 <outb>
  outb(IO_PIC2+1, 0xFF);
80103ab1:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80103ab8:	00 
80103ab9:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103ac0:	e8 3b ff ff ff       	call   80103a00 <outb>

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103ac5:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80103acc:	00 
80103acd:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103ad4:	e8 27 ff ff ff       	call   80103a00 <outb>

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103ad9:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
80103ae0:	00 
80103ae1:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103ae8:	e8 13 ff ff ff       	call   80103a00 <outb>

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103aed:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
80103af4:	00 
80103af5:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103afc:	e8 ff fe ff ff       	call   80103a00 <outb>
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103b01:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80103b08:	00 
80103b09:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103b10:	e8 eb fe ff ff       	call   80103a00 <outb>

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103b15:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80103b1c:	00 
80103b1d:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103b24:	e8 d7 fe ff ff       	call   80103a00 <outb>
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103b29:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
80103b30:	00 
80103b31:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103b38:	e8 c3 fe ff ff       	call   80103a00 <outb>
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103b3d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
80103b44:	00 
80103b45:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103b4c:	e8 af fe ff ff       	call   80103a00 <outb>
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103b51:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80103b58:	00 
80103b59:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103b60:	e8 9b fe ff ff       	call   80103a00 <outb>

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103b65:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
80103b6c:	00 
80103b6d:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103b74:	e8 87 fe ff ff       	call   80103a00 <outb>
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103b79:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80103b80:	00 
80103b81:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103b88:	e8 73 fe ff ff       	call   80103a00 <outb>

  outb(IO_PIC2, 0x68);             // OCW3
80103b8d:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
80103b94:	00 
80103b95:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103b9c:	e8 5f fe ff ff       	call   80103a00 <outb>
  outb(IO_PIC2, 0x0a);             // OCW3
80103ba1:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80103ba8:	00 
80103ba9:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103bb0:	e8 4b fe ff ff       	call   80103a00 <outb>

  if(irqmask != 0xFFFF)
80103bb5:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103bbc:	66 83 f8 ff          	cmp    $0xffff,%ax
80103bc0:	74 12                	je     80103bd4 <picinit+0x13d>
    picsetmask(irqmask);
80103bc2:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103bc9:	0f b7 c0             	movzwl %ax,%eax
80103bcc:	89 04 24             	mov    %eax,(%esp)
80103bcf:	e8 4a fe ff ff       	call   80103a1e <picsetmask>
}
80103bd4:	c9                   	leave  
80103bd5:	c3                   	ret    
80103bd6:	66 90                	xchg   %ax,%ax

80103bd8 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103bd8:	55                   	push   %ebp
80103bd9:	89 e5                	mov    %esp,%ebp
80103bdb:	83 ec 28             	sub    $0x28,%esp
  struct pipe *p;

  p = 0;
80103bde:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103be5:	8b 45 0c             	mov    0xc(%ebp),%eax
80103be8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103bee:	8b 45 0c             	mov    0xc(%ebp),%eax
80103bf1:	8b 10                	mov    (%eax),%edx
80103bf3:	8b 45 08             	mov    0x8(%ebp),%eax
80103bf6:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103bf8:	e8 23 d3 ff ff       	call   80100f20 <filealloc>
80103bfd:	8b 55 08             	mov    0x8(%ebp),%edx
80103c00:	89 02                	mov    %eax,(%edx)
80103c02:	8b 45 08             	mov    0x8(%ebp),%eax
80103c05:	8b 00                	mov    (%eax),%eax
80103c07:	85 c0                	test   %eax,%eax
80103c09:	0f 84 c8 00 00 00    	je     80103cd7 <pipealloc+0xff>
80103c0f:	e8 0c d3 ff ff       	call   80100f20 <filealloc>
80103c14:	8b 55 0c             	mov    0xc(%ebp),%edx
80103c17:	89 02                	mov    %eax,(%edx)
80103c19:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c1c:	8b 00                	mov    (%eax),%eax
80103c1e:	85 c0                	test   %eax,%eax
80103c20:	0f 84 b1 00 00 00    	je     80103cd7 <pipealloc+0xff>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103c26:	e8 b8 ee ff ff       	call   80102ae3 <kalloc>
80103c2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c2e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c32:	75 05                	jne    80103c39 <pipealloc+0x61>
    goto bad;
80103c34:	e9 9e 00 00 00       	jmp    80103cd7 <pipealloc+0xff>
  p->readopen = 1;
80103c39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c3c:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103c43:	00 00 00 
  p->writeopen = 1;
80103c46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c49:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103c50:	00 00 00 
  p->nwrite = 0;
80103c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c56:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103c5d:	00 00 00 
  p->nread = 0;
80103c60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c63:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103c6a:	00 00 00 
  initlock(&p->lock, "pipe");
80103c6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c70:	c7 44 24 04 ec 89 10 	movl   $0x801089ec,0x4(%esp)
80103c77:	80 
80103c78:	89 04 24             	mov    %eax,(%esp)
80103c7b:	e8 de 13 00 00       	call   8010505e <initlock>
  (*f0)->type = FD_PIPE;
80103c80:	8b 45 08             	mov    0x8(%ebp),%eax
80103c83:	8b 00                	mov    (%eax),%eax
80103c85:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103c8b:	8b 45 08             	mov    0x8(%ebp),%eax
80103c8e:	8b 00                	mov    (%eax),%eax
80103c90:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103c94:	8b 45 08             	mov    0x8(%ebp),%eax
80103c97:	8b 00                	mov    (%eax),%eax
80103c99:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103c9d:	8b 45 08             	mov    0x8(%ebp),%eax
80103ca0:	8b 00                	mov    (%eax),%eax
80103ca2:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103ca5:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103ca8:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cab:	8b 00                	mov    (%eax),%eax
80103cad:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103cb3:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cb6:	8b 00                	mov    (%eax),%eax
80103cb8:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103cbc:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cbf:	8b 00                	mov    (%eax),%eax
80103cc1:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103cc5:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cc8:	8b 00                	mov    (%eax),%eax
80103cca:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103ccd:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80103cd0:	b8 00 00 00 00       	mov    $0x0,%eax
80103cd5:	eb 42                	jmp    80103d19 <pipealloc+0x141>

//PAGEBREAK: 20
 bad:
  if(p)
80103cd7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103cdb:	74 0b                	je     80103ce8 <pipealloc+0x110>
    kfree((char*)p);
80103cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ce0:	89 04 24             	mov    %eax,(%esp)
80103ce3:	e8 62 ed ff ff       	call   80102a4a <kfree>
  if(*f0)
80103ce8:	8b 45 08             	mov    0x8(%ebp),%eax
80103ceb:	8b 00                	mov    (%eax),%eax
80103ced:	85 c0                	test   %eax,%eax
80103cef:	74 0d                	je     80103cfe <pipealloc+0x126>
    fileclose(*f0);
80103cf1:	8b 45 08             	mov    0x8(%ebp),%eax
80103cf4:	8b 00                	mov    (%eax),%eax
80103cf6:	89 04 24             	mov    %eax,(%esp)
80103cf9:	e8 ca d2 ff ff       	call   80100fc8 <fileclose>
  if(*f1)
80103cfe:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d01:	8b 00                	mov    (%eax),%eax
80103d03:	85 c0                	test   %eax,%eax
80103d05:	74 0d                	je     80103d14 <pipealloc+0x13c>
    fileclose(*f1);
80103d07:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d0a:	8b 00                	mov    (%eax),%eax
80103d0c:	89 04 24             	mov    %eax,(%esp)
80103d0f:	e8 b4 d2 ff ff       	call   80100fc8 <fileclose>
  return -1;
80103d14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103d19:	c9                   	leave  
80103d1a:	c3                   	ret    

80103d1b <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103d1b:	55                   	push   %ebp
80103d1c:	89 e5                	mov    %esp,%ebp
80103d1e:	83 ec 18             	sub    $0x18,%esp
  acquire(&p->lock);
80103d21:	8b 45 08             	mov    0x8(%ebp),%eax
80103d24:	89 04 24             	mov    %eax,(%esp)
80103d27:	e8 53 13 00 00       	call   8010507f <acquire>
  if(writable){
80103d2c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80103d30:	74 1f                	je     80103d51 <pipeclose+0x36>
    p->writeopen = 0;
80103d32:	8b 45 08             	mov    0x8(%ebp),%eax
80103d35:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80103d3c:	00 00 00 
    wakeup(&p->nread);
80103d3f:	8b 45 08             	mov    0x8(%ebp),%eax
80103d42:	05 34 02 00 00       	add    $0x234,%eax
80103d47:	89 04 24             	mov    %eax,(%esp)
80103d4a:	e8 03 11 00 00       	call   80104e52 <wakeup>
80103d4f:	eb 1d                	jmp    80103d6e <pipeclose+0x53>
  } else {
    p->readopen = 0;
80103d51:	8b 45 08             	mov    0x8(%ebp),%eax
80103d54:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80103d5b:	00 00 00 
    wakeup(&p->nwrite);
80103d5e:	8b 45 08             	mov    0x8(%ebp),%eax
80103d61:	05 38 02 00 00       	add    $0x238,%eax
80103d66:	89 04 24             	mov    %eax,(%esp)
80103d69:	e8 e4 10 00 00       	call   80104e52 <wakeup>
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103d6e:	8b 45 08             	mov    0x8(%ebp),%eax
80103d71:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103d77:	85 c0                	test   %eax,%eax
80103d79:	75 25                	jne    80103da0 <pipeclose+0x85>
80103d7b:	8b 45 08             	mov    0x8(%ebp),%eax
80103d7e:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103d84:	85 c0                	test   %eax,%eax
80103d86:	75 18                	jne    80103da0 <pipeclose+0x85>
    release(&p->lock);
80103d88:	8b 45 08             	mov    0x8(%ebp),%eax
80103d8b:	89 04 24             	mov    %eax,(%esp)
80103d8e:	e8 4e 13 00 00       	call   801050e1 <release>
    kfree((char*)p);
80103d93:	8b 45 08             	mov    0x8(%ebp),%eax
80103d96:	89 04 24             	mov    %eax,(%esp)
80103d99:	e8 ac ec ff ff       	call   80102a4a <kfree>
80103d9e:	eb 0b                	jmp    80103dab <pipeclose+0x90>
  } else
    release(&p->lock);
80103da0:	8b 45 08             	mov    0x8(%ebp),%eax
80103da3:	89 04 24             	mov    %eax,(%esp)
80103da6:	e8 36 13 00 00       	call   801050e1 <release>
}
80103dab:	c9                   	leave  
80103dac:	c3                   	ret    

80103dad <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103dad:	55                   	push   %ebp
80103dae:	89 e5                	mov    %esp,%ebp
80103db0:	83 ec 28             	sub    $0x28,%esp
  int i;

  acquire(&p->lock);
80103db3:	8b 45 08             	mov    0x8(%ebp),%eax
80103db6:	89 04 24             	mov    %eax,(%esp)
80103db9:	e8 c1 12 00 00       	call   8010507f <acquire>
  for(i = 0; i < n; i++){
80103dbe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103dc5:	e9 a6 00 00 00       	jmp    80103e70 <pipewrite+0xc3>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103dca:	eb 57                	jmp    80103e23 <pipewrite+0x76>
      if(p->readopen == 0 || proc->killed){
80103dcc:	8b 45 08             	mov    0x8(%ebp),%eax
80103dcf:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103dd5:	85 c0                	test   %eax,%eax
80103dd7:	74 0d                	je     80103de6 <pipewrite+0x39>
80103dd9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ddf:	8b 40 24             	mov    0x24(%eax),%eax
80103de2:	85 c0                	test   %eax,%eax
80103de4:	74 15                	je     80103dfb <pipewrite+0x4e>
        release(&p->lock);
80103de6:	8b 45 08             	mov    0x8(%ebp),%eax
80103de9:	89 04 24             	mov    %eax,(%esp)
80103dec:	e8 f0 12 00 00       	call   801050e1 <release>
        return -1;
80103df1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103df6:	e9 9f 00 00 00       	jmp    80103e9a <pipewrite+0xed>
      }
      wakeup(&p->nread);
80103dfb:	8b 45 08             	mov    0x8(%ebp),%eax
80103dfe:	05 34 02 00 00       	add    $0x234,%eax
80103e03:	89 04 24             	mov    %eax,(%esp)
80103e06:	e8 47 10 00 00       	call   80104e52 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103e0b:	8b 45 08             	mov    0x8(%ebp),%eax
80103e0e:	8b 55 08             	mov    0x8(%ebp),%edx
80103e11:	81 c2 38 02 00 00    	add    $0x238,%edx
80103e17:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e1b:	89 14 24             	mov    %edx,(%esp)
80103e1e:	e8 eb 0e 00 00       	call   80104d0e <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103e23:	8b 45 08             	mov    0x8(%ebp),%eax
80103e26:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80103e2c:	8b 45 08             	mov    0x8(%ebp),%eax
80103e2f:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80103e35:	05 00 02 00 00       	add    $0x200,%eax
80103e3a:	39 c2                	cmp    %eax,%edx
80103e3c:	74 8e                	je     80103dcc <pipewrite+0x1f>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103e3e:	8b 45 08             	mov    0x8(%ebp),%eax
80103e41:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103e47:	8d 48 01             	lea    0x1(%eax),%ecx
80103e4a:	8b 55 08             	mov    0x8(%ebp),%edx
80103e4d:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
80103e53:	25 ff 01 00 00       	and    $0x1ff,%eax
80103e58:	89 c1                	mov    %eax,%ecx
80103e5a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103e5d:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e60:	01 d0                	add    %edx,%eax
80103e62:	0f b6 10             	movzbl (%eax),%edx
80103e65:	8b 45 08             	mov    0x8(%ebp),%eax
80103e68:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103e6c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103e70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e73:	3b 45 10             	cmp    0x10(%ebp),%eax
80103e76:	0f 8c 4e ff ff ff    	jl     80103dca <pipewrite+0x1d>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103e7c:	8b 45 08             	mov    0x8(%ebp),%eax
80103e7f:	05 34 02 00 00       	add    $0x234,%eax
80103e84:	89 04 24             	mov    %eax,(%esp)
80103e87:	e8 c6 0f 00 00       	call   80104e52 <wakeup>
  release(&p->lock);
80103e8c:	8b 45 08             	mov    0x8(%ebp),%eax
80103e8f:	89 04 24             	mov    %eax,(%esp)
80103e92:	e8 4a 12 00 00       	call   801050e1 <release>
  return n;
80103e97:	8b 45 10             	mov    0x10(%ebp),%eax
}
80103e9a:	c9                   	leave  
80103e9b:	c3                   	ret    

80103e9c <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103e9c:	55                   	push   %ebp
80103e9d:	89 e5                	mov    %esp,%ebp
80103e9f:	53                   	push   %ebx
80103ea0:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
80103ea3:	8b 45 08             	mov    0x8(%ebp),%eax
80103ea6:	89 04 24             	mov    %eax,(%esp)
80103ea9:	e8 d1 11 00 00       	call   8010507f <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103eae:	eb 3a                	jmp    80103eea <piperead+0x4e>
    if(proc->killed){
80103eb0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103eb6:	8b 40 24             	mov    0x24(%eax),%eax
80103eb9:	85 c0                	test   %eax,%eax
80103ebb:	74 15                	je     80103ed2 <piperead+0x36>
      release(&p->lock);
80103ebd:	8b 45 08             	mov    0x8(%ebp),%eax
80103ec0:	89 04 24             	mov    %eax,(%esp)
80103ec3:	e8 19 12 00 00       	call   801050e1 <release>
      return -1;
80103ec8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ecd:	e9 b5 00 00 00       	jmp    80103f87 <piperead+0xeb>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103ed2:	8b 45 08             	mov    0x8(%ebp),%eax
80103ed5:	8b 55 08             	mov    0x8(%ebp),%edx
80103ed8:	81 c2 34 02 00 00    	add    $0x234,%edx
80103ede:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ee2:	89 14 24             	mov    %edx,(%esp)
80103ee5:	e8 24 0e 00 00       	call   80104d0e <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103eea:	8b 45 08             	mov    0x8(%ebp),%eax
80103eed:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80103ef3:	8b 45 08             	mov    0x8(%ebp),%eax
80103ef6:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103efc:	39 c2                	cmp    %eax,%edx
80103efe:	75 0d                	jne    80103f0d <piperead+0x71>
80103f00:	8b 45 08             	mov    0x8(%ebp),%eax
80103f03:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103f09:	85 c0                	test   %eax,%eax
80103f0b:	75 a3                	jne    80103eb0 <piperead+0x14>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103f0d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103f14:	eb 4b                	jmp    80103f61 <piperead+0xc5>
    if(p->nread == p->nwrite)
80103f16:	8b 45 08             	mov    0x8(%ebp),%eax
80103f19:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80103f1f:	8b 45 08             	mov    0x8(%ebp),%eax
80103f22:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103f28:	39 c2                	cmp    %eax,%edx
80103f2a:	75 02                	jne    80103f2e <piperead+0x92>
      break;
80103f2c:	eb 3b                	jmp    80103f69 <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103f2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103f31:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f34:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80103f37:	8b 45 08             	mov    0x8(%ebp),%eax
80103f3a:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80103f40:	8d 48 01             	lea    0x1(%eax),%ecx
80103f43:	8b 55 08             	mov    0x8(%ebp),%edx
80103f46:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
80103f4c:	25 ff 01 00 00       	and    $0x1ff,%eax
80103f51:	89 c2                	mov    %eax,%edx
80103f53:	8b 45 08             	mov    0x8(%ebp),%eax
80103f56:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
80103f5b:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103f5d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103f61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f64:	3b 45 10             	cmp    0x10(%ebp),%eax
80103f67:	7c ad                	jl     80103f16 <piperead+0x7a>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103f69:	8b 45 08             	mov    0x8(%ebp),%eax
80103f6c:	05 38 02 00 00       	add    $0x238,%eax
80103f71:	89 04 24             	mov    %eax,(%esp)
80103f74:	e8 d9 0e 00 00       	call   80104e52 <wakeup>
  release(&p->lock);
80103f79:	8b 45 08             	mov    0x8(%ebp),%eax
80103f7c:	89 04 24             	mov    %eax,(%esp)
80103f7f:	e8 5d 11 00 00       	call   801050e1 <release>
  return i;
80103f84:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103f87:	83 c4 24             	add    $0x24,%esp
80103f8a:	5b                   	pop    %ebx
80103f8b:	5d                   	pop    %ebp
80103f8c:	c3                   	ret    
80103f8d:	66 90                	xchg   %ax,%ax
80103f8f:	90                   	nop

80103f90 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80103f90:	55                   	push   %ebp
80103f91:	89 e5                	mov    %esp,%ebp
80103f93:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103f96:	9c                   	pushf  
80103f97:	58                   	pop    %eax
80103f98:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80103f9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103f9e:	c9                   	leave  
80103f9f:	c3                   	ret    

80103fa0 <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
80103fa0:	55                   	push   %ebp
80103fa1:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80103fa3:	fb                   	sti    
}
80103fa4:	5d                   	pop    %ebp
80103fa5:	c3                   	ret    

80103fa6 <memcop>:

static void wakeup1(void *chan);

    void*
memcop(void *dst, void *src, uint n)
{
80103fa6:	55                   	push   %ebp
80103fa7:	89 e5                	mov    %esp,%ebp
80103fa9:	83 ec 10             	sub    $0x10,%esp
    const char *s;
    char *d;

    s = src;
80103fac:	8b 45 0c             	mov    0xc(%ebp),%eax
80103faf:	89 45 fc             	mov    %eax,-0x4(%ebp)
    d = dst;
80103fb2:	8b 45 08             	mov    0x8(%ebp),%eax
80103fb5:	89 45 f8             	mov    %eax,-0x8(%ebp)
    if(s < d && s + n > d){
80103fb8:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103fbb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80103fbe:	73 3d                	jae    80103ffd <memcop+0x57>
80103fc0:	8b 45 10             	mov    0x10(%ebp),%eax
80103fc3:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103fc6:	01 d0                	add    %edx,%eax
80103fc8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80103fcb:	76 30                	jbe    80103ffd <memcop+0x57>
        s += n;
80103fcd:	8b 45 10             	mov    0x10(%ebp),%eax
80103fd0:	01 45 fc             	add    %eax,-0x4(%ebp)
        d += n;
80103fd3:	8b 45 10             	mov    0x10(%ebp),%eax
80103fd6:	01 45 f8             	add    %eax,-0x8(%ebp)
        while(n-- > 0)
80103fd9:	eb 13                	jmp    80103fee <memcop+0x48>
            *--d = *--s;
80103fdb:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80103fdf:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80103fe3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103fe6:	0f b6 10             	movzbl (%eax),%edx
80103fe9:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103fec:	88 10                	mov    %dl,(%eax)
    s = src;
    d = dst;
    if(s < d && s + n > d){
        s += n;
        d += n;
        while(n-- > 0)
80103fee:	8b 45 10             	mov    0x10(%ebp),%eax
80103ff1:	8d 50 ff             	lea    -0x1(%eax),%edx
80103ff4:	89 55 10             	mov    %edx,0x10(%ebp)
80103ff7:	85 c0                	test   %eax,%eax
80103ff9:	75 e0                	jne    80103fdb <memcop+0x35>
    const char *s;
    char *d;

    s = src;
    d = dst;
    if(s < d && s + n > d){
80103ffb:	eb 26                	jmp    80104023 <memcop+0x7d>
        s += n;
        d += n;
        while(n-- > 0)
            *--d = *--s;
    } else
        while(n-- > 0)
80103ffd:	eb 17                	jmp    80104016 <memcop+0x70>
            *d++ = *s++;
80103fff:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104002:	8d 50 01             	lea    0x1(%eax),%edx
80104005:	89 55 f8             	mov    %edx,-0x8(%ebp)
80104008:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010400b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010400e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
80104011:	0f b6 12             	movzbl (%edx),%edx
80104014:	88 10                	mov    %dl,(%eax)
        s += n;
        d += n;
        while(n-- > 0)
            *--d = *--s;
    } else
        while(n-- > 0)
80104016:	8b 45 10             	mov    0x10(%ebp),%eax
80104019:	8d 50 ff             	lea    -0x1(%eax),%edx
8010401c:	89 55 10             	mov    %edx,0x10(%ebp)
8010401f:	85 c0                	test   %eax,%eax
80104021:	75 dc                	jne    80103fff <memcop+0x59>
            *d++ = *s++;

    return dst;
80104023:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104026:	c9                   	leave  
80104027:	c3                   	ret    

80104028 <pinit>:


    void
pinit(void)
{
80104028:	55                   	push   %ebp
80104029:	89 e5                	mov    %esp,%ebp
8010402b:	83 ec 18             	sub    $0x18,%esp
    initlock(&ptable.lock, "ptable");
8010402e:	c7 44 24 04 f4 89 10 	movl   $0x801089f4,0x4(%esp)
80104035:	80 
80104036:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
8010403d:	e8 1c 10 00 00       	call   8010505e <initlock>
    initlock(&tylock, "yeildlock");
80104042:	c7 44 24 04 fb 89 10 	movl   $0x801089fb,0x4(%esp)
80104049:	80 
8010404a:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104051:	e8 08 10 00 00       	call   8010505e <initlock>
}
80104056:	c9                   	leave  
80104057:	c3                   	ret    

80104058 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
    static struct proc*
allocproc(void)
{
80104058:	55                   	push   %ebp
80104059:	89 e5                	mov    %esp,%ebp
8010405b:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    char *sp;

    acquire(&ptable.lock);
8010405e:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104065:	e8 15 10 00 00       	call   8010507f <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010406a:	c7 45 f4 b4 ff 10 80 	movl   $0x8010ffb4,-0xc(%ebp)
80104071:	eb 53                	jmp    801040c6 <allocproc+0x6e>
        if(p->state == UNUSED)
80104073:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104076:	8b 40 0c             	mov    0xc(%eax),%eax
80104079:	85 c0                	test   %eax,%eax
8010407b:	75 42                	jne    801040bf <allocproc+0x67>
            goto found;
8010407d:	90                   	nop
    release(&ptable.lock);
    return 0;

found:
    p->state = EMBRYO;
8010407e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104081:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
    p->pid = nextpid++;
80104088:	a1 04 b0 10 80       	mov    0x8010b004,%eax
8010408d:	8d 50 01             	lea    0x1(%eax),%edx
80104090:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80104096:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104099:	89 42 10             	mov    %eax,0x10(%edx)
    release(&ptable.lock);
8010409c:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
801040a3:	e8 39 10 00 00       	call   801050e1 <release>

    // Allocate kernel stack.
    if((p->kstack = kalloc()) == 0){
801040a8:	e8 36 ea ff ff       	call   80102ae3 <kalloc>
801040ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040b0:	89 42 08             	mov    %eax,0x8(%edx)
801040b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040b6:	8b 40 08             	mov    0x8(%eax),%eax
801040b9:	85 c0                	test   %eax,%eax
801040bb:	75 36                	jne    801040f3 <allocproc+0x9b>
801040bd:	eb 23                	jmp    801040e2 <allocproc+0x8a>
{
    struct proc *p;
    char *sp;

    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040bf:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
801040c6:	81 7d f4 b4 21 11 80 	cmpl   $0x801121b4,-0xc(%ebp)
801040cd:	72 a4                	jb     80104073 <allocproc+0x1b>
        if(p->state == UNUSED)
            goto found;
    release(&ptable.lock);
801040cf:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
801040d6:	e8 06 10 00 00       	call   801050e1 <release>
    return 0;
801040db:	b8 00 00 00 00       	mov    $0x0,%eax
801040e0:	eb 76                	jmp    80104158 <allocproc+0x100>
    p->pid = nextpid++;
    release(&ptable.lock);

    // Allocate kernel stack.
    if((p->kstack = kalloc()) == 0){
        p->state = UNUSED;
801040e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040e5:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        return 0;
801040ec:	b8 00 00 00 00       	mov    $0x0,%eax
801040f1:	eb 65                	jmp    80104158 <allocproc+0x100>
    }
    sp = p->kstack + KSTACKSIZE;
801040f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040f6:	8b 40 08             	mov    0x8(%eax),%eax
801040f9:	05 00 10 00 00       	add    $0x1000,%eax
801040fe:	89 45 f0             	mov    %eax,-0x10(%ebp)

    // Leave room for trap frame.
    sp -= sizeof *p->tf;
80104101:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
    p->tf = (struct trapframe*)sp;
80104105:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104108:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010410b:	89 50 18             	mov    %edx,0x18(%eax)

    // Set up new context to start executing at forkret,
    // which returns to trapret.
    sp -= 4;
8010410e:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
    *(uint*)sp = (uint)trapret;
80104112:	ba c0 67 10 80       	mov    $0x801067c0,%edx
80104117:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010411a:	89 10                	mov    %edx,(%eax)

    sp -= sizeof *p->context;
8010411c:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
    p->context = (struct context*)sp;
80104120:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104123:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104126:	89 50 1c             	mov    %edx,0x1c(%eax)
    memset(p->context, 0, sizeof *p->context);
80104129:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010412c:	8b 40 1c             	mov    0x1c(%eax),%eax
8010412f:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104136:	00 
80104137:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010413e:	00 
8010413f:	89 04 24             	mov    %eax,(%esp)
80104142:	e8 8f 11 00 00       	call   801052d6 <memset>
    p->context->eip = (uint)forkret;
80104147:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010414a:	8b 40 1c             	mov    0x1c(%eax),%eax
8010414d:	ba e2 4c 10 80       	mov    $0x80104ce2,%edx
80104152:	89 50 10             	mov    %edx,0x10(%eax)

    return p;
80104155:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104158:	c9                   	leave  
80104159:	c3                   	ret    

8010415a <userinit>:

//PAGEBREAK: 32
// Set up first user process.
    void
userinit(void)
{
8010415a:	55                   	push   %ebp
8010415b:	89 e5                	mov    %esp,%ebp
8010415d:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    extern char _binary_initcode_start[], _binary_initcode_size[];

    p = allocproc();
80104160:	e8 f3 fe ff ff       	call   80104058 <allocproc>
80104165:	89 45 f4             	mov    %eax,-0xc(%ebp)
    initproc = p;
80104168:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010416b:	a3 68 b6 10 80       	mov    %eax,0x8010b668
    if((p->pgdir = setupkvm()) == 0)
80104170:	e8 48 3d 00 00       	call   80107ebd <setupkvm>
80104175:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104178:	89 42 04             	mov    %eax,0x4(%edx)
8010417b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010417e:	8b 40 04             	mov    0x4(%eax),%eax
80104181:	85 c0                	test   %eax,%eax
80104183:	75 0c                	jne    80104191 <userinit+0x37>
        panic("userinit: out of memory?");
80104185:	c7 04 24 05 8a 10 80 	movl   $0x80108a05,(%esp)
8010418c:	e8 a9 c3 ff ff       	call   8010053a <panic>
    inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104191:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104196:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104199:	8b 40 04             	mov    0x4(%eax),%eax
8010419c:	89 54 24 08          	mov    %edx,0x8(%esp)
801041a0:	c7 44 24 04 00 b5 10 	movl   $0x8010b500,0x4(%esp)
801041a7:	80 
801041a8:	89 04 24             	mov    %eax,(%esp)
801041ab:	e8 65 3f 00 00       	call   80108115 <inituvm>
    p->sz = PGSIZE;
801041b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041b3:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
    memset(p->tf, 0, sizeof(*p->tf));
801041b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041bc:	8b 40 18             	mov    0x18(%eax),%eax
801041bf:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
801041c6:	00 
801041c7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801041ce:	00 
801041cf:	89 04 24             	mov    %eax,(%esp)
801041d2:	e8 ff 10 00 00       	call   801052d6 <memset>
    p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801041d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041da:	8b 40 18             	mov    0x18(%eax),%eax
801041dd:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
    p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801041e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041e6:	8b 40 18             	mov    0x18(%eax),%eax
801041e9:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
    p->tf->es = p->tf->ds;
801041ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041f2:	8b 40 18             	mov    0x18(%eax),%eax
801041f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041f8:	8b 52 18             	mov    0x18(%edx),%edx
801041fb:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801041ff:	66 89 50 28          	mov    %dx,0x28(%eax)
    p->tf->ss = p->tf->ds;
80104203:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104206:	8b 40 18             	mov    0x18(%eax),%eax
80104209:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010420c:	8b 52 18             	mov    0x18(%edx),%edx
8010420f:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104213:	66 89 50 48          	mov    %dx,0x48(%eax)
    p->tf->eflags = FL_IF;
80104217:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010421a:	8b 40 18             	mov    0x18(%eax),%eax
8010421d:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
    p->tf->esp = PGSIZE;
80104224:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104227:	8b 40 18             	mov    0x18(%eax),%eax
8010422a:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
    p->tf->eip = 0;  // beginning of initcode.S
80104231:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104234:	8b 40 18             	mov    0x18(%eax),%eax
80104237:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

    safestrcpy(p->name, "initcode", sizeof(p->name));
8010423e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104241:	83 c0 6c             	add    $0x6c,%eax
80104244:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
8010424b:	00 
8010424c:	c7 44 24 04 1e 8a 10 	movl   $0x80108a1e,0x4(%esp)
80104253:	80 
80104254:	89 04 24             	mov    %eax,(%esp)
80104257:	e8 9a 12 00 00       	call   801054f6 <safestrcpy>
    p->cwd = namei("/");
8010425c:	c7 04 24 27 8a 10 80 	movl   $0x80108a27,(%esp)
80104263:	e8 99 e1 ff ff       	call   80102401 <namei>
80104268:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010426b:	89 42 68             	mov    %eax,0x68(%edx)

    p->state = RUNNABLE;
8010426e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104271:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
80104278:	c9                   	leave  
80104279:	c3                   	ret    

8010427a <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
    int
growproc(int n)
{
8010427a:	55                   	push   %ebp
8010427b:	89 e5                	mov    %esp,%ebp
8010427d:	83 ec 28             	sub    $0x28,%esp
    uint sz;

    sz = proc->sz;
80104280:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104286:	8b 00                	mov    (%eax),%eax
80104288:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(n > 0){
8010428b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010428f:	7e 34                	jle    801042c5 <growproc+0x4b>
        if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104291:	8b 55 08             	mov    0x8(%ebp),%edx
80104294:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104297:	01 c2                	add    %eax,%edx
80104299:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010429f:	8b 40 04             	mov    0x4(%eax),%eax
801042a2:	89 54 24 08          	mov    %edx,0x8(%esp)
801042a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042a9:	89 54 24 04          	mov    %edx,0x4(%esp)
801042ad:	89 04 24             	mov    %eax,(%esp)
801042b0:	e8 d6 3f 00 00       	call   8010828b <allocuvm>
801042b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801042b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801042bc:	75 41                	jne    801042ff <growproc+0x85>
            return -1;
801042be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042c3:	eb 58                	jmp    8010431d <growproc+0xa3>
    } else if(n < 0){
801042c5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801042c9:	79 34                	jns    801042ff <growproc+0x85>
        if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
801042cb:	8b 55 08             	mov    0x8(%ebp),%edx
801042ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042d1:	01 c2                	add    %eax,%edx
801042d3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042d9:	8b 40 04             	mov    0x4(%eax),%eax
801042dc:	89 54 24 08          	mov    %edx,0x8(%esp)
801042e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042e3:	89 54 24 04          	mov    %edx,0x4(%esp)
801042e7:	89 04 24             	mov    %eax,(%esp)
801042ea:	e8 76 40 00 00       	call   80108365 <deallocuvm>
801042ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
801042f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801042f6:	75 07                	jne    801042ff <growproc+0x85>
            return -1;
801042f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042fd:	eb 1e                	jmp    8010431d <growproc+0xa3>
    }
    proc->sz = sz;
801042ff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104305:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104308:	89 10                	mov    %edx,(%eax)
    switchuvm(proc);
8010430a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104310:	89 04 24             	mov    %eax,(%esp)
80104313:	e8 96 3c 00 00       	call   80107fae <switchuvm>
    return 0;
80104318:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010431d:	c9                   	leave  
8010431e:	c3                   	ret    

8010431f <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
    int
fork(void)
{
8010431f:	55                   	push   %ebp
80104320:	89 e5                	mov    %esp,%ebp
80104322:	57                   	push   %edi
80104323:	56                   	push   %esi
80104324:	53                   	push   %ebx
80104325:	83 ec 2c             	sub    $0x2c,%esp
    int i, pid;
    struct proc *np;

    // Allocate process.
    if((np = allocproc()) == 0)
80104328:	e8 2b fd ff ff       	call   80104058 <allocproc>
8010432d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104330:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80104334:	75 0a                	jne    80104340 <fork+0x21>
        return -1;
80104336:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010433b:	e9 47 01 00 00       	jmp    80104487 <fork+0x168>

    // Copy process state from p.
    if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80104340:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104346:	8b 10                	mov    (%eax),%edx
80104348:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010434e:	8b 40 04             	mov    0x4(%eax),%eax
80104351:	89 54 24 04          	mov    %edx,0x4(%esp)
80104355:	89 04 24             	mov    %eax,(%esp)
80104358:	e8 a4 41 00 00       	call   80108501 <copyuvm>
8010435d:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104360:	89 42 04             	mov    %eax,0x4(%edx)
80104363:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104366:	8b 40 04             	mov    0x4(%eax),%eax
80104369:	85 c0                	test   %eax,%eax
8010436b:	75 2c                	jne    80104399 <fork+0x7a>
        kfree(np->kstack);
8010436d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104370:	8b 40 08             	mov    0x8(%eax),%eax
80104373:	89 04 24             	mov    %eax,(%esp)
80104376:	e8 cf e6 ff ff       	call   80102a4a <kfree>
        np->kstack = 0;
8010437b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010437e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        np->state = UNUSED;
80104385:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104388:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        return -1;
8010438f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104394:	e9 ee 00 00 00       	jmp    80104487 <fork+0x168>
    }
    np->sz = proc->sz;
80104399:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010439f:	8b 10                	mov    (%eax),%edx
801043a1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801043a4:	89 10                	mov    %edx,(%eax)
    np->parent = proc;
801043a6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801043ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
801043b0:	89 50 14             	mov    %edx,0x14(%eax)
    *np->tf = *proc->tf;
801043b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801043b6:	8b 50 18             	mov    0x18(%eax),%edx
801043b9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043bf:	8b 40 18             	mov    0x18(%eax),%eax
801043c2:	89 c3                	mov    %eax,%ebx
801043c4:	b8 13 00 00 00       	mov    $0x13,%eax
801043c9:	89 d7                	mov    %edx,%edi
801043cb:	89 de                	mov    %ebx,%esi
801043cd:	89 c1                	mov    %eax,%ecx
801043cf:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    np->isthread = 0;
801043d1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801043d4:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801043db:	00 00 00 

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;
801043de:	8b 45 e0             	mov    -0x20(%ebp),%eax
801043e1:	8b 40 18             	mov    0x18(%eax),%eax
801043e4:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

    for(i = 0; i < NOFILE; i++)
801043eb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801043f2:	eb 3d                	jmp    80104431 <fork+0x112>
        if(proc->ofile[i])
801043f4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801043fd:	83 c2 08             	add    $0x8,%edx
80104400:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104404:	85 c0                	test   %eax,%eax
80104406:	74 25                	je     8010442d <fork+0x10e>
            np->ofile[i] = filedup(proc->ofile[i]);
80104408:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010440e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104411:	83 c2 08             	add    $0x8,%edx
80104414:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104418:	89 04 24             	mov    %eax,(%esp)
8010441b:	e8 60 cb ff ff       	call   80100f80 <filedup>
80104420:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104423:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104426:	83 c1 08             	add    $0x8,%ecx
80104429:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
    np->isthread = 0;

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;

    for(i = 0; i < NOFILE; i++)
8010442d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104431:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104435:	7e bd                	jle    801043f4 <fork+0xd5>
        if(proc->ofile[i])
            np->ofile[i] = filedup(proc->ofile[i]);
    np->cwd = idup(proc->cwd);
80104437:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010443d:	8b 40 68             	mov    0x68(%eax),%eax
80104440:	89 04 24             	mov    %eax,(%esp)
80104443:	e8 dc d3 ff ff       	call   80101824 <idup>
80104448:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010444b:	89 42 68             	mov    %eax,0x68(%edx)

    pid = np->pid;
8010444e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104451:	8b 40 10             	mov    0x10(%eax),%eax
80104454:	89 45 dc             	mov    %eax,-0x24(%ebp)
    np->state = RUNNABLE;
80104457:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010445a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
    safestrcpy(np->name, proc->name, sizeof(proc->name));
80104461:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104467:	8d 50 6c             	lea    0x6c(%eax),%edx
8010446a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010446d:	83 c0 6c             	add    $0x6c,%eax
80104470:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104477:	00 
80104478:	89 54 24 04          	mov    %edx,0x4(%esp)
8010447c:	89 04 24             	mov    %eax,(%esp)
8010447f:	e8 72 10 00 00       	call   801054f6 <safestrcpy>
    return pid;
80104484:	8b 45 dc             	mov    -0x24(%ebp),%eax

}
80104487:	83 c4 2c             	add    $0x2c,%esp
8010448a:	5b                   	pop    %ebx
8010448b:	5e                   	pop    %esi
8010448c:	5f                   	pop    %edi
8010448d:	5d                   	pop    %ebp
8010448e:	c3                   	ret    

8010448f <clone>:

//creat a new process but used parent pgdir. 
int clone(int stack, int size, int routine, int arg){ 
8010448f:	55                   	push   %ebp
80104490:	89 e5                	mov    %esp,%ebp
80104492:	57                   	push   %edi
80104493:	56                   	push   %esi
80104494:	53                   	push   %ebx
80104495:	81 ec bc 00 00 00    	sub    $0xbc,%esp
    int i, pid;
    struct proc *np;

    //cprintf("in clone\n");
    // Allocate process.
    if((np = allocproc()) == 0)
8010449b:	e8 b8 fb ff ff       	call   80104058 <allocproc>
801044a0:	89 45 dc             	mov    %eax,-0x24(%ebp)
801044a3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
801044a7:	75 0a                	jne    801044b3 <clone+0x24>
        return -1;
801044a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801044ae:	e9 f4 01 00 00       	jmp    801046a7 <clone+0x218>
    if((stack % PGSIZE) != 0 || stack == 0 || routine == 0)
801044b3:	8b 45 08             	mov    0x8(%ebp),%eax
801044b6:	25 ff 0f 00 00       	and    $0xfff,%eax
801044bb:	85 c0                	test   %eax,%eax
801044bd:	75 0c                	jne    801044cb <clone+0x3c>
801044bf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801044c3:	74 06                	je     801044cb <clone+0x3c>
801044c5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801044c9:	75 0a                	jne    801044d5 <clone+0x46>
        return -1;
801044cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801044d0:	e9 d2 01 00 00       	jmp    801046a7 <clone+0x218>

    np->pgdir = proc->pgdir;
801044d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044db:	8b 50 04             	mov    0x4(%eax),%edx
801044de:	8b 45 dc             	mov    -0x24(%ebp),%eax
801044e1:	89 50 04             	mov    %edx,0x4(%eax)
    np->sz = proc->sz;
801044e4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044ea:	8b 10                	mov    (%eax),%edx
801044ec:	8b 45 dc             	mov    -0x24(%ebp),%eax
801044ef:	89 10                	mov    %edx,(%eax)
    np->parent = proc;
801044f1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801044f8:	8b 45 dc             	mov    -0x24(%ebp),%eax
801044fb:	89 50 14             	mov    %edx,0x14(%eax)
    *np->tf = *proc->tf;
801044fe:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104501:	8b 50 18             	mov    0x18(%eax),%edx
80104504:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010450a:	8b 40 18             	mov    0x18(%eax),%eax
8010450d:	89 c3                	mov    %eax,%ebx
8010450f:	b8 13 00 00 00       	mov    $0x13,%eax
80104514:	89 d7                	mov    %edx,%edi
80104516:	89 de                	mov    %ebx,%esi
80104518:	89 c1                	mov    %eax,%ecx
8010451a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    np->isthread = 1;
8010451c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010451f:	c7 80 80 00 00 00 01 	movl   $0x1,0x80(%eax)
80104526:	00 00 00 
    pid = np->pid;
80104529:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010452c:	8b 40 10             	mov    0x10(%eax),%eax
8010452f:	89 45 d8             	mov    %eax,-0x28(%ebp)

    struct proc *pp;
    pp = proc;
80104532:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104538:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(pp->isthread == 1){
8010453b:	eb 09                	jmp    80104546 <clone+0xb7>
        pp = pp->parent;
8010453d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104540:	8b 40 14             	mov    0x14(%eax),%eax
80104543:	89 45 e0             	mov    %eax,-0x20(%ebp)
    np->isthread = 1;
    pid = np->pid;

    struct proc *pp;
    pp = proc;
    while(pp->isthread == 1){
80104546:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104549:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
8010454f:	83 f8 01             	cmp    $0x1,%eax
80104552:	74 e9                	je     8010453d <clone+0xae>
        pp = pp->parent;
    }
    np->parent = pp;
80104554:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104557:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010455a:	89 50 14             	mov    %edx,0x14(%eax)
    //need to be modified as point to the same address
    //*np->ofile = *proc->ofile;
    for(i = 0; i < NOFILE; i++)
8010455d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104564:	eb 3d                	jmp    801045a3 <clone+0x114>
        if(proc->ofile[i])
80104566:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010456c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010456f:	83 c2 08             	add    $0x8,%edx
80104572:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104576:	85 c0                	test   %eax,%eax
80104578:	74 25                	je     8010459f <clone+0x110>
            np->ofile[i] = filedup(proc->ofile[i]);
8010457a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104580:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104583:	83 c2 08             	add    $0x8,%edx
80104586:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010458a:	89 04 24             	mov    %eax,(%esp)
8010458d:	e8 ee c9 ff ff       	call   80100f80 <filedup>
80104592:	8b 55 dc             	mov    -0x24(%ebp),%edx
80104595:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104598:	83 c1 08             	add    $0x8,%ecx
8010459b:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
        pp = pp->parent;
    }
    np->parent = pp;
    //need to be modified as point to the same address
    //*np->ofile = *proc->ofile;
    for(i = 0; i < NOFILE; i++)
8010459f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801045a3:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
801045a7:	7e bd                	jle    80104566 <clone+0xd7>
        if(proc->ofile[i])
            np->ofile[i] = filedup(proc->ofile[i]);

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;
801045a9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801045ac:	8b 40 18             	mov    0x18(%eax),%eax
801045af:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

   
    uint ustack[MAXARG];
    uint sp = stack + PGSIZE;
801045b6:	8b 45 08             	mov    0x8(%ebp),%eax
801045b9:	05 00 10 00 00       	add    $0x1000,%eax
801045be:	89 45 d4             	mov    %eax,-0x2c(%ebp)
//


//modify here <<<<<

    np->tf->ebp = sp;
801045c1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801045c4:	8b 40 18             	mov    0x18(%eax),%eax
801045c7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801045ca:	89 50 08             	mov    %edx,0x8(%eax)
    ustack[0] = 0xffffffff;
801045cd:	c7 85 54 ff ff ff ff 	movl   $0xffffffff,-0xac(%ebp)
801045d4:	ff ff ff 
    ustack[1] = arg;
801045d7:	8b 45 14             	mov    0x14(%ebp),%eax
801045da:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
    sp -= 8;
801045e0:	83 6d d4 08          	subl   $0x8,-0x2c(%ebp)
    if(copyout(np->pgdir,sp,ustack,8)<0){
801045e4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801045e7:	8b 40 04             	mov    0x4(%eax),%eax
801045ea:	c7 44 24 0c 08 00 00 	movl   $0x8,0xc(%esp)
801045f1:	00 
801045f2:	8d 95 54 ff ff ff    	lea    -0xac(%ebp),%edx
801045f8:	89 54 24 08          	mov    %edx,0x8(%esp)
801045fc:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801045ff:	89 54 24 04          	mov    %edx,0x4(%esp)
80104603:	89 04 24             	mov    %eax,(%esp)
80104606:	e8 75 40 00 00       	call   80108680 <copyout>
8010460b:	85 c0                	test   %eax,%eax
8010460d:	79 16                	jns    80104625 <clone+0x196>
        cprintf("push arg fails\n");
8010460f:	c7 04 24 29 8a 10 80 	movl   $0x80108a29,(%esp)
80104616:	e8 85 bd ff ff       	call   801003a0 <cprintf>
        return -1;
8010461b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104620:	e9 82 00 00 00       	jmp    801046a7 <clone+0x218>
    }

    np->tf->eip = routine;
80104625:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104628:	8b 40 18             	mov    0x18(%eax),%eax
8010462b:	8b 55 10             	mov    0x10(%ebp),%edx
8010462e:	89 50 38             	mov    %edx,0x38(%eax)
    np->tf->esp = sp;
80104631:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104634:	8b 40 18             	mov    0x18(%eax),%eax
80104637:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010463a:	89 50 44             	mov    %edx,0x44(%eax)
    np->cwd = idup(proc->cwd);
8010463d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104643:	8b 40 68             	mov    0x68(%eax),%eax
80104646:	89 04 24             	mov    %eax,(%esp)
80104649:	e8 d6 d1 ff ff       	call   80101824 <idup>
8010464e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80104651:	89 42 68             	mov    %eax,0x68(%edx)

    switchuvm(np);
80104654:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104657:	89 04 24             	mov    %eax,(%esp)
8010465a:	e8 4f 39 00 00       	call   80107fae <switchuvm>

     acquire(&ptable.lock);
8010465f:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104666:	e8 14 0a 00 00       	call   8010507f <acquire>
    np->state = RUNNABLE;
8010466b:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010466e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
     release(&ptable.lock);
80104675:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
8010467c:	e8 60 0a 00 00       	call   801050e1 <release>
    safestrcpy(np->name, proc->name, sizeof(proc->name));
80104681:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104687:	8d 50 6c             	lea    0x6c(%eax),%edx
8010468a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010468d:	83 c0 6c             	add    $0x6c,%eax
80104690:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104697:	00 
80104698:	89 54 24 04          	mov    %edx,0x4(%esp)
8010469c:	89 04 24             	mov    %eax,(%esp)
8010469f:	e8 52 0e 00 00       	call   801054f6 <safestrcpy>


    return pid;
801046a4:	8b 45 d8             	mov    -0x28(%ebp),%eax

}
801046a7:	81 c4 bc 00 00 00    	add    $0xbc,%esp
801046ad:	5b                   	pop    %ebx
801046ae:	5e                   	pop    %esi
801046af:	5f                   	pop    %edi
801046b0:	5d                   	pop    %ebp
801046b1:	c3                   	ret    

801046b2 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
    void
exit(void)
{
801046b2:	55                   	push   %ebp
801046b3:	89 e5                	mov    %esp,%ebp
801046b5:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    int fd;

    if(proc == initproc)
801046b8:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801046bf:	a1 68 b6 10 80       	mov    0x8010b668,%eax
801046c4:	39 c2                	cmp    %eax,%edx
801046c6:	75 0c                	jne    801046d4 <exit+0x22>
        panic("init exiting");
801046c8:	c7 04 24 39 8a 10 80 	movl   $0x80108a39,(%esp)
801046cf:	e8 66 be ff ff       	call   8010053a <panic>

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
801046d4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801046db:	eb 44                	jmp    80104721 <exit+0x6f>
        if(proc->ofile[fd]){
801046dd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046e3:	8b 55 f0             	mov    -0x10(%ebp),%edx
801046e6:	83 c2 08             	add    $0x8,%edx
801046e9:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046ed:	85 c0                	test   %eax,%eax
801046ef:	74 2c                	je     8010471d <exit+0x6b>
            fileclose(proc->ofile[fd]);
801046f1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046f7:	8b 55 f0             	mov    -0x10(%ebp),%edx
801046fa:	83 c2 08             	add    $0x8,%edx
801046fd:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104701:	89 04 24             	mov    %eax,(%esp)
80104704:	e8 bf c8 ff ff       	call   80100fc8 <fileclose>
            proc->ofile[fd] = 0;
80104709:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010470f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104712:	83 c2 08             	add    $0x8,%edx
80104715:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010471c:	00 

    if(proc == initproc)
        panic("init exiting");

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
8010471d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104721:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104725:	7e b6                	jle    801046dd <exit+0x2b>
            fileclose(proc->ofile[fd]);
            proc->ofile[fd] = 0;
        }
    }

    iput(proc->cwd);
80104727:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010472d:	8b 40 68             	mov    0x68(%eax),%eax
80104730:	89 04 24             	mov    %eax,(%esp)
80104733:	e8 d1 d2 ff ff       	call   80101a09 <iput>
    proc->cwd = 0;
80104738:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010473e:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

    acquire(&ptable.lock);
80104745:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
8010474c:	e8 2e 09 00 00       	call   8010507f <acquire>

    // Parent might be sleeping in wait().
    wakeup1(proc->parent);
80104751:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104757:	8b 40 14             	mov    0x14(%eax),%eax
8010475a:	89 04 24             	mov    %eax,(%esp)
8010475d:	e8 47 06 00 00       	call   80104da9 <wakeup1>

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104762:	c7 45 f4 b4 ff 10 80 	movl   $0x8010ffb4,-0xc(%ebp)
80104769:	eb 3b                	jmp    801047a6 <exit+0xf4>
        if(p->parent == proc){
8010476b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010476e:	8b 50 14             	mov    0x14(%eax),%edx
80104771:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104777:	39 c2                	cmp    %eax,%edx
80104779:	75 24                	jne    8010479f <exit+0xed>
            p->parent = initproc;
8010477b:	8b 15 68 b6 10 80    	mov    0x8010b668,%edx
80104781:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104784:	89 50 14             	mov    %edx,0x14(%eax)
            if(p->state == ZOMBIE)
80104787:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010478a:	8b 40 0c             	mov    0xc(%eax),%eax
8010478d:	83 f8 05             	cmp    $0x5,%eax
80104790:	75 0d                	jne    8010479f <exit+0xed>
                wakeup1(initproc);
80104792:	a1 68 b6 10 80       	mov    0x8010b668,%eax
80104797:	89 04 24             	mov    %eax,(%esp)
8010479a:	e8 0a 06 00 00       	call   80104da9 <wakeup1>

    // Parent might be sleeping in wait().
    wakeup1(proc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010479f:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
801047a6:	81 7d f4 b4 21 11 80 	cmpl   $0x801121b4,-0xc(%ebp)
801047ad:	72 bc                	jb     8010476b <exit+0xb9>
                wakeup1(initproc);
        }
    }

    // Jump into the scheduler, never to return.
    proc->state = ZOMBIE;
801047af:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047b5:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
    sched();
801047bc:	e8 13 03 00 00       	call   80104ad4 <sched>
    panic("zombie exit");
801047c1:	c7 04 24 46 8a 10 80 	movl   $0x80108a46,(%esp)
801047c8:	e8 6d bd ff ff       	call   8010053a <panic>

801047cd <texit>:
}
    void
texit(void)
{
801047cd:	55                   	push   %ebp
801047ce:	89 e5                	mov    %esp,%ebp
801047d0:	83 ec 28             	sub    $0x28,%esp
    //  struct proc *p;
    int fd;

    if(proc == initproc)
801047d3:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801047da:	a1 68 b6 10 80       	mov    0x8010b668,%eax
801047df:	39 c2                	cmp    %eax,%edx
801047e1:	75 0c                	jne    801047ef <texit+0x22>
        panic("init exiting");
801047e3:	c7 04 24 39 8a 10 80 	movl   $0x80108a39,(%esp)
801047ea:	e8 4b bd ff ff       	call   8010053a <panic>

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
801047ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801047f6:	eb 44                	jmp    8010483c <texit+0x6f>
        if(proc->ofile[fd]){
801047f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104801:	83 c2 08             	add    $0x8,%edx
80104804:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104808:	85 c0                	test   %eax,%eax
8010480a:	74 2c                	je     80104838 <texit+0x6b>
            fileclose(proc->ofile[fd]);
8010480c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104812:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104815:	83 c2 08             	add    $0x8,%edx
80104818:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010481c:	89 04 24             	mov    %eax,(%esp)
8010481f:	e8 a4 c7 ff ff       	call   80100fc8 <fileclose>
            proc->ofile[fd] = 0;
80104824:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010482a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010482d:	83 c2 08             	add    $0x8,%edx
80104830:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104837:	00 

    if(proc == initproc)
        panic("init exiting");

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
80104838:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010483c:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104840:	7e b6                	jle    801047f8 <texit+0x2b>
        if(proc->ofile[fd]){
            fileclose(proc->ofile[fd]);
            proc->ofile[fd] = 0;
        }
    }
    iput(proc->cwd);
80104842:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104848:	8b 40 68             	mov    0x68(%eax),%eax
8010484b:	89 04 24             	mov    %eax,(%esp)
8010484e:	e8 b6 d1 ff ff       	call   80101a09 <iput>
    proc->cwd = 0;
80104853:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104859:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

    acquire(&ptable.lock);
80104860:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104867:	e8 13 08 00 00       	call   8010507f <acquire>
    // Parent might be sleeping in wait().
    wakeup1(proc->parent);
8010486c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104872:	8b 40 14             	mov    0x14(%eax),%eax
80104875:	89 04 24             	mov    %eax,(%esp)
80104878:	e8 2c 05 00 00       	call   80104da9 <wakeup1>
    release(&ptable.lock);
8010487d:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104884:	e8 58 08 00 00       	call   801050e1 <release>
		acquire(&tylock);
80104889:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104890:	e8 ea 07 00 00       	call   8010507f <acquire>
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104895:	c7 45 f0 b4 ff 10 80 	movl   $0x8010ffb4,-0x10(%ebp)
8010489c:	eb 3c                	jmp    801048da <texit+0x10d>
      if(p->isthread == 1 && p->state == SLEEPING && p->isYielding == 1){
8010489e:	8b 45 f0             	mov    -0x10(%ebp),%eax
801048a1:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
801048a7:	83 f8 01             	cmp    $0x1,%eax
801048aa:	75 27                	jne    801048d3 <texit+0x106>
801048ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801048af:	8b 40 0c             	mov    0xc(%eax),%eax
801048b2:	83 f8 02             	cmp    $0x2,%eax
801048b5:	75 1c                	jne    801048d3 <texit+0x106>
801048b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801048ba:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
801048c0:	83 f8 01             	cmp    $0x1,%eax
801048c3:	75 0e                	jne    801048d3 <texit+0x106>
        twakeup(p->pid);
801048c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801048c8:	8b 40 10             	mov    0x10(%eax),%eax
801048cb:	89 04 24             	mov    %eax,(%esp)
801048ce:	e8 17 05 00 00       	call   80104dea <twakeup>
    // Parent might be sleeping in wait().
    wakeup1(proc->parent);
    release(&ptable.lock);
		acquire(&tylock);
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048d3:	81 45 f0 88 00 00 00 	addl   $0x88,-0x10(%ebp)
801048da:	81 7d f0 b4 21 11 80 	cmpl   $0x801121b4,-0x10(%ebp)
801048e1:	72 bb                	jb     8010489e <texit+0xd1>
      if(p->isthread == 1 && p->state == SLEEPING && p->isYielding == 1){
        twakeup(p->pid);
      }
    }
    release(&tylock);
801048e3:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801048ea:	e8 f2 07 00 00       	call   801050e1 <release>
    acquire(&ptable.lock);
801048ef:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
801048f6:	e8 84 07 00 00       	call   8010507f <acquire>
    //      if(p->state == ZOMBIE)
    //        wakeup1(initproc);
    //    }
    //  }
    // Jump into the scheduler, never to return.
    proc->state = ZOMBIE;
801048fb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104901:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
    sched();
80104908:	e8 c7 01 00 00       	call   80104ad4 <sched>
    panic("zombie exit");
8010490d:	c7 04 24 46 8a 10 80 	movl   $0x80108a46,(%esp)
80104914:	e8 21 bc ff ff       	call   8010053a <panic>

80104919 <wait>:
}
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
    int
wait(void)
{
80104919:	55                   	push   %ebp
8010491a:	89 e5                	mov    %esp,%ebp
8010491c:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    int havekids, pid;

    acquire(&ptable.lock);
8010491f:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104926:	e8 54 07 00 00       	call   8010507f <acquire>
    for(;;){
        // Scan through table looking for zombie children.
        havekids = 0;
8010492b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104932:	c7 45 f4 b4 ff 10 80 	movl   $0x8010ffb4,-0xc(%ebp)
80104939:	e9 ab 00 00 00       	jmp    801049e9 <wait+0xd0>
        //    if(p->parent != proc && p->isthread ==1)
            if(p->parent != proc) 
8010493e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104941:	8b 50 14             	mov    0x14(%eax),%edx
80104944:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010494a:	39 c2                	cmp    %eax,%edx
8010494c:	74 05                	je     80104953 <wait+0x3a>
                continue;
8010494e:	e9 8f 00 00 00       	jmp    801049e2 <wait+0xc9>
            havekids = 1;
80104953:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
            if(p->state == ZOMBIE){
8010495a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010495d:	8b 40 0c             	mov    0xc(%eax),%eax
80104960:	83 f8 05             	cmp    $0x5,%eax
80104963:	75 7d                	jne    801049e2 <wait+0xc9>
                // Found one.
                pid = p->pid;
80104965:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104968:	8b 40 10             	mov    0x10(%eax),%eax
8010496b:	89 45 ec             	mov    %eax,-0x14(%ebp)
                kfree(p->kstack);
8010496e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104971:	8b 40 08             	mov    0x8(%eax),%eax
80104974:	89 04 24             	mov    %eax,(%esp)
80104977:	e8 ce e0 ff ff       	call   80102a4a <kfree>
                p->kstack = 0;
8010497c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010497f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
                if(p->isthread != 1){
80104986:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104989:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
8010498f:	83 f8 01             	cmp    $0x1,%eax
80104992:	74 0e                	je     801049a2 <wait+0x89>
                    freevm(p->pgdir);
80104994:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104997:	8b 40 04             	mov    0x4(%eax),%eax
8010499a:	89 04 24             	mov    %eax,(%esp)
8010499d:	e8 7f 3a 00 00       	call   80108421 <freevm>
                }
                p->state = UNUSED;
801049a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049a5:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
                p->pid = 0;
801049ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049af:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
                p->parent = 0;
801049b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049b9:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
                p->name[0] = 0;
801049c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049c3:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
                p->killed = 0;
801049c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049ca:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
                release(&ptable.lock);
801049d1:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
801049d8:	e8 04 07 00 00       	call   801050e1 <release>
                return pid;
801049dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801049e0:	eb 55                	jmp    80104a37 <wait+0x11e>

    acquire(&ptable.lock);
    for(;;){
        // Scan through table looking for zombie children.
        havekids = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049e2:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
801049e9:	81 7d f4 b4 21 11 80 	cmpl   $0x801121b4,-0xc(%ebp)
801049f0:	0f 82 48 ff ff ff    	jb     8010493e <wait+0x25>
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || proc->killed){
801049f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801049fa:	74 0d                	je     80104a09 <wait+0xf0>
801049fc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a02:	8b 40 24             	mov    0x24(%eax),%eax
80104a05:	85 c0                	test   %eax,%eax
80104a07:	74 13                	je     80104a1c <wait+0x103>
            release(&ptable.lock);
80104a09:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104a10:	e8 cc 06 00 00       	call   801050e1 <release>
            return -1;
80104a15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a1a:	eb 1b                	jmp    80104a37 <wait+0x11e>
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104a1c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a22:	c7 44 24 04 80 ff 10 	movl   $0x8010ff80,0x4(%esp)
80104a29:	80 
80104a2a:	89 04 24             	mov    %eax,(%esp)
80104a2d:	e8 dc 02 00 00       	call   80104d0e <sleep>
    }
80104a32:	e9 f4 fe ff ff       	jmp    8010492b <wait+0x12>
}
80104a37:	c9                   	leave  
80104a38:	c3                   	ret    

80104a39 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
    void
scheduler(void)
{
80104a39:	55                   	push   %ebp
80104a3a:	89 e5                	mov    %esp,%ebp
80104a3c:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;

    for(;;){
        // Enable interrupts on this processor.
        sti();
80104a3f:	e8 5c f5 ff ff       	call   80103fa0 <sti>

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
80104a44:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104a4b:	e8 2f 06 00 00       	call   8010507f <acquire>
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a50:	c7 45 f4 b4 ff 10 80 	movl   $0x8010ffb4,-0xc(%ebp)
80104a57:	eb 61                	jmp    80104aba <scheduler+0x81>
            if(p->state != RUNNABLE)
80104a59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a5c:	8b 40 0c             	mov    0xc(%eax),%eax
80104a5f:	83 f8 03             	cmp    $0x3,%eax
80104a62:	74 02                	je     80104a66 <scheduler+0x2d>
                continue;
80104a64:	eb 4d                	jmp    80104ab3 <scheduler+0x7a>

            // Switch to chosen process.  It is the process's job
            // to release ptable.lock and then reacquire it
            // before jumping back to us.
            proc = p;
80104a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a69:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
            switchuvm(p);
80104a6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a72:	89 04 24             	mov    %eax,(%esp)
80104a75:	e8 34 35 00 00       	call   80107fae <switchuvm>
            p->state = RUNNING;
80104a7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a7d:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
            swtch(&cpu->scheduler, proc->context);
80104a84:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a8a:	8b 40 1c             	mov    0x1c(%eax),%eax
80104a8d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104a94:	83 c2 04             	add    $0x4,%edx
80104a97:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a9b:	89 14 24             	mov    %edx,(%esp)
80104a9e:	e8 c5 0a 00 00       	call   80105568 <swtch>
            switchkvm();
80104aa3:	e8 e9 34 00 00       	call   80107f91 <switchkvm>

            // Process is done running for now.
            // It should have changed its p->state before coming back.
            proc = 0;
80104aa8:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104aaf:	00 00 00 00 
        // Enable interrupts on this processor.
        sti();

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ab3:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
80104aba:	81 7d f4 b4 21 11 80 	cmpl   $0x801121b4,-0xc(%ebp)
80104ac1:	72 96                	jb     80104a59 <scheduler+0x20>

            // Process is done running for now.
            // It should have changed its p->state before coming back.
            proc = 0;
        }
        release(&ptable.lock);
80104ac3:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104aca:	e8 12 06 00 00       	call   801050e1 <release>

    }
80104acf:	e9 6b ff ff ff       	jmp    80104a3f <scheduler+0x6>

80104ad4 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
    void
sched(void)
{
80104ad4:	55                   	push   %ebp
80104ad5:	89 e5                	mov    %esp,%ebp
80104ad7:	83 ec 28             	sub    $0x28,%esp
    int intena;

    if(!holding(&ptable.lock))
80104ada:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104ae1:	e8 c3 06 00 00       	call   801051a9 <holding>
80104ae6:	85 c0                	test   %eax,%eax
80104ae8:	75 0c                	jne    80104af6 <sched+0x22>
        panic("sched ptable.lock");
80104aea:	c7 04 24 52 8a 10 80 	movl   $0x80108a52,(%esp)
80104af1:	e8 44 ba ff ff       	call   8010053a <panic>
    if(cpu->ncli != 1){
80104af6:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104afc:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104b02:	83 f8 01             	cmp    $0x1,%eax
80104b05:	74 35                	je     80104b3c <sched+0x68>
        cprintf("current proc %d\n cpu->ncli %d\n",proc->pid,cpu->ncli);
80104b07:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b0d:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104b13:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b19:	8b 40 10             	mov    0x10(%eax),%eax
80104b1c:	89 54 24 08          	mov    %edx,0x8(%esp)
80104b20:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b24:	c7 04 24 64 8a 10 80 	movl   $0x80108a64,(%esp)
80104b2b:	e8 70 b8 ff ff       	call   801003a0 <cprintf>
        panic("sched locks");
80104b30:	c7 04 24 83 8a 10 80 	movl   $0x80108a83,(%esp)
80104b37:	e8 fe b9 ff ff       	call   8010053a <panic>
    }
    if(proc->state == RUNNING)
80104b3c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b42:	8b 40 0c             	mov    0xc(%eax),%eax
80104b45:	83 f8 04             	cmp    $0x4,%eax
80104b48:	75 0c                	jne    80104b56 <sched+0x82>
        panic("sched running");
80104b4a:	c7 04 24 8f 8a 10 80 	movl   $0x80108a8f,(%esp)
80104b51:	e8 e4 b9 ff ff       	call   8010053a <panic>
    if(readeflags()&FL_IF)
80104b56:	e8 35 f4 ff ff       	call   80103f90 <readeflags>
80104b5b:	25 00 02 00 00       	and    $0x200,%eax
80104b60:	85 c0                	test   %eax,%eax
80104b62:	74 0c                	je     80104b70 <sched+0x9c>
        panic("sched interruptible");
80104b64:	c7 04 24 9d 8a 10 80 	movl   $0x80108a9d,(%esp)
80104b6b:	e8 ca b9 ff ff       	call   8010053a <panic>
    intena = cpu->intena;
80104b70:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b76:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104b7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    swtch(&proc->context, cpu->scheduler);
80104b7f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b85:	8b 40 04             	mov    0x4(%eax),%eax
80104b88:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104b8f:	83 c2 1c             	add    $0x1c,%edx
80104b92:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b96:	89 14 24             	mov    %edx,(%esp)
80104b99:	e8 ca 09 00 00       	call   80105568 <swtch>
    cpu->intena = intena;
80104b9e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ba4:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ba7:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104bad:	c9                   	leave  
80104bae:	c3                   	ret    

80104baf <yield>:

// Give up the CPU for one scheduling round.
    void
yield(void)
{
80104baf:	55                   	push   %ebp
80104bb0:	89 e5                	mov    %esp,%ebp
80104bb2:	83 ec 18             	sub    $0x18,%esp
    acquire(&ptable.lock);  //DOC: yieldlock
80104bb5:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104bbc:	e8 be 04 00 00       	call   8010507f <acquire>
    proc->state = RUNNABLE;
80104bc1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bc7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
    sched();
80104bce:	e8 01 ff ff ff       	call   80104ad4 <sched>
    release(&ptable.lock);
80104bd3:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104bda:	e8 02 05 00 00       	call   801050e1 <release>
}
80104bdf:	c9                   	leave  
80104be0:	c3                   	ret    

80104be1 <thread_yield>:

void thread_yield(void){
80104be1:	55                   	push   %ebp
80104be2:	89 e5                	mov    %esp,%ebp
80104be4:	83 ec 28             	sub    $0x28,%esp
	acquire(&tylock);
80104be7:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104bee:	e8 8c 04 00 00       	call   8010507f <acquire>
  int i = -1;
80104bf3:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
	struct proc *p;
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bfa:	c7 45 f0 b4 ff 10 80 	movl   $0x8010ffb4,-0x10(%ebp)
80104c01:	eb 5f                	jmp    80104c62 <thread_yield+0x81>
		if(p->isthread == 1 && p->state != SLEEPING){
80104c03:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c06:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80104c0c:	83 f8 01             	cmp    $0x1,%eax
80104c0f:	75 11                	jne    80104c22 <thread_yield+0x41>
80104c11:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c14:	8b 40 0c             	mov    0xc(%eax),%eax
80104c17:	83 f8 02             	cmp    $0x2,%eax
80104c1a:	74 06                	je     80104c22 <thread_yield+0x41>
			i++;
80104c1c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104c20:	eb 39                	jmp    80104c5b <thread_yield+0x7a>
		}
		else if(p->isthread == 1 && p->state == SLEEPING && p->isYielding == 1){
80104c22:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c25:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80104c2b:	83 f8 01             	cmp    $0x1,%eax
80104c2e:	75 2b                	jne    80104c5b <thread_yield+0x7a>
80104c30:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c33:	8b 40 0c             	mov    0xc(%eax),%eax
80104c36:	83 f8 02             	cmp    $0x2,%eax
80104c39:	75 20                	jne    80104c5b <thread_yield+0x7a>
80104c3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c3e:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80104c44:	83 f8 01             	cmp    $0x1,%eax
80104c47:	75 12                	jne    80104c5b <thread_yield+0x7a>
			twakeup(p->pid);
80104c49:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c4c:	8b 40 10             	mov    0x10(%eax),%eax
80104c4f:	89 04 24             	mov    %eax,(%esp)
80104c52:	e8 93 01 00 00       	call   80104dea <twakeup>
			i++;
80104c57:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

void thread_yield(void){
	acquire(&tylock);
  int i = -1;
	struct proc *p;
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c5b:	81 45 f0 88 00 00 00 	addl   $0x88,-0x10(%ebp)
80104c62:	81 7d f0 b4 21 11 80 	cmpl   $0x801121b4,-0x10(%ebp)
80104c69:	72 98                	jb     80104c03 <thread_yield+0x22>
			twakeup(p->pid);
			i++;
		}
	}
	
	if(i > 0){
80104c6b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104c6f:	7e 63                	jle    80104cd4 <thread_yield+0xf3>
		acquire(&ptable.lock);
80104c71:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104c78:	e8 02 04 00 00       	call   8010507f <acquire>
		proc->isYielding = 1;
80104c7d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c83:	c7 80 84 00 00 00 01 	movl   $0x1,0x84(%eax)
80104c8a:	00 00 00 
		release(&ptable.lock);
80104c8d:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104c94:	e8 48 04 00 00       	call   801050e1 <release>
		release(&tylock);
80104c99:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104ca0:	e8 3c 04 00 00       	call   801050e1 <release>
		tsleep();
80104ca5:	e8 48 03 00 00       	call   80104ff2 <tsleep>
		acquire(&ptable.lock);
80104caa:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104cb1:	e8 c9 03 00 00       	call   8010507f <acquire>
		proc->isYielding = 0;
80104cb6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cbc:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%eax)
80104cc3:	00 00 00 
		release(&ptable.lock);
80104cc6:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104ccd:	e8 0f 04 00 00       	call   801050e1 <release>
80104cd2:	eb 0c                	jmp    80104ce0 <thread_yield+0xff>
	}
	else
		release(&tylock);
80104cd4:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104cdb:	e8 01 04 00 00       	call   801050e1 <release>
}
80104ce0:	c9                   	leave  
80104ce1:	c3                   	ret    

80104ce2 <forkret>:
// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
    void
forkret(void)
{
80104ce2:	55                   	push   %ebp
80104ce3:	89 e5                	mov    %esp,%ebp
80104ce5:	83 ec 18             	sub    $0x18,%esp
    static int first = 1;
    // Still holding ptable.lock from scheduler.
    release(&ptable.lock);
80104ce8:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104cef:	e8 ed 03 00 00       	call   801050e1 <release>

    if (first) {
80104cf4:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104cf9:	85 c0                	test   %eax,%eax
80104cfb:	74 0f                	je     80104d0c <forkret+0x2a>
        // Some initialization functions must be run in the context
        // of a regular process (e.g., they call sleep), and thus cannot 
        // be run from main().
        first = 0;
80104cfd:	c7 05 08 b0 10 80 00 	movl   $0x0,0x8010b008
80104d04:	00 00 00 
        initlog();
80104d07:	e8 cc e2 ff ff       	call   80102fd8 <initlog>
    }

    // Return to "caller", actually trapret (see allocproc).
}
80104d0c:	c9                   	leave  
80104d0d:	c3                   	ret    

80104d0e <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
    void
sleep(void *chan, struct spinlock *lk)
{
80104d0e:	55                   	push   %ebp
80104d0f:	89 e5                	mov    %esp,%ebp
80104d11:	83 ec 18             	sub    $0x18,%esp
    if(proc == 0)
80104d14:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d1a:	85 c0                	test   %eax,%eax
80104d1c:	75 0c                	jne    80104d2a <sleep+0x1c>
        panic("sleep");
80104d1e:	c7 04 24 b1 8a 10 80 	movl   $0x80108ab1,(%esp)
80104d25:	e8 10 b8 ff ff       	call   8010053a <panic>

    if(lk == 0)
80104d2a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104d2e:	75 0c                	jne    80104d3c <sleep+0x2e>
        panic("sleep without lk");
80104d30:	c7 04 24 b7 8a 10 80 	movl   $0x80108ab7,(%esp)
80104d37:	e8 fe b7 ff ff       	call   8010053a <panic>
    // change p->state and then call sched.
    // Once we hold ptable.lock, we can be
    // guaranteed that we won't miss any wakeup
    // (wakeup runs with ptable.lock locked),
    // so it's okay to release lk.
    if(lk != &ptable.lock){  //DOC: sleeplock0
80104d3c:	81 7d 0c 80 ff 10 80 	cmpl   $0x8010ff80,0xc(%ebp)
80104d43:	74 17                	je     80104d5c <sleep+0x4e>
        acquire(&ptable.lock);  //DOC: sleeplock1
80104d45:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104d4c:	e8 2e 03 00 00       	call   8010507f <acquire>
        release(lk);
80104d51:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d54:	89 04 24             	mov    %eax,(%esp)
80104d57:	e8 85 03 00 00       	call   801050e1 <release>
    }

    // Go to sleep.
    proc->chan = chan;
80104d5c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d62:	8b 55 08             	mov    0x8(%ebp),%edx
80104d65:	89 50 20             	mov    %edx,0x20(%eax)
    proc->state = SLEEPING;
80104d68:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d6e:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
    sched();
80104d75:	e8 5a fd ff ff       	call   80104ad4 <sched>

    // Tidy up.
    proc->chan = 0;
80104d7a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d80:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

    // Reacquire original lock.
    if(lk != &ptable.lock){  //DOC: sleeplock2
80104d87:	81 7d 0c 80 ff 10 80 	cmpl   $0x8010ff80,0xc(%ebp)
80104d8e:	74 17                	je     80104da7 <sleep+0x99>
        release(&ptable.lock);
80104d90:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104d97:	e8 45 03 00 00       	call   801050e1 <release>
        acquire(lk);
80104d9c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d9f:	89 04 24             	mov    %eax,(%esp)
80104da2:	e8 d8 02 00 00       	call   8010507f <acquire>
    }
}
80104da7:	c9                   	leave  
80104da8:	c3                   	ret    

80104da9 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
    static void
wakeup1(void *chan)
{
80104da9:	55                   	push   %ebp
80104daa:	89 e5                	mov    %esp,%ebp
80104dac:	83 ec 10             	sub    $0x10,%esp
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104daf:	c7 45 fc b4 ff 10 80 	movl   $0x8010ffb4,-0x4(%ebp)
80104db6:	eb 27                	jmp    80104ddf <wakeup1+0x36>
        if(p->state == SLEEPING && p->chan == chan)
80104db8:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104dbb:	8b 40 0c             	mov    0xc(%eax),%eax
80104dbe:	83 f8 02             	cmp    $0x2,%eax
80104dc1:	75 15                	jne    80104dd8 <wakeup1+0x2f>
80104dc3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104dc6:	8b 40 20             	mov    0x20(%eax),%eax
80104dc9:	3b 45 08             	cmp    0x8(%ebp),%eax
80104dcc:	75 0a                	jne    80104dd8 <wakeup1+0x2f>
            p->state = RUNNABLE;
80104dce:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104dd1:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
    static void
wakeup1(void *chan)
{
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104dd8:	81 45 fc 88 00 00 00 	addl   $0x88,-0x4(%ebp)
80104ddf:	81 7d fc b4 21 11 80 	cmpl   $0x801121b4,-0x4(%ebp)
80104de6:	72 d0                	jb     80104db8 <wakeup1+0xf>
        if(p->state == SLEEPING && p->chan == chan)
            p->state = RUNNABLE;
}
80104de8:	c9                   	leave  
80104de9:	c3                   	ret    

80104dea <twakeup>:

void 
twakeup(int tid){
80104dea:	55                   	push   %ebp
80104deb:	89 e5                	mov    %esp,%ebp
80104ded:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    acquire(&ptable.lock);
80104df0:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104df7:	e8 83 02 00 00       	call   8010507f <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104dfc:	c7 45 f4 b4 ff 10 80 	movl   $0x8010ffb4,-0xc(%ebp)
80104e03:	eb 36                	jmp    80104e3b <twakeup+0x51>
        if(p->state == SLEEPING && p->pid == tid && p->isthread == 1){
80104e05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e08:	8b 40 0c             	mov    0xc(%eax),%eax
80104e0b:	83 f8 02             	cmp    $0x2,%eax
80104e0e:	75 24                	jne    80104e34 <twakeup+0x4a>
80104e10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e13:	8b 40 10             	mov    0x10(%eax),%eax
80104e16:	3b 45 08             	cmp    0x8(%ebp),%eax
80104e19:	75 19                	jne    80104e34 <twakeup+0x4a>
80104e1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e1e:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80104e24:	83 f8 01             	cmp    $0x1,%eax
80104e27:	75 0b                	jne    80104e34 <twakeup+0x4a>
            wakeup1(p);
80104e29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e2c:	89 04 24             	mov    %eax,(%esp)
80104e2f:	e8 75 ff ff ff       	call   80104da9 <wakeup1>

void 
twakeup(int tid){
    struct proc *p;
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e34:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
80104e3b:	81 7d f4 b4 21 11 80 	cmpl   $0x801121b4,-0xc(%ebp)
80104e42:	72 c1                	jb     80104e05 <twakeup+0x1b>
        if(p->state == SLEEPING && p->pid == tid && p->isthread == 1){
            wakeup1(p);
        }
    }
    release(&ptable.lock);
80104e44:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104e4b:	e8 91 02 00 00       	call   801050e1 <release>
}
80104e50:	c9                   	leave  
80104e51:	c3                   	ret    

80104e52 <wakeup>:

// Wake up all processes sleeping on chan.
    void
wakeup(void *chan)
{
80104e52:	55                   	push   %ebp
80104e53:	89 e5                	mov    %esp,%ebp
80104e55:	83 ec 18             	sub    $0x18,%esp
    acquire(&ptable.lock);
80104e58:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104e5f:	e8 1b 02 00 00       	call   8010507f <acquire>
    wakeup1(chan);
80104e64:	8b 45 08             	mov    0x8(%ebp),%eax
80104e67:	89 04 24             	mov    %eax,(%esp)
80104e6a:	e8 3a ff ff ff       	call   80104da9 <wakeup1>
    release(&ptable.lock);
80104e6f:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104e76:	e8 66 02 00 00       	call   801050e1 <release>
}
80104e7b:	c9                   	leave  
80104e7c:	c3                   	ret    

80104e7d <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
    int
kill(int pid)
{
80104e7d:	55                   	push   %ebp
80104e7e:	89 e5                	mov    %esp,%ebp
80104e80:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;

    acquire(&ptable.lock);
80104e83:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104e8a:	e8 f0 01 00 00       	call   8010507f <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e8f:	c7 45 f4 b4 ff 10 80 	movl   $0x8010ffb4,-0xc(%ebp)
80104e96:	eb 44                	jmp    80104edc <kill+0x5f>
        if(p->pid == pid){
80104e98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e9b:	8b 40 10             	mov    0x10(%eax),%eax
80104e9e:	3b 45 08             	cmp    0x8(%ebp),%eax
80104ea1:	75 32                	jne    80104ed5 <kill+0x58>
            p->killed = 1;
80104ea3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ea6:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            // Wake process from sleep if necessary.
            if(p->state == SLEEPING)
80104ead:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104eb0:	8b 40 0c             	mov    0xc(%eax),%eax
80104eb3:	83 f8 02             	cmp    $0x2,%eax
80104eb6:	75 0a                	jne    80104ec2 <kill+0x45>
                p->state = RUNNABLE;
80104eb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ebb:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
            release(&ptable.lock);
80104ec2:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104ec9:	e8 13 02 00 00       	call   801050e1 <release>
            return 0;
80104ece:	b8 00 00 00 00       	mov    $0x0,%eax
80104ed3:	eb 21                	jmp    80104ef6 <kill+0x79>
kill(int pid)
{
    struct proc *p;

    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ed5:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
80104edc:	81 7d f4 b4 21 11 80 	cmpl   $0x801121b4,-0xc(%ebp)
80104ee3:	72 b3                	jb     80104e98 <kill+0x1b>
                p->state = RUNNABLE;
            release(&ptable.lock);
            return 0;
        }
    }
    release(&ptable.lock);
80104ee5:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104eec:	e8 f0 01 00 00       	call   801050e1 <release>
    return -1;
80104ef1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ef6:	c9                   	leave  
80104ef7:	c3                   	ret    

80104ef8 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
    void
procdump(void)
{
80104ef8:	55                   	push   %ebp
80104ef9:	89 e5                	mov    %esp,%ebp
80104efb:	83 ec 58             	sub    $0x58,%esp
    int i;
    struct proc *p;
    char *state;
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104efe:	c7 45 f0 b4 ff 10 80 	movl   $0x8010ffb4,-0x10(%ebp)
80104f05:	e9 d9 00 00 00       	jmp    80104fe3 <procdump+0xeb>
        if(p->state == UNUSED)
80104f0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f0d:	8b 40 0c             	mov    0xc(%eax),%eax
80104f10:	85 c0                	test   %eax,%eax
80104f12:	75 05                	jne    80104f19 <procdump+0x21>
            continue;
80104f14:	e9 c3 00 00 00       	jmp    80104fdc <procdump+0xe4>
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104f19:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f1c:	8b 40 0c             	mov    0xc(%eax),%eax
80104f1f:	83 f8 05             	cmp    $0x5,%eax
80104f22:	77 23                	ja     80104f47 <procdump+0x4f>
80104f24:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f27:	8b 40 0c             	mov    0xc(%eax),%eax
80104f2a:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104f31:	85 c0                	test   %eax,%eax
80104f33:	74 12                	je     80104f47 <procdump+0x4f>
            state = states[p->state];
80104f35:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f38:	8b 40 0c             	mov    0xc(%eax),%eax
80104f3b:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104f42:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104f45:	eb 07                	jmp    80104f4e <procdump+0x56>
        else
            state = "???";
80104f47:	c7 45 ec c8 8a 10 80 	movl   $0x80108ac8,-0x14(%ebp)
        cprintf("%d %s %s", p->pid, state, p->name);
80104f4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f51:	8d 50 6c             	lea    0x6c(%eax),%edx
80104f54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f57:	8b 40 10             	mov    0x10(%eax),%eax
80104f5a:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104f5e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104f61:	89 54 24 08          	mov    %edx,0x8(%esp)
80104f65:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f69:	c7 04 24 cc 8a 10 80 	movl   $0x80108acc,(%esp)
80104f70:	e8 2b b4 ff ff       	call   801003a0 <cprintf>
        if(p->state == SLEEPING){
80104f75:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f78:	8b 40 0c             	mov    0xc(%eax),%eax
80104f7b:	83 f8 02             	cmp    $0x2,%eax
80104f7e:	75 50                	jne    80104fd0 <procdump+0xd8>
            getcallerpcs((uint*)p->context->ebp+2, pc);
80104f80:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f83:	8b 40 1c             	mov    0x1c(%eax),%eax
80104f86:	8b 40 0c             	mov    0xc(%eax),%eax
80104f89:	83 c0 08             	add    $0x8,%eax
80104f8c:	8d 55 c4             	lea    -0x3c(%ebp),%edx
80104f8f:	89 54 24 04          	mov    %edx,0x4(%esp)
80104f93:	89 04 24             	mov    %eax,(%esp)
80104f96:	e8 95 01 00 00       	call   80105130 <getcallerpcs>
            for(i=0; i<10 && pc[i] != 0; i++)
80104f9b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104fa2:	eb 1b                	jmp    80104fbf <procdump+0xc7>
                cprintf(" %p", pc[i]);
80104fa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fa7:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104fab:	89 44 24 04          	mov    %eax,0x4(%esp)
80104faf:	c7 04 24 d5 8a 10 80 	movl   $0x80108ad5,(%esp)
80104fb6:	e8 e5 b3 ff ff       	call   801003a0 <cprintf>
        else
            state = "???";
        cprintf("%d %s %s", p->pid, state, p->name);
        if(p->state == SLEEPING){
            getcallerpcs((uint*)p->context->ebp+2, pc);
            for(i=0; i<10 && pc[i] != 0; i++)
80104fbb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104fbf:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104fc3:	7f 0b                	jg     80104fd0 <procdump+0xd8>
80104fc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fc8:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104fcc:	85 c0                	test   %eax,%eax
80104fce:	75 d4                	jne    80104fa4 <procdump+0xac>
                cprintf(" %p", pc[i]);
        }
        cprintf("\n");
80104fd0:	c7 04 24 d9 8a 10 80 	movl   $0x80108ad9,(%esp)
80104fd7:	e8 c4 b3 ff ff       	call   801003a0 <cprintf>
    int i;
    struct proc *p;
    char *state;
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104fdc:	81 45 f0 88 00 00 00 	addl   $0x88,-0x10(%ebp)
80104fe3:	81 7d f0 b4 21 11 80 	cmpl   $0x801121b4,-0x10(%ebp)
80104fea:	0f 82 1a ff ff ff    	jb     80104f0a <procdump+0x12>
            for(i=0; i<10 && pc[i] != 0; i++)
                cprintf(" %p", pc[i]);
        }
        cprintf("\n");
    }
}
80104ff0:	c9                   	leave  
80104ff1:	c3                   	ret    

80104ff2 <tsleep>:

void tsleep(void){
80104ff2:	55                   	push   %ebp
80104ff3:	89 e5                	mov    %esp,%ebp
80104ff5:	83 ec 18             	sub    $0x18,%esp
    
    acquire(&ptable.lock); 
80104ff8:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80104fff:	e8 7b 00 00 00       	call   8010507f <acquire>
    sleep(proc, &ptable.lock);
80105004:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010500a:	c7 44 24 04 80 ff 10 	movl   $0x8010ff80,0x4(%esp)
80105011:	80 
80105012:	89 04 24             	mov    %eax,(%esp)
80105015:	e8 f4 fc ff ff       	call   80104d0e <sleep>
    release(&ptable.lock);
8010501a:	c7 04 24 80 ff 10 80 	movl   $0x8010ff80,(%esp)
80105021:	e8 bb 00 00 00       	call   801050e1 <release>

}
80105026:	c9                   	leave  
80105027:	c3                   	ret    

80105028 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80105028:	55                   	push   %ebp
80105029:	89 e5                	mov    %esp,%ebp
8010502b:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010502e:	9c                   	pushf  
8010502f:	58                   	pop    %eax
80105030:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80105033:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105036:	c9                   	leave  
80105037:	c3                   	ret    

80105038 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80105038:	55                   	push   %ebp
80105039:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
8010503b:	fa                   	cli    
}
8010503c:	5d                   	pop    %ebp
8010503d:	c3                   	ret    

8010503e <sti>:

static inline void
sti(void)
{
8010503e:	55                   	push   %ebp
8010503f:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80105041:	fb                   	sti    
}
80105042:	5d                   	pop    %ebp
80105043:	c3                   	ret    

80105044 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80105044:	55                   	push   %ebp
80105045:	89 e5                	mov    %esp,%ebp
80105047:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010504a:	8b 55 08             	mov    0x8(%ebp),%edx
8010504d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105050:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105053:	f0 87 02             	lock xchg %eax,(%edx)
80105056:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80105059:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010505c:	c9                   	leave  
8010505d:	c3                   	ret    

8010505e <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
8010505e:	55                   	push   %ebp
8010505f:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80105061:	8b 45 08             	mov    0x8(%ebp),%eax
80105064:	8b 55 0c             	mov    0xc(%ebp),%edx
80105067:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
8010506a:	8b 45 08             	mov    0x8(%ebp),%eax
8010506d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80105073:	8b 45 08             	mov    0x8(%ebp),%eax
80105076:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
8010507d:	5d                   	pop    %ebp
8010507e:	c3                   	ret    

8010507f <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
8010507f:	55                   	push   %ebp
80105080:	89 e5                	mov    %esp,%ebp
80105082:	83 ec 18             	sub    $0x18,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105085:	e8 49 01 00 00       	call   801051d3 <pushcli>
  if(holding(lk))
8010508a:	8b 45 08             	mov    0x8(%ebp),%eax
8010508d:	89 04 24             	mov    %eax,(%esp)
80105090:	e8 14 01 00 00       	call   801051a9 <holding>
80105095:	85 c0                	test   %eax,%eax
80105097:	74 0c                	je     801050a5 <acquire+0x26>
    panic("acquire");
80105099:	c7 04 24 05 8b 10 80 	movl   $0x80108b05,(%esp)
801050a0:	e8 95 b4 ff ff       	call   8010053a <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
801050a5:	90                   	nop
801050a6:	8b 45 08             	mov    0x8(%ebp),%eax
801050a9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801050b0:	00 
801050b1:	89 04 24             	mov    %eax,(%esp)
801050b4:	e8 8b ff ff ff       	call   80105044 <xchg>
801050b9:	85 c0                	test   %eax,%eax
801050bb:	75 e9                	jne    801050a6 <acquire+0x27>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
801050bd:	8b 45 08             	mov    0x8(%ebp),%eax
801050c0:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801050c7:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
801050ca:	8b 45 08             	mov    0x8(%ebp),%eax
801050cd:	83 c0 0c             	add    $0xc,%eax
801050d0:	89 44 24 04          	mov    %eax,0x4(%esp)
801050d4:	8d 45 08             	lea    0x8(%ebp),%eax
801050d7:	89 04 24             	mov    %eax,(%esp)
801050da:	e8 51 00 00 00       	call   80105130 <getcallerpcs>
}
801050df:	c9                   	leave  
801050e0:	c3                   	ret    

801050e1 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
801050e1:	55                   	push   %ebp
801050e2:	89 e5                	mov    %esp,%ebp
801050e4:	83 ec 18             	sub    $0x18,%esp
  if(!holding(lk))
801050e7:	8b 45 08             	mov    0x8(%ebp),%eax
801050ea:	89 04 24             	mov    %eax,(%esp)
801050ed:	e8 b7 00 00 00       	call   801051a9 <holding>
801050f2:	85 c0                	test   %eax,%eax
801050f4:	75 0c                	jne    80105102 <release+0x21>
    panic("release");
801050f6:	c7 04 24 0d 8b 10 80 	movl   $0x80108b0d,(%esp)
801050fd:	e8 38 b4 ff ff       	call   8010053a <panic>

  lk->pcs[0] = 0;
80105102:	8b 45 08             	mov    0x8(%ebp),%eax
80105105:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
8010510c:	8b 45 08             	mov    0x8(%ebp),%eax
8010510f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80105116:	8b 45 08             	mov    0x8(%ebp),%eax
80105119:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105120:	00 
80105121:	89 04 24             	mov    %eax,(%esp)
80105124:	e8 1b ff ff ff       	call   80105044 <xchg>

  popcli();
80105129:	e8 e9 00 00 00       	call   80105217 <popcli>
}
8010512e:	c9                   	leave  
8010512f:	c3                   	ret    

80105130 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105130:	55                   	push   %ebp
80105131:	89 e5                	mov    %esp,%ebp
80105133:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80105136:	8b 45 08             	mov    0x8(%ebp),%eax
80105139:	83 e8 08             	sub    $0x8,%eax
8010513c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
8010513f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80105146:	eb 38                	jmp    80105180 <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105148:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
8010514c:	74 38                	je     80105186 <getcallerpcs+0x56>
8010514e:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80105155:	76 2f                	jbe    80105186 <getcallerpcs+0x56>
80105157:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
8010515b:	74 29                	je     80105186 <getcallerpcs+0x56>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010515d:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105160:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105167:	8b 45 0c             	mov    0xc(%ebp),%eax
8010516a:	01 c2                	add    %eax,%edx
8010516c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010516f:	8b 40 04             	mov    0x4(%eax),%eax
80105172:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80105174:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105177:	8b 00                	mov    (%eax),%eax
80105179:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010517c:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105180:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105184:	7e c2                	jle    80105148 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105186:	eb 19                	jmp    801051a1 <getcallerpcs+0x71>
    pcs[i] = 0;
80105188:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010518b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105192:	8b 45 0c             	mov    0xc(%ebp),%eax
80105195:	01 d0                	add    %edx,%eax
80105197:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010519d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801051a1:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801051a5:	7e e1                	jle    80105188 <getcallerpcs+0x58>
    pcs[i] = 0;
}
801051a7:	c9                   	leave  
801051a8:	c3                   	ret    

801051a9 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801051a9:	55                   	push   %ebp
801051aa:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
801051ac:	8b 45 08             	mov    0x8(%ebp),%eax
801051af:	8b 00                	mov    (%eax),%eax
801051b1:	85 c0                	test   %eax,%eax
801051b3:	74 17                	je     801051cc <holding+0x23>
801051b5:	8b 45 08             	mov    0x8(%ebp),%eax
801051b8:	8b 50 08             	mov    0x8(%eax),%edx
801051bb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801051c1:	39 c2                	cmp    %eax,%edx
801051c3:	75 07                	jne    801051cc <holding+0x23>
801051c5:	b8 01 00 00 00       	mov    $0x1,%eax
801051ca:	eb 05                	jmp    801051d1 <holding+0x28>
801051cc:	b8 00 00 00 00       	mov    $0x0,%eax
}
801051d1:	5d                   	pop    %ebp
801051d2:	c3                   	ret    

801051d3 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801051d3:	55                   	push   %ebp
801051d4:	89 e5                	mov    %esp,%ebp
801051d6:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
801051d9:	e8 4a fe ff ff       	call   80105028 <readeflags>
801051de:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
801051e1:	e8 52 fe ff ff       	call   80105038 <cli>
  if(cpu->ncli++ == 0)
801051e6:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801051ed:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
801051f3:	8d 48 01             	lea    0x1(%eax),%ecx
801051f6:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
801051fc:	85 c0                	test   %eax,%eax
801051fe:	75 15                	jne    80105215 <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
80105200:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105206:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105209:	81 e2 00 02 00 00    	and    $0x200,%edx
8010520f:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80105215:	c9                   	leave  
80105216:	c3                   	ret    

80105217 <popcli>:

void
popcli(void)
{
80105217:	55                   	push   %ebp
80105218:	89 e5                	mov    %esp,%ebp
8010521a:	83 ec 18             	sub    $0x18,%esp
  if(readeflags()&FL_IF)
8010521d:	e8 06 fe ff ff       	call   80105028 <readeflags>
80105222:	25 00 02 00 00       	and    $0x200,%eax
80105227:	85 c0                	test   %eax,%eax
80105229:	74 0c                	je     80105237 <popcli+0x20>
    panic("popcli - interruptible");
8010522b:	c7 04 24 15 8b 10 80 	movl   $0x80108b15,(%esp)
80105232:	e8 03 b3 ff ff       	call   8010053a <panic>
  if(--cpu->ncli < 0)
80105237:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010523d:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80105243:	83 ea 01             	sub    $0x1,%edx
80105246:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
8010524c:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105252:	85 c0                	test   %eax,%eax
80105254:	79 0c                	jns    80105262 <popcli+0x4b>
    panic("popcli");
80105256:	c7 04 24 2c 8b 10 80 	movl   $0x80108b2c,(%esp)
8010525d:	e8 d8 b2 ff ff       	call   8010053a <panic>
  if(cpu->ncli == 0 && cpu->intena)
80105262:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105268:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010526e:	85 c0                	test   %eax,%eax
80105270:	75 15                	jne    80105287 <popcli+0x70>
80105272:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105278:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
8010527e:	85 c0                	test   %eax,%eax
80105280:	74 05                	je     80105287 <popcli+0x70>
    sti();
80105282:	e8 b7 fd ff ff       	call   8010503e <sti>
}
80105287:	c9                   	leave  
80105288:	c3                   	ret    
80105289:	66 90                	xchg   %ax,%ax
8010528b:	90                   	nop

8010528c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
8010528c:	55                   	push   %ebp
8010528d:	89 e5                	mov    %esp,%ebp
8010528f:	57                   	push   %edi
80105290:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80105291:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105294:	8b 55 10             	mov    0x10(%ebp),%edx
80105297:	8b 45 0c             	mov    0xc(%ebp),%eax
8010529a:	89 cb                	mov    %ecx,%ebx
8010529c:	89 df                	mov    %ebx,%edi
8010529e:	89 d1                	mov    %edx,%ecx
801052a0:	fc                   	cld    
801052a1:	f3 aa                	rep stos %al,%es:(%edi)
801052a3:	89 ca                	mov    %ecx,%edx
801052a5:	89 fb                	mov    %edi,%ebx
801052a7:	89 5d 08             	mov    %ebx,0x8(%ebp)
801052aa:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
801052ad:	5b                   	pop    %ebx
801052ae:	5f                   	pop    %edi
801052af:	5d                   	pop    %ebp
801052b0:	c3                   	ret    

801052b1 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
801052b1:	55                   	push   %ebp
801052b2:	89 e5                	mov    %esp,%ebp
801052b4:	57                   	push   %edi
801052b5:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
801052b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801052b9:	8b 55 10             	mov    0x10(%ebp),%edx
801052bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801052bf:	89 cb                	mov    %ecx,%ebx
801052c1:	89 df                	mov    %ebx,%edi
801052c3:	89 d1                	mov    %edx,%ecx
801052c5:	fc                   	cld    
801052c6:	f3 ab                	rep stos %eax,%es:(%edi)
801052c8:	89 ca                	mov    %ecx,%edx
801052ca:	89 fb                	mov    %edi,%ebx
801052cc:	89 5d 08             	mov    %ebx,0x8(%ebp)
801052cf:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
801052d2:	5b                   	pop    %ebx
801052d3:	5f                   	pop    %edi
801052d4:	5d                   	pop    %ebp
801052d5:	c3                   	ret    

801052d6 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801052d6:	55                   	push   %ebp
801052d7:	89 e5                	mov    %esp,%ebp
801052d9:	83 ec 0c             	sub    $0xc,%esp
  if ((int)dst%4 == 0 && n%4 == 0){
801052dc:	8b 45 08             	mov    0x8(%ebp),%eax
801052df:	83 e0 03             	and    $0x3,%eax
801052e2:	85 c0                	test   %eax,%eax
801052e4:	75 49                	jne    8010532f <memset+0x59>
801052e6:	8b 45 10             	mov    0x10(%ebp),%eax
801052e9:	83 e0 03             	and    $0x3,%eax
801052ec:	85 c0                	test   %eax,%eax
801052ee:	75 3f                	jne    8010532f <memset+0x59>
    c &= 0xFF;
801052f0:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801052f7:	8b 45 10             	mov    0x10(%ebp),%eax
801052fa:	c1 e8 02             	shr    $0x2,%eax
801052fd:	89 c2                	mov    %eax,%edx
801052ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80105302:	c1 e0 18             	shl    $0x18,%eax
80105305:	89 c1                	mov    %eax,%ecx
80105307:	8b 45 0c             	mov    0xc(%ebp),%eax
8010530a:	c1 e0 10             	shl    $0x10,%eax
8010530d:	09 c1                	or     %eax,%ecx
8010530f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105312:	c1 e0 08             	shl    $0x8,%eax
80105315:	09 c8                	or     %ecx,%eax
80105317:	0b 45 0c             	or     0xc(%ebp),%eax
8010531a:	89 54 24 08          	mov    %edx,0x8(%esp)
8010531e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105322:	8b 45 08             	mov    0x8(%ebp),%eax
80105325:	89 04 24             	mov    %eax,(%esp)
80105328:	e8 84 ff ff ff       	call   801052b1 <stosl>
8010532d:	eb 19                	jmp    80105348 <memset+0x72>
  } else
    stosb(dst, c, n);
8010532f:	8b 45 10             	mov    0x10(%ebp),%eax
80105332:	89 44 24 08          	mov    %eax,0x8(%esp)
80105336:	8b 45 0c             	mov    0xc(%ebp),%eax
80105339:	89 44 24 04          	mov    %eax,0x4(%esp)
8010533d:	8b 45 08             	mov    0x8(%ebp),%eax
80105340:	89 04 24             	mov    %eax,(%esp)
80105343:	e8 44 ff ff ff       	call   8010528c <stosb>
  return dst;
80105348:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010534b:	c9                   	leave  
8010534c:	c3                   	ret    

8010534d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
8010534d:	55                   	push   %ebp
8010534e:	89 e5                	mov    %esp,%ebp
80105350:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
80105353:	8b 45 08             	mov    0x8(%ebp),%eax
80105356:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80105359:	8b 45 0c             	mov    0xc(%ebp),%eax
8010535c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
8010535f:	eb 30                	jmp    80105391 <memcmp+0x44>
    if(*s1 != *s2)
80105361:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105364:	0f b6 10             	movzbl (%eax),%edx
80105367:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010536a:	0f b6 00             	movzbl (%eax),%eax
8010536d:	38 c2                	cmp    %al,%dl
8010536f:	74 18                	je     80105389 <memcmp+0x3c>
      return *s1 - *s2;
80105371:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105374:	0f b6 00             	movzbl (%eax),%eax
80105377:	0f b6 d0             	movzbl %al,%edx
8010537a:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010537d:	0f b6 00             	movzbl (%eax),%eax
80105380:	0f b6 c0             	movzbl %al,%eax
80105383:	29 c2                	sub    %eax,%edx
80105385:	89 d0                	mov    %edx,%eax
80105387:	eb 1a                	jmp    801053a3 <memcmp+0x56>
    s1++, s2++;
80105389:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010538d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105391:	8b 45 10             	mov    0x10(%ebp),%eax
80105394:	8d 50 ff             	lea    -0x1(%eax),%edx
80105397:	89 55 10             	mov    %edx,0x10(%ebp)
8010539a:	85 c0                	test   %eax,%eax
8010539c:	75 c3                	jne    80105361 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010539e:	b8 00 00 00 00       	mov    $0x0,%eax
}
801053a3:	c9                   	leave  
801053a4:	c3                   	ret    

801053a5 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801053a5:	55                   	push   %ebp
801053a6:	89 e5                	mov    %esp,%ebp
801053a8:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
801053ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801053ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
801053b1:	8b 45 08             	mov    0x8(%ebp),%eax
801053b4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
801053b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801053bd:	73 3d                	jae    801053fc <memmove+0x57>
801053bf:	8b 45 10             	mov    0x10(%ebp),%eax
801053c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
801053c5:	01 d0                	add    %edx,%eax
801053c7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801053ca:	76 30                	jbe    801053fc <memmove+0x57>
    s += n;
801053cc:	8b 45 10             	mov    0x10(%ebp),%eax
801053cf:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
801053d2:	8b 45 10             	mov    0x10(%ebp),%eax
801053d5:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
801053d8:	eb 13                	jmp    801053ed <memmove+0x48>
      *--d = *--s;
801053da:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
801053de:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
801053e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053e5:	0f b6 10             	movzbl (%eax),%edx
801053e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
801053eb:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801053ed:	8b 45 10             	mov    0x10(%ebp),%eax
801053f0:	8d 50 ff             	lea    -0x1(%eax),%edx
801053f3:	89 55 10             	mov    %edx,0x10(%ebp)
801053f6:	85 c0                	test   %eax,%eax
801053f8:	75 e0                	jne    801053da <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801053fa:	eb 26                	jmp    80105422 <memmove+0x7d>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801053fc:	eb 17                	jmp    80105415 <memmove+0x70>
      *d++ = *s++;
801053fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105401:	8d 50 01             	lea    0x1(%eax),%edx
80105404:	89 55 f8             	mov    %edx,-0x8(%ebp)
80105407:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010540a:	8d 4a 01             	lea    0x1(%edx),%ecx
8010540d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
80105410:	0f b6 12             	movzbl (%edx),%edx
80105413:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105415:	8b 45 10             	mov    0x10(%ebp),%eax
80105418:	8d 50 ff             	lea    -0x1(%eax),%edx
8010541b:	89 55 10             	mov    %edx,0x10(%ebp)
8010541e:	85 c0                	test   %eax,%eax
80105420:	75 dc                	jne    801053fe <memmove+0x59>
      *d++ = *s++;

  return dst;
80105422:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105425:	c9                   	leave  
80105426:	c3                   	ret    

80105427 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105427:	55                   	push   %ebp
80105428:	89 e5                	mov    %esp,%ebp
8010542a:	83 ec 0c             	sub    $0xc,%esp
  return memmove(dst, src, n);
8010542d:	8b 45 10             	mov    0x10(%ebp),%eax
80105430:	89 44 24 08          	mov    %eax,0x8(%esp)
80105434:	8b 45 0c             	mov    0xc(%ebp),%eax
80105437:	89 44 24 04          	mov    %eax,0x4(%esp)
8010543b:	8b 45 08             	mov    0x8(%ebp),%eax
8010543e:	89 04 24             	mov    %eax,(%esp)
80105441:	e8 5f ff ff ff       	call   801053a5 <memmove>
}
80105446:	c9                   	leave  
80105447:	c3                   	ret    

80105448 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105448:	55                   	push   %ebp
80105449:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
8010544b:	eb 0c                	jmp    80105459 <strncmp+0x11>
    n--, p++, q++;
8010544d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105451:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105455:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80105459:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010545d:	74 1a                	je     80105479 <strncmp+0x31>
8010545f:	8b 45 08             	mov    0x8(%ebp),%eax
80105462:	0f b6 00             	movzbl (%eax),%eax
80105465:	84 c0                	test   %al,%al
80105467:	74 10                	je     80105479 <strncmp+0x31>
80105469:	8b 45 08             	mov    0x8(%ebp),%eax
8010546c:	0f b6 10             	movzbl (%eax),%edx
8010546f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105472:	0f b6 00             	movzbl (%eax),%eax
80105475:	38 c2                	cmp    %al,%dl
80105477:	74 d4                	je     8010544d <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
80105479:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010547d:	75 07                	jne    80105486 <strncmp+0x3e>
    return 0;
8010547f:	b8 00 00 00 00       	mov    $0x0,%eax
80105484:	eb 16                	jmp    8010549c <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
80105486:	8b 45 08             	mov    0x8(%ebp),%eax
80105489:	0f b6 00             	movzbl (%eax),%eax
8010548c:	0f b6 d0             	movzbl %al,%edx
8010548f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105492:	0f b6 00             	movzbl (%eax),%eax
80105495:	0f b6 c0             	movzbl %al,%eax
80105498:	29 c2                	sub    %eax,%edx
8010549a:	89 d0                	mov    %edx,%eax
}
8010549c:	5d                   	pop    %ebp
8010549d:	c3                   	ret    

8010549e <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
8010549e:	55                   	push   %ebp
8010549f:	89 e5                	mov    %esp,%ebp
801054a1:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
801054a4:	8b 45 08             	mov    0x8(%ebp),%eax
801054a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
801054aa:	90                   	nop
801054ab:	8b 45 10             	mov    0x10(%ebp),%eax
801054ae:	8d 50 ff             	lea    -0x1(%eax),%edx
801054b1:	89 55 10             	mov    %edx,0x10(%ebp)
801054b4:	85 c0                	test   %eax,%eax
801054b6:	7e 1e                	jle    801054d6 <strncpy+0x38>
801054b8:	8b 45 08             	mov    0x8(%ebp),%eax
801054bb:	8d 50 01             	lea    0x1(%eax),%edx
801054be:	89 55 08             	mov    %edx,0x8(%ebp)
801054c1:	8b 55 0c             	mov    0xc(%ebp),%edx
801054c4:	8d 4a 01             	lea    0x1(%edx),%ecx
801054c7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801054ca:	0f b6 12             	movzbl (%edx),%edx
801054cd:	88 10                	mov    %dl,(%eax)
801054cf:	0f b6 00             	movzbl (%eax),%eax
801054d2:	84 c0                	test   %al,%al
801054d4:	75 d5                	jne    801054ab <strncpy+0xd>
    ;
  while(n-- > 0)
801054d6:	eb 0c                	jmp    801054e4 <strncpy+0x46>
    *s++ = 0;
801054d8:	8b 45 08             	mov    0x8(%ebp),%eax
801054db:	8d 50 01             	lea    0x1(%eax),%edx
801054de:	89 55 08             	mov    %edx,0x8(%ebp)
801054e1:	c6 00 00             	movb   $0x0,(%eax)
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801054e4:	8b 45 10             	mov    0x10(%ebp),%eax
801054e7:	8d 50 ff             	lea    -0x1(%eax),%edx
801054ea:	89 55 10             	mov    %edx,0x10(%ebp)
801054ed:	85 c0                	test   %eax,%eax
801054ef:	7f e7                	jg     801054d8 <strncpy+0x3a>
    *s++ = 0;
  return os;
801054f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801054f4:	c9                   	leave  
801054f5:	c3                   	ret    

801054f6 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801054f6:	55                   	push   %ebp
801054f7:	89 e5                	mov    %esp,%ebp
801054f9:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
801054fc:	8b 45 08             	mov    0x8(%ebp),%eax
801054ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80105502:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105506:	7f 05                	jg     8010550d <safestrcpy+0x17>
    return os;
80105508:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010550b:	eb 31                	jmp    8010553e <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
8010550d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105511:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105515:	7e 1e                	jle    80105535 <safestrcpy+0x3f>
80105517:	8b 45 08             	mov    0x8(%ebp),%eax
8010551a:	8d 50 01             	lea    0x1(%eax),%edx
8010551d:	89 55 08             	mov    %edx,0x8(%ebp)
80105520:	8b 55 0c             	mov    0xc(%ebp),%edx
80105523:	8d 4a 01             	lea    0x1(%edx),%ecx
80105526:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80105529:	0f b6 12             	movzbl (%edx),%edx
8010552c:	88 10                	mov    %dl,(%eax)
8010552e:	0f b6 00             	movzbl (%eax),%eax
80105531:	84 c0                	test   %al,%al
80105533:	75 d8                	jne    8010550d <safestrcpy+0x17>
    ;
  *s = 0;
80105535:	8b 45 08             	mov    0x8(%ebp),%eax
80105538:	c6 00 00             	movb   $0x0,(%eax)
  return os;
8010553b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010553e:	c9                   	leave  
8010553f:	c3                   	ret    

80105540 <strlen>:

int
strlen(const char *s)
{
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80105546:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010554d:	eb 04                	jmp    80105553 <strlen+0x13>
8010554f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105553:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105556:	8b 45 08             	mov    0x8(%ebp),%eax
80105559:	01 d0                	add    %edx,%eax
8010555b:	0f b6 00             	movzbl (%eax),%eax
8010555e:	84 c0                	test   %al,%al
80105560:	75 ed                	jne    8010554f <strlen+0xf>
    ;
  return n;
80105562:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105565:	c9                   	leave  
80105566:	c3                   	ret    
80105567:	90                   	nop

80105568 <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105568:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010556c:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80105570:	55                   	push   %ebp
  pushl %ebx
80105571:	53                   	push   %ebx
  pushl %esi
80105572:	56                   	push   %esi
  pushl %edi
80105573:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105574:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105576:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80105578:	5f                   	pop    %edi
  popl %esi
80105579:	5e                   	pop    %esi
  popl %ebx
8010557a:	5b                   	pop    %ebx
  popl %ebp
8010557b:	5d                   	pop    %ebp
  ret
8010557c:	c3                   	ret    
8010557d:	66 90                	xchg   %ax,%ax
8010557f:	90                   	nop

80105580 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80105583:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105589:	8b 00                	mov    (%eax),%eax
8010558b:	3b 45 08             	cmp    0x8(%ebp),%eax
8010558e:	76 12                	jbe    801055a2 <fetchint+0x22>
80105590:	8b 45 08             	mov    0x8(%ebp),%eax
80105593:	8d 50 04             	lea    0x4(%eax),%edx
80105596:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010559c:	8b 00                	mov    (%eax),%eax
8010559e:	39 c2                	cmp    %eax,%edx
801055a0:	76 07                	jbe    801055a9 <fetchint+0x29>
    return -1;
801055a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055a7:	eb 0f                	jmp    801055b8 <fetchint+0x38>
  *ip = *(int*)(addr);
801055a9:	8b 45 08             	mov    0x8(%ebp),%eax
801055ac:	8b 10                	mov    (%eax),%edx
801055ae:	8b 45 0c             	mov    0xc(%ebp),%eax
801055b1:	89 10                	mov    %edx,(%eax)
  return 0;
801055b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801055b8:	5d                   	pop    %ebp
801055b9:	c3                   	ret    

801055ba <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801055ba:	55                   	push   %ebp
801055bb:	89 e5                	mov    %esp,%ebp
801055bd:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
801055c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055c6:	8b 00                	mov    (%eax),%eax
801055c8:	3b 45 08             	cmp    0x8(%ebp),%eax
801055cb:	77 07                	ja     801055d4 <fetchstr+0x1a>
    return -1;
801055cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055d2:	eb 46                	jmp    8010561a <fetchstr+0x60>
  *pp = (char*)addr;
801055d4:	8b 55 08             	mov    0x8(%ebp),%edx
801055d7:	8b 45 0c             	mov    0xc(%ebp),%eax
801055da:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
801055dc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055e2:	8b 00                	mov    (%eax),%eax
801055e4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
801055e7:	8b 45 0c             	mov    0xc(%ebp),%eax
801055ea:	8b 00                	mov    (%eax),%eax
801055ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
801055ef:	eb 1c                	jmp    8010560d <fetchstr+0x53>
    if(*s == 0)
801055f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055f4:	0f b6 00             	movzbl (%eax),%eax
801055f7:	84 c0                	test   %al,%al
801055f9:	75 0e                	jne    80105609 <fetchstr+0x4f>
      return s - *pp;
801055fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
801055fe:	8b 45 0c             	mov    0xc(%ebp),%eax
80105601:	8b 00                	mov    (%eax),%eax
80105603:	29 c2                	sub    %eax,%edx
80105605:	89 d0                	mov    %edx,%eax
80105607:	eb 11                	jmp    8010561a <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80105609:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010560d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105610:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105613:	72 dc                	jb     801055f1 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
80105615:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010561a:	c9                   	leave  
8010561b:	c3                   	ret    

8010561c <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
8010561c:	55                   	push   %ebp
8010561d:	89 e5                	mov    %esp,%ebp
8010561f:	83 ec 08             	sub    $0x8,%esp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80105622:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105628:	8b 40 18             	mov    0x18(%eax),%eax
8010562b:	8b 50 44             	mov    0x44(%eax),%edx
8010562e:	8b 45 08             	mov    0x8(%ebp),%eax
80105631:	c1 e0 02             	shl    $0x2,%eax
80105634:	01 d0                	add    %edx,%eax
80105636:	8d 50 04             	lea    0x4(%eax),%edx
80105639:	8b 45 0c             	mov    0xc(%ebp),%eax
8010563c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105640:	89 14 24             	mov    %edx,(%esp)
80105643:	e8 38 ff ff ff       	call   80105580 <fetchint>
}
80105648:	c9                   	leave  
80105649:	c3                   	ret    

8010564a <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
8010564a:	55                   	push   %ebp
8010564b:	89 e5                	mov    %esp,%ebp
8010564d:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  if(argint(n, &i) < 0)
80105650:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105653:	89 44 24 04          	mov    %eax,0x4(%esp)
80105657:	8b 45 08             	mov    0x8(%ebp),%eax
8010565a:	89 04 24             	mov    %eax,(%esp)
8010565d:	e8 ba ff ff ff       	call   8010561c <argint>
80105662:	85 c0                	test   %eax,%eax
80105664:	79 07                	jns    8010566d <argptr+0x23>
    return -1;
80105666:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010566b:	eb 3d                	jmp    801056aa <argptr+0x60>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
8010566d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105670:	89 c2                	mov    %eax,%edx
80105672:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105678:	8b 00                	mov    (%eax),%eax
8010567a:	39 c2                	cmp    %eax,%edx
8010567c:	73 16                	jae    80105694 <argptr+0x4a>
8010567e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105681:	89 c2                	mov    %eax,%edx
80105683:	8b 45 10             	mov    0x10(%ebp),%eax
80105686:	01 c2                	add    %eax,%edx
80105688:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010568e:	8b 00                	mov    (%eax),%eax
80105690:	39 c2                	cmp    %eax,%edx
80105692:	76 07                	jbe    8010569b <argptr+0x51>
    return -1;
80105694:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105699:	eb 0f                	jmp    801056aa <argptr+0x60>
  *pp = (char*)i;
8010569b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010569e:	89 c2                	mov    %eax,%edx
801056a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801056a3:	89 10                	mov    %edx,(%eax)
  return 0;
801056a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
801056aa:	c9                   	leave  
801056ab:	c3                   	ret    

801056ac <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801056ac:	55                   	push   %ebp
801056ad:	89 e5                	mov    %esp,%ebp
801056af:	83 ec 18             	sub    $0x18,%esp
  int addr;
  if(argint(n, &addr) < 0)
801056b2:	8d 45 fc             	lea    -0x4(%ebp),%eax
801056b5:	89 44 24 04          	mov    %eax,0x4(%esp)
801056b9:	8b 45 08             	mov    0x8(%ebp),%eax
801056bc:	89 04 24             	mov    %eax,(%esp)
801056bf:	e8 58 ff ff ff       	call   8010561c <argint>
801056c4:	85 c0                	test   %eax,%eax
801056c6:	79 07                	jns    801056cf <argstr+0x23>
    return -1;
801056c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056cd:	eb 12                	jmp    801056e1 <argstr+0x35>
  return fetchstr(addr, pp);
801056cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
801056d2:	8b 55 0c             	mov    0xc(%ebp),%edx
801056d5:	89 54 24 04          	mov    %edx,0x4(%esp)
801056d9:	89 04 24             	mov    %eax,(%esp)
801056dc:	e8 d9 fe ff ff       	call   801055ba <fetchstr>
}
801056e1:	c9                   	leave  
801056e2:	c3                   	ret    

801056e3 <syscall>:
[SYS_thread_yield]   sys_thread_yield,
};

void
syscall(void)
{
801056e3:	55                   	push   %ebp
801056e4:	89 e5                	mov    %esp,%ebp
801056e6:	53                   	push   %ebx
801056e7:	83 ec 24             	sub    $0x24,%esp
  int num;

  num = proc->tf->eax;
801056ea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056f0:	8b 40 18             	mov    0x18(%eax),%eax
801056f3:	8b 40 1c             	mov    0x1c(%eax),%eax
801056f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801056f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801056fd:	7e 30                	jle    8010572f <syscall+0x4c>
801056ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105702:	83 f8 1a             	cmp    $0x1a,%eax
80105705:	77 28                	ja     8010572f <syscall+0x4c>
80105707:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010570a:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105711:	85 c0                	test   %eax,%eax
80105713:	74 1a                	je     8010572f <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
80105715:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010571b:	8b 58 18             	mov    0x18(%eax),%ebx
8010571e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105721:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105728:	ff d0                	call   *%eax
8010572a:	89 43 1c             	mov    %eax,0x1c(%ebx)
8010572d:	eb 3d                	jmp    8010576c <syscall+0x89>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
8010572f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105735:	8d 48 6c             	lea    0x6c(%eax),%ecx
80105738:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
8010573e:	8b 40 10             	mov    0x10(%eax),%eax
80105741:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105744:	89 54 24 0c          	mov    %edx,0xc(%esp)
80105748:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010574c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105750:	c7 04 24 33 8b 10 80 	movl   $0x80108b33,(%esp)
80105757:	e8 44 ac ff ff       	call   801003a0 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
8010575c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105762:	8b 40 18             	mov    0x18(%eax),%eax
80105765:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
8010576c:	83 c4 24             	add    $0x24,%esp
8010576f:	5b                   	pop    %ebx
80105770:	5d                   	pop    %ebp
80105771:	c3                   	ret    
80105772:	66 90                	xchg   %ax,%ax

80105774 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80105774:	55                   	push   %ebp
80105775:	89 e5                	mov    %esp,%ebp
80105777:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010577a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010577d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105781:	8b 45 08             	mov    0x8(%ebp),%eax
80105784:	89 04 24             	mov    %eax,(%esp)
80105787:	e8 90 fe ff ff       	call   8010561c <argint>
8010578c:	85 c0                	test   %eax,%eax
8010578e:	79 07                	jns    80105797 <argfd+0x23>
    return -1;
80105790:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105795:	eb 50                	jmp    801057e7 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80105797:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010579a:	85 c0                	test   %eax,%eax
8010579c:	78 21                	js     801057bf <argfd+0x4b>
8010579e:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057a1:	83 f8 0f             	cmp    $0xf,%eax
801057a4:	7f 19                	jg     801057bf <argfd+0x4b>
801057a6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057ac:	8b 55 f0             	mov    -0x10(%ebp),%edx
801057af:	83 c2 08             	add    $0x8,%edx
801057b2:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801057b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801057b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801057bd:	75 07                	jne    801057c6 <argfd+0x52>
    return -1;
801057bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057c4:	eb 21                	jmp    801057e7 <argfd+0x73>
  if(pfd)
801057c6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801057ca:	74 08                	je     801057d4 <argfd+0x60>
    *pfd = fd;
801057cc:	8b 55 f0             	mov    -0x10(%ebp),%edx
801057cf:	8b 45 0c             	mov    0xc(%ebp),%eax
801057d2:	89 10                	mov    %edx,(%eax)
  if(pf)
801057d4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801057d8:	74 08                	je     801057e2 <argfd+0x6e>
    *pf = f;
801057da:	8b 45 10             	mov    0x10(%ebp),%eax
801057dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057e0:	89 10                	mov    %edx,(%eax)
  return 0;
801057e2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801057e7:	c9                   	leave  
801057e8:	c3                   	ret    

801057e9 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
801057e9:	55                   	push   %ebp
801057ea:	89 e5                	mov    %esp,%ebp
801057ec:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801057ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801057f6:	eb 30                	jmp    80105828 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
801057f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057fe:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105801:	83 c2 08             	add    $0x8,%edx
80105804:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105808:	85 c0                	test   %eax,%eax
8010580a:	75 18                	jne    80105824 <fdalloc+0x3b>
      proc->ofile[fd] = f;
8010580c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105812:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105815:	8d 4a 08             	lea    0x8(%edx),%ecx
80105818:	8b 55 08             	mov    0x8(%ebp),%edx
8010581b:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
8010581f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105822:	eb 0f                	jmp    80105833 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105824:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105828:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
8010582c:	7e ca                	jle    801057f8 <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
8010582e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105833:	c9                   	leave  
80105834:	c3                   	ret    

80105835 <sys_dup>:

int
sys_dup(void)
{
80105835:	55                   	push   %ebp
80105836:	89 e5                	mov    %esp,%ebp
80105838:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
8010583b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010583e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105842:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105849:	00 
8010584a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105851:	e8 1e ff ff ff       	call   80105774 <argfd>
80105856:	85 c0                	test   %eax,%eax
80105858:	79 07                	jns    80105861 <sys_dup+0x2c>
    return -1;
8010585a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010585f:	eb 29                	jmp    8010588a <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
80105861:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105864:	89 04 24             	mov    %eax,(%esp)
80105867:	e8 7d ff ff ff       	call   801057e9 <fdalloc>
8010586c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010586f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105873:	79 07                	jns    8010587c <sys_dup+0x47>
    return -1;
80105875:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010587a:	eb 0e                	jmp    8010588a <sys_dup+0x55>
  filedup(f);
8010587c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010587f:	89 04 24             	mov    %eax,(%esp)
80105882:	e8 f9 b6 ff ff       	call   80100f80 <filedup>
  return fd;
80105887:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010588a:	c9                   	leave  
8010588b:	c3                   	ret    

8010588c <sys_read>:

int
sys_read(void)
{
8010588c:	55                   	push   %ebp
8010588d:	89 e5                	mov    %esp,%ebp
8010588f:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105892:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105895:	89 44 24 08          	mov    %eax,0x8(%esp)
80105899:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801058a0:	00 
801058a1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801058a8:	e8 c7 fe ff ff       	call   80105774 <argfd>
801058ad:	85 c0                	test   %eax,%eax
801058af:	78 35                	js     801058e6 <sys_read+0x5a>
801058b1:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058b4:	89 44 24 04          	mov    %eax,0x4(%esp)
801058b8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801058bf:	e8 58 fd ff ff       	call   8010561c <argint>
801058c4:	85 c0                	test   %eax,%eax
801058c6:	78 1e                	js     801058e6 <sys_read+0x5a>
801058c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058cb:	89 44 24 08          	mov    %eax,0x8(%esp)
801058cf:	8d 45 ec             	lea    -0x14(%ebp),%eax
801058d2:	89 44 24 04          	mov    %eax,0x4(%esp)
801058d6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801058dd:	e8 68 fd ff ff       	call   8010564a <argptr>
801058e2:	85 c0                	test   %eax,%eax
801058e4:	79 07                	jns    801058ed <sys_read+0x61>
    return -1;
801058e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058eb:	eb 19                	jmp    80105906 <sys_read+0x7a>
  return fileread(f, p, n);
801058ed:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801058f0:	8b 55 ec             	mov    -0x14(%ebp),%edx
801058f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058f6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801058fa:	89 54 24 04          	mov    %edx,0x4(%esp)
801058fe:	89 04 24             	mov    %eax,(%esp)
80105901:	e8 e7 b7 ff ff       	call   801010ed <fileread>
}
80105906:	c9                   	leave  
80105907:	c3                   	ret    

80105908 <sys_write>:

int
sys_write(void)
{
80105908:	55                   	push   %ebp
80105909:	89 e5                	mov    %esp,%ebp
8010590b:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010590e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105911:	89 44 24 08          	mov    %eax,0x8(%esp)
80105915:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010591c:	00 
8010591d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105924:	e8 4b fe ff ff       	call   80105774 <argfd>
80105929:	85 c0                	test   %eax,%eax
8010592b:	78 35                	js     80105962 <sys_write+0x5a>
8010592d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105930:	89 44 24 04          	mov    %eax,0x4(%esp)
80105934:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010593b:	e8 dc fc ff ff       	call   8010561c <argint>
80105940:	85 c0                	test   %eax,%eax
80105942:	78 1e                	js     80105962 <sys_write+0x5a>
80105944:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105947:	89 44 24 08          	mov    %eax,0x8(%esp)
8010594b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010594e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105952:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105959:	e8 ec fc ff ff       	call   8010564a <argptr>
8010595e:	85 c0                	test   %eax,%eax
80105960:	79 07                	jns    80105969 <sys_write+0x61>
    return -1;
80105962:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105967:	eb 19                	jmp    80105982 <sys_write+0x7a>
  return filewrite(f, p, n);
80105969:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010596c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010596f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105972:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80105976:	89 54 24 04          	mov    %edx,0x4(%esp)
8010597a:	89 04 24             	mov    %eax,(%esp)
8010597d:	e8 27 b8 ff ff       	call   801011a9 <filewrite>
}
80105982:	c9                   	leave  
80105983:	c3                   	ret    

80105984 <sys_close>:

int
sys_close(void)
{
80105984:	55                   	push   %ebp
80105985:	89 e5                	mov    %esp,%ebp
80105987:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
8010598a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010598d:	89 44 24 08          	mov    %eax,0x8(%esp)
80105991:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105994:	89 44 24 04          	mov    %eax,0x4(%esp)
80105998:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010599f:	e8 d0 fd ff ff       	call   80105774 <argfd>
801059a4:	85 c0                	test   %eax,%eax
801059a6:	79 07                	jns    801059af <sys_close+0x2b>
    return -1;
801059a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059ad:	eb 24                	jmp    801059d3 <sys_close+0x4f>
  proc->ofile[fd] = 0;
801059af:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059b8:	83 c2 08             	add    $0x8,%edx
801059bb:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801059c2:	00 
  fileclose(f);
801059c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059c6:	89 04 24             	mov    %eax,(%esp)
801059c9:	e8 fa b5 ff ff       	call   80100fc8 <fileclose>
  return 0;
801059ce:	b8 00 00 00 00       	mov    $0x0,%eax
}
801059d3:	c9                   	leave  
801059d4:	c3                   	ret    

801059d5 <sys_fstat>:

int
sys_fstat(void)
{
801059d5:	55                   	push   %ebp
801059d6:	89 e5                	mov    %esp,%ebp
801059d8:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801059db:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059de:	89 44 24 08          	mov    %eax,0x8(%esp)
801059e2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801059e9:	00 
801059ea:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801059f1:	e8 7e fd ff ff       	call   80105774 <argfd>
801059f6:	85 c0                	test   %eax,%eax
801059f8:	78 1f                	js     80105a19 <sys_fstat+0x44>
801059fa:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80105a01:	00 
80105a02:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a05:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a09:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105a10:	e8 35 fc ff ff       	call   8010564a <argptr>
80105a15:	85 c0                	test   %eax,%eax
80105a17:	79 07                	jns    80105a20 <sys_fstat+0x4b>
    return -1;
80105a19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a1e:	eb 12                	jmp    80105a32 <sys_fstat+0x5d>
  return filestat(f, st);
80105a20:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105a23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a26:	89 54 24 04          	mov    %edx,0x4(%esp)
80105a2a:	89 04 24             	mov    %eax,(%esp)
80105a2d:	e8 6c b6 ff ff       	call   8010109e <filestat>
}
80105a32:	c9                   	leave  
80105a33:	c3                   	ret    

80105a34 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105a34:	55                   	push   %ebp
80105a35:	89 e5                	mov    %esp,%ebp
80105a37:	83 ec 38             	sub    $0x38,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105a3a:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105a3d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a41:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105a48:	e8 5f fc ff ff       	call   801056ac <argstr>
80105a4d:	85 c0                	test   %eax,%eax
80105a4f:	78 17                	js     80105a68 <sys_link+0x34>
80105a51:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105a54:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a58:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105a5f:	e8 48 fc ff ff       	call   801056ac <argstr>
80105a64:	85 c0                	test   %eax,%eax
80105a66:	79 0a                	jns    80105a72 <sys_link+0x3e>
    return -1;
80105a68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a6d:	e9 3d 01 00 00       	jmp    80105baf <sys_link+0x17b>
  if((ip = namei(old)) == 0)
80105a72:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105a75:	89 04 24             	mov    %eax,(%esp)
80105a78:	e8 84 c9 ff ff       	call   80102401 <namei>
80105a7d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105a80:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105a84:	75 0a                	jne    80105a90 <sys_link+0x5c>
    return -1;
80105a86:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a8b:	e9 1f 01 00 00       	jmp    80105baf <sys_link+0x17b>

  begin_trans();
80105a90:	e8 51 d7 ff ff       	call   801031e6 <begin_trans>

  ilock(ip);
80105a95:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a98:	89 04 24             	mov    %eax,(%esp)
80105a9b:	e8 b6 bd ff ff       	call   80101856 <ilock>
  if(ip->type == T_DIR){
80105aa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105aa3:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105aa7:	66 83 f8 01          	cmp    $0x1,%ax
80105aab:	75 1a                	jne    80105ac7 <sys_link+0x93>
    iunlockput(ip);
80105aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ab0:	89 04 24             	mov    %eax,(%esp)
80105ab3:	e8 22 c0 ff ff       	call   80101ada <iunlockput>
    commit_trans();
80105ab8:	e8 72 d7 ff ff       	call   8010322f <commit_trans>
    return -1;
80105abd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ac2:	e9 e8 00 00 00       	jmp    80105baf <sys_link+0x17b>
  }

  ip->nlink++;
80105ac7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105aca:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105ace:	8d 50 01             	lea    0x1(%eax),%edx
80105ad1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ad4:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105adb:	89 04 24             	mov    %eax,(%esp)
80105ade:	e8 b7 bb ff ff       	call   8010169a <iupdate>
  iunlock(ip);
80105ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ae6:	89 04 24             	mov    %eax,(%esp)
80105ae9:	e8 b6 be ff ff       	call   801019a4 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80105aee:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105af1:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105af4:	89 54 24 04          	mov    %edx,0x4(%esp)
80105af8:	89 04 24             	mov    %eax,(%esp)
80105afb:	e8 23 c9 ff ff       	call   80102423 <nameiparent>
80105b00:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105b03:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105b07:	75 02                	jne    80105b0b <sys_link+0xd7>
    goto bad;
80105b09:	eb 68                	jmp    80105b73 <sys_link+0x13f>
  ilock(dp);
80105b0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b0e:	89 04 24             	mov    %eax,(%esp)
80105b11:	e8 40 bd ff ff       	call   80101856 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105b16:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b19:	8b 10                	mov    (%eax),%edx
80105b1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b1e:	8b 00                	mov    (%eax),%eax
80105b20:	39 c2                	cmp    %eax,%edx
80105b22:	75 20                	jne    80105b44 <sys_link+0x110>
80105b24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b27:	8b 40 04             	mov    0x4(%eax),%eax
80105b2a:	89 44 24 08          	mov    %eax,0x8(%esp)
80105b2e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105b31:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b35:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b38:	89 04 24             	mov    %eax,(%esp)
80105b3b:	e8 01 c6 ff ff       	call   80102141 <dirlink>
80105b40:	85 c0                	test   %eax,%eax
80105b42:	79 0d                	jns    80105b51 <sys_link+0x11d>
    iunlockput(dp);
80105b44:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b47:	89 04 24             	mov    %eax,(%esp)
80105b4a:	e8 8b bf ff ff       	call   80101ada <iunlockput>
    goto bad;
80105b4f:	eb 22                	jmp    80105b73 <sys_link+0x13f>
  }
  iunlockput(dp);
80105b51:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b54:	89 04 24             	mov    %eax,(%esp)
80105b57:	e8 7e bf ff ff       	call   80101ada <iunlockput>
  iput(ip);
80105b5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b5f:	89 04 24             	mov    %eax,(%esp)
80105b62:	e8 a2 be ff ff       	call   80101a09 <iput>

  commit_trans();
80105b67:	e8 c3 d6 ff ff       	call   8010322f <commit_trans>

  return 0;
80105b6c:	b8 00 00 00 00       	mov    $0x0,%eax
80105b71:	eb 3c                	jmp    80105baf <sys_link+0x17b>

bad:
  ilock(ip);
80105b73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b76:	89 04 24             	mov    %eax,(%esp)
80105b79:	e8 d8 bc ff ff       	call   80101856 <ilock>
  ip->nlink--;
80105b7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b81:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105b85:	8d 50 ff             	lea    -0x1(%eax),%edx
80105b88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b8b:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105b8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b92:	89 04 24             	mov    %eax,(%esp)
80105b95:	e8 00 bb ff ff       	call   8010169a <iupdate>
  iunlockput(ip);
80105b9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b9d:	89 04 24             	mov    %eax,(%esp)
80105ba0:	e8 35 bf ff ff       	call   80101ada <iunlockput>
  commit_trans();
80105ba5:	e8 85 d6 ff ff       	call   8010322f <commit_trans>
  return -1;
80105baa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105baf:	c9                   	leave  
80105bb0:	c3                   	ret    

80105bb1 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105bb1:	55                   	push   %ebp
80105bb2:	89 e5                	mov    %esp,%ebp
80105bb4:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105bb7:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105bbe:	eb 4b                	jmp    80105c0b <isdirempty+0x5a>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105bc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bc3:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105bca:	00 
80105bcb:	89 44 24 08          	mov    %eax,0x8(%esp)
80105bcf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105bd2:	89 44 24 04          	mov    %eax,0x4(%esp)
80105bd6:	8b 45 08             	mov    0x8(%ebp),%eax
80105bd9:	89 04 24             	mov    %eax,(%esp)
80105bdc:	e8 82 c1 ff ff       	call   80101d63 <readi>
80105be1:	83 f8 10             	cmp    $0x10,%eax
80105be4:	74 0c                	je     80105bf2 <isdirempty+0x41>
      panic("isdirempty: readi");
80105be6:	c7 04 24 4f 8b 10 80 	movl   $0x80108b4f,(%esp)
80105bed:	e8 48 a9 ff ff       	call   8010053a <panic>
    if(de.inum != 0)
80105bf2:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105bf6:	66 85 c0             	test   %ax,%ax
80105bf9:	74 07                	je     80105c02 <isdirempty+0x51>
      return 0;
80105bfb:	b8 00 00 00 00       	mov    $0x0,%eax
80105c00:	eb 1b                	jmp    80105c1d <isdirempty+0x6c>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105c02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c05:	83 c0 10             	add    $0x10,%eax
80105c08:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c0b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c0e:	8b 45 08             	mov    0x8(%ebp),%eax
80105c11:	8b 40 18             	mov    0x18(%eax),%eax
80105c14:	39 c2                	cmp    %eax,%edx
80105c16:	72 a8                	jb     80105bc0 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80105c18:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105c1d:	c9                   	leave  
80105c1e:	c3                   	ret    

80105c1f <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105c1f:	55                   	push   %ebp
80105c20:	89 e5                	mov    %esp,%ebp
80105c22:	83 ec 48             	sub    $0x48,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105c25:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105c28:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c2c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105c33:	e8 74 fa ff ff       	call   801056ac <argstr>
80105c38:	85 c0                	test   %eax,%eax
80105c3a:	79 0a                	jns    80105c46 <sys_unlink+0x27>
    return -1;
80105c3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c41:	e9 aa 01 00 00       	jmp    80105df0 <sys_unlink+0x1d1>
  if((dp = nameiparent(path, name)) == 0)
80105c46:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105c49:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105c4c:	89 54 24 04          	mov    %edx,0x4(%esp)
80105c50:	89 04 24             	mov    %eax,(%esp)
80105c53:	e8 cb c7 ff ff       	call   80102423 <nameiparent>
80105c58:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c5b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105c5f:	75 0a                	jne    80105c6b <sys_unlink+0x4c>
    return -1;
80105c61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c66:	e9 85 01 00 00       	jmp    80105df0 <sys_unlink+0x1d1>

  begin_trans();
80105c6b:	e8 76 d5 ff ff       	call   801031e6 <begin_trans>

  ilock(dp);
80105c70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c73:	89 04 24             	mov    %eax,(%esp)
80105c76:	e8 db bb ff ff       	call   80101856 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105c7b:	c7 44 24 04 61 8b 10 	movl   $0x80108b61,0x4(%esp)
80105c82:	80 
80105c83:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105c86:	89 04 24             	mov    %eax,(%esp)
80105c89:	e8 c8 c3 ff ff       	call   80102056 <namecmp>
80105c8e:	85 c0                	test   %eax,%eax
80105c90:	0f 84 45 01 00 00    	je     80105ddb <sys_unlink+0x1bc>
80105c96:	c7 44 24 04 63 8b 10 	movl   $0x80108b63,0x4(%esp)
80105c9d:	80 
80105c9e:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105ca1:	89 04 24             	mov    %eax,(%esp)
80105ca4:	e8 ad c3 ff ff       	call   80102056 <namecmp>
80105ca9:	85 c0                	test   %eax,%eax
80105cab:	0f 84 2a 01 00 00    	je     80105ddb <sys_unlink+0x1bc>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105cb1:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105cb4:	89 44 24 08          	mov    %eax,0x8(%esp)
80105cb8:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105cbb:	89 44 24 04          	mov    %eax,0x4(%esp)
80105cbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cc2:	89 04 24             	mov    %eax,(%esp)
80105cc5:	e8 ae c3 ff ff       	call   80102078 <dirlookup>
80105cca:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105ccd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105cd1:	75 05                	jne    80105cd8 <sys_unlink+0xb9>
    goto bad;
80105cd3:	e9 03 01 00 00       	jmp    80105ddb <sys_unlink+0x1bc>
  ilock(ip);
80105cd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cdb:	89 04 24             	mov    %eax,(%esp)
80105cde:	e8 73 bb ff ff       	call   80101856 <ilock>

  if(ip->nlink < 1)
80105ce3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ce6:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105cea:	66 85 c0             	test   %ax,%ax
80105ced:	7f 0c                	jg     80105cfb <sys_unlink+0xdc>
    panic("unlink: nlink < 1");
80105cef:	c7 04 24 66 8b 10 80 	movl   $0x80108b66,(%esp)
80105cf6:	e8 3f a8 ff ff       	call   8010053a <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105cfb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cfe:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105d02:	66 83 f8 01          	cmp    $0x1,%ax
80105d06:	75 1f                	jne    80105d27 <sys_unlink+0x108>
80105d08:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d0b:	89 04 24             	mov    %eax,(%esp)
80105d0e:	e8 9e fe ff ff       	call   80105bb1 <isdirempty>
80105d13:	85 c0                	test   %eax,%eax
80105d15:	75 10                	jne    80105d27 <sys_unlink+0x108>
    iunlockput(ip);
80105d17:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d1a:	89 04 24             	mov    %eax,(%esp)
80105d1d:	e8 b8 bd ff ff       	call   80101ada <iunlockput>
    goto bad;
80105d22:	e9 b4 00 00 00       	jmp    80105ddb <sys_unlink+0x1bc>
  }

  memset(&de, 0, sizeof(de));
80105d27:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80105d2e:	00 
80105d2f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105d36:	00 
80105d37:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d3a:	89 04 24             	mov    %eax,(%esp)
80105d3d:	e8 94 f5 ff ff       	call   801052d6 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105d42:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105d45:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105d4c:	00 
80105d4d:	89 44 24 08          	mov    %eax,0x8(%esp)
80105d51:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d54:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d5b:	89 04 24             	mov    %eax,(%esp)
80105d5e:	e8 64 c1 ff ff       	call   80101ec7 <writei>
80105d63:	83 f8 10             	cmp    $0x10,%eax
80105d66:	74 0c                	je     80105d74 <sys_unlink+0x155>
    panic("unlink: writei");
80105d68:	c7 04 24 78 8b 10 80 	movl   $0x80108b78,(%esp)
80105d6f:	e8 c6 a7 ff ff       	call   8010053a <panic>
  if(ip->type == T_DIR){
80105d74:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d77:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105d7b:	66 83 f8 01          	cmp    $0x1,%ax
80105d7f:	75 1c                	jne    80105d9d <sys_unlink+0x17e>
    dp->nlink--;
80105d81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d84:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105d88:	8d 50 ff             	lea    -0x1(%eax),%edx
80105d8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d8e:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105d92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d95:	89 04 24             	mov    %eax,(%esp)
80105d98:	e8 fd b8 ff ff       	call   8010169a <iupdate>
  }
  iunlockput(dp);
80105d9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105da0:	89 04 24             	mov    %eax,(%esp)
80105da3:	e8 32 bd ff ff       	call   80101ada <iunlockput>

  ip->nlink--;
80105da8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dab:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105daf:	8d 50 ff             	lea    -0x1(%eax),%edx
80105db2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105db5:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105db9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dbc:	89 04 24             	mov    %eax,(%esp)
80105dbf:	e8 d6 b8 ff ff       	call   8010169a <iupdate>
  iunlockput(ip);
80105dc4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dc7:	89 04 24             	mov    %eax,(%esp)
80105dca:	e8 0b bd ff ff       	call   80101ada <iunlockput>

  commit_trans();
80105dcf:	e8 5b d4 ff ff       	call   8010322f <commit_trans>

  return 0;
80105dd4:	b8 00 00 00 00       	mov    $0x0,%eax
80105dd9:	eb 15                	jmp    80105df0 <sys_unlink+0x1d1>

bad:
  iunlockput(dp);
80105ddb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dde:	89 04 24             	mov    %eax,(%esp)
80105de1:	e8 f4 bc ff ff       	call   80101ada <iunlockput>
  commit_trans();
80105de6:	e8 44 d4 ff ff       	call   8010322f <commit_trans>
  return -1;
80105deb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105df0:	c9                   	leave  
80105df1:	c3                   	ret    

80105df2 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105df2:	55                   	push   %ebp
80105df3:	89 e5                	mov    %esp,%ebp
80105df5:	83 ec 48             	sub    $0x48,%esp
80105df8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105dfb:	8b 55 10             	mov    0x10(%ebp),%edx
80105dfe:	8b 45 14             	mov    0x14(%ebp),%eax
80105e01:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105e05:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105e09:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105e0d:	8d 45 de             	lea    -0x22(%ebp),%eax
80105e10:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e14:	8b 45 08             	mov    0x8(%ebp),%eax
80105e17:	89 04 24             	mov    %eax,(%esp)
80105e1a:	e8 04 c6 ff ff       	call   80102423 <nameiparent>
80105e1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105e22:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105e26:	75 0a                	jne    80105e32 <create+0x40>
    return 0;
80105e28:	b8 00 00 00 00       	mov    $0x0,%eax
80105e2d:	e9 7e 01 00 00       	jmp    80105fb0 <create+0x1be>
  ilock(dp);
80105e32:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e35:	89 04 24             	mov    %eax,(%esp)
80105e38:	e8 19 ba ff ff       	call   80101856 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105e3d:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105e40:	89 44 24 08          	mov    %eax,0x8(%esp)
80105e44:	8d 45 de             	lea    -0x22(%ebp),%eax
80105e47:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e4e:	89 04 24             	mov    %eax,(%esp)
80105e51:	e8 22 c2 ff ff       	call   80102078 <dirlookup>
80105e56:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105e59:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e5d:	74 47                	je     80105ea6 <create+0xb4>
    iunlockput(dp);
80105e5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e62:	89 04 24             	mov    %eax,(%esp)
80105e65:	e8 70 bc ff ff       	call   80101ada <iunlockput>
    ilock(ip);
80105e6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e6d:	89 04 24             	mov    %eax,(%esp)
80105e70:	e8 e1 b9 ff ff       	call   80101856 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105e75:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105e7a:	75 15                	jne    80105e91 <create+0x9f>
80105e7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e7f:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105e83:	66 83 f8 02          	cmp    $0x2,%ax
80105e87:	75 08                	jne    80105e91 <create+0x9f>
      return ip;
80105e89:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e8c:	e9 1f 01 00 00       	jmp    80105fb0 <create+0x1be>
    iunlockput(ip);
80105e91:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e94:	89 04 24             	mov    %eax,(%esp)
80105e97:	e8 3e bc ff ff       	call   80101ada <iunlockput>
    return 0;
80105e9c:	b8 00 00 00 00       	mov    $0x0,%eax
80105ea1:	e9 0a 01 00 00       	jmp    80105fb0 <create+0x1be>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105ea6:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105eaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ead:	8b 00                	mov    (%eax),%eax
80105eaf:	89 54 24 04          	mov    %edx,0x4(%esp)
80105eb3:	89 04 24             	mov    %eax,(%esp)
80105eb6:	e8 00 b7 ff ff       	call   801015bb <ialloc>
80105ebb:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105ebe:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105ec2:	75 0c                	jne    80105ed0 <create+0xde>
    panic("create: ialloc");
80105ec4:	c7 04 24 87 8b 10 80 	movl   $0x80108b87,(%esp)
80105ecb:	e8 6a a6 ff ff       	call   8010053a <panic>

  ilock(ip);
80105ed0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ed3:	89 04 24             	mov    %eax,(%esp)
80105ed6:	e8 7b b9 ff ff       	call   80101856 <ilock>
  ip->major = major;
80105edb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ede:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105ee2:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105ee6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ee9:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105eed:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105ef1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ef4:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105efa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105efd:	89 04 24             	mov    %eax,(%esp)
80105f00:	e8 95 b7 ff ff       	call   8010169a <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80105f05:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105f0a:	75 6a                	jne    80105f76 <create+0x184>
    dp->nlink++;  // for ".."
80105f0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f0f:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105f13:	8d 50 01             	lea    0x1(%eax),%edx
80105f16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f19:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105f1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f20:	89 04 24             	mov    %eax,(%esp)
80105f23:	e8 72 b7 ff ff       	call   8010169a <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105f28:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f2b:	8b 40 04             	mov    0x4(%eax),%eax
80105f2e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105f32:	c7 44 24 04 61 8b 10 	movl   $0x80108b61,0x4(%esp)
80105f39:	80 
80105f3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f3d:	89 04 24             	mov    %eax,(%esp)
80105f40:	e8 fc c1 ff ff       	call   80102141 <dirlink>
80105f45:	85 c0                	test   %eax,%eax
80105f47:	78 21                	js     80105f6a <create+0x178>
80105f49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f4c:	8b 40 04             	mov    0x4(%eax),%eax
80105f4f:	89 44 24 08          	mov    %eax,0x8(%esp)
80105f53:	c7 44 24 04 63 8b 10 	movl   $0x80108b63,0x4(%esp)
80105f5a:	80 
80105f5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f5e:	89 04 24             	mov    %eax,(%esp)
80105f61:	e8 db c1 ff ff       	call   80102141 <dirlink>
80105f66:	85 c0                	test   %eax,%eax
80105f68:	79 0c                	jns    80105f76 <create+0x184>
      panic("create dots");
80105f6a:	c7 04 24 96 8b 10 80 	movl   $0x80108b96,(%esp)
80105f71:	e8 c4 a5 ff ff       	call   8010053a <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105f76:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f79:	8b 40 04             	mov    0x4(%eax),%eax
80105f7c:	89 44 24 08          	mov    %eax,0x8(%esp)
80105f80:	8d 45 de             	lea    -0x22(%ebp),%eax
80105f83:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f8a:	89 04 24             	mov    %eax,(%esp)
80105f8d:	e8 af c1 ff ff       	call   80102141 <dirlink>
80105f92:	85 c0                	test   %eax,%eax
80105f94:	79 0c                	jns    80105fa2 <create+0x1b0>
    panic("create: dirlink");
80105f96:	c7 04 24 a2 8b 10 80 	movl   $0x80108ba2,(%esp)
80105f9d:	e8 98 a5 ff ff       	call   8010053a <panic>

  iunlockput(dp);
80105fa2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fa5:	89 04 24             	mov    %eax,(%esp)
80105fa8:	e8 2d bb ff ff       	call   80101ada <iunlockput>

  return ip;
80105fad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105fb0:	c9                   	leave  
80105fb1:	c3                   	ret    

80105fb2 <sys_open>:

int
sys_open(void)
{
80105fb2:	55                   	push   %ebp
80105fb3:	89 e5                	mov    %esp,%ebp
80105fb5:	83 ec 38             	sub    $0x38,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105fb8:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105fbb:	89 44 24 04          	mov    %eax,0x4(%esp)
80105fbf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105fc6:	e8 e1 f6 ff ff       	call   801056ac <argstr>
80105fcb:	85 c0                	test   %eax,%eax
80105fcd:	78 17                	js     80105fe6 <sys_open+0x34>
80105fcf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105fd2:	89 44 24 04          	mov    %eax,0x4(%esp)
80105fd6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105fdd:	e8 3a f6 ff ff       	call   8010561c <argint>
80105fe2:	85 c0                	test   %eax,%eax
80105fe4:	79 0a                	jns    80105ff0 <sys_open+0x3e>
    return -1;
80105fe6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105feb:	e9 48 01 00 00       	jmp    80106138 <sys_open+0x186>
  if(omode & O_CREATE){
80105ff0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ff3:	25 00 02 00 00       	and    $0x200,%eax
80105ff8:	85 c0                	test   %eax,%eax
80105ffa:	74 40                	je     8010603c <sys_open+0x8a>
    begin_trans();
80105ffc:	e8 e5 d1 ff ff       	call   801031e6 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80106001:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106004:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
8010600b:	00 
8010600c:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80106013:	00 
80106014:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
8010601b:	00 
8010601c:	89 04 24             	mov    %eax,(%esp)
8010601f:	e8 ce fd ff ff       	call   80105df2 <create>
80106024:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80106027:	e8 03 d2 ff ff       	call   8010322f <commit_trans>
    if(ip == 0)
8010602c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106030:	75 5c                	jne    8010608e <sys_open+0xdc>
      return -1;
80106032:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106037:	e9 fc 00 00 00       	jmp    80106138 <sys_open+0x186>
  } else {
    if((ip = namei(path)) == 0)
8010603c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010603f:	89 04 24             	mov    %eax,(%esp)
80106042:	e8 ba c3 ff ff       	call   80102401 <namei>
80106047:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010604a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010604e:	75 0a                	jne    8010605a <sys_open+0xa8>
      return -1;
80106050:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106055:	e9 de 00 00 00       	jmp    80106138 <sys_open+0x186>
    ilock(ip);
8010605a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010605d:	89 04 24             	mov    %eax,(%esp)
80106060:	e8 f1 b7 ff ff       	call   80101856 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106065:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106068:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010606c:	66 83 f8 01          	cmp    $0x1,%ax
80106070:	75 1c                	jne    8010608e <sys_open+0xdc>
80106072:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106075:	85 c0                	test   %eax,%eax
80106077:	74 15                	je     8010608e <sys_open+0xdc>
      iunlockput(ip);
80106079:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010607c:	89 04 24             	mov    %eax,(%esp)
8010607f:	e8 56 ba ff ff       	call   80101ada <iunlockput>
      return -1;
80106084:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106089:	e9 aa 00 00 00       	jmp    80106138 <sys_open+0x186>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010608e:	e8 8d ae ff ff       	call   80100f20 <filealloc>
80106093:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106096:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010609a:	74 14                	je     801060b0 <sys_open+0xfe>
8010609c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010609f:	89 04 24             	mov    %eax,(%esp)
801060a2:	e8 42 f7 ff ff       	call   801057e9 <fdalloc>
801060a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
801060aa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801060ae:	79 23                	jns    801060d3 <sys_open+0x121>
    if(f)
801060b0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801060b4:	74 0b                	je     801060c1 <sys_open+0x10f>
      fileclose(f);
801060b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060b9:	89 04 24             	mov    %eax,(%esp)
801060bc:	e8 07 af ff ff       	call   80100fc8 <fileclose>
    iunlockput(ip);
801060c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060c4:	89 04 24             	mov    %eax,(%esp)
801060c7:	e8 0e ba ff ff       	call   80101ada <iunlockput>
    return -1;
801060cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060d1:	eb 65                	jmp    80106138 <sys_open+0x186>
  }
  iunlock(ip);
801060d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060d6:	89 04 24             	mov    %eax,(%esp)
801060d9:	e8 c6 b8 ff ff       	call   801019a4 <iunlock>

  f->type = FD_INODE;
801060de:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060e1:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
801060e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
801060ed:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
801060f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060f3:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
801060fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801060fd:	83 e0 01             	and    $0x1,%eax
80106100:	85 c0                	test   %eax,%eax
80106102:	0f 94 c0             	sete   %al
80106105:	89 c2                	mov    %eax,%edx
80106107:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010610a:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010610d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106110:	83 e0 01             	and    $0x1,%eax
80106113:	85 c0                	test   %eax,%eax
80106115:	75 0a                	jne    80106121 <sys_open+0x16f>
80106117:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010611a:	83 e0 02             	and    $0x2,%eax
8010611d:	85 c0                	test   %eax,%eax
8010611f:	74 07                	je     80106128 <sys_open+0x176>
80106121:	b8 01 00 00 00       	mov    $0x1,%eax
80106126:	eb 05                	jmp    8010612d <sys_open+0x17b>
80106128:	b8 00 00 00 00       	mov    $0x0,%eax
8010612d:	89 c2                	mov    %eax,%edx
8010612f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106132:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80106135:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80106138:	c9                   	leave  
80106139:	c3                   	ret    

8010613a <sys_mkdir>:

int
sys_mkdir(void)
{
8010613a:	55                   	push   %ebp
8010613b:	89 e5                	mov    %esp,%ebp
8010613d:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_trans();
80106140:	e8 a1 d0 ff ff       	call   801031e6 <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106145:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106148:	89 44 24 04          	mov    %eax,0x4(%esp)
8010614c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106153:	e8 54 f5 ff ff       	call   801056ac <argstr>
80106158:	85 c0                	test   %eax,%eax
8010615a:	78 2c                	js     80106188 <sys_mkdir+0x4e>
8010615c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010615f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
80106166:	00 
80106167:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010616e:	00 
8010616f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80106176:	00 
80106177:	89 04 24             	mov    %eax,(%esp)
8010617a:	e8 73 fc ff ff       	call   80105df2 <create>
8010617f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106182:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106186:	75 0c                	jne    80106194 <sys_mkdir+0x5a>
    commit_trans();
80106188:	e8 a2 d0 ff ff       	call   8010322f <commit_trans>
    return -1;
8010618d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106192:	eb 15                	jmp    801061a9 <sys_mkdir+0x6f>
  }
  iunlockput(ip);
80106194:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106197:	89 04 24             	mov    %eax,(%esp)
8010619a:	e8 3b b9 ff ff       	call   80101ada <iunlockput>
  commit_trans();
8010619f:	e8 8b d0 ff ff       	call   8010322f <commit_trans>
  return 0;
801061a4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801061a9:	c9                   	leave  
801061aa:	c3                   	ret    

801061ab <sys_mknod>:

int
sys_mknod(void)
{
801061ab:	55                   	push   %ebp
801061ac:	89 e5                	mov    %esp,%ebp
801061ae:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
801061b1:	e8 30 d0 ff ff       	call   801031e6 <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
801061b6:	8d 45 ec             	lea    -0x14(%ebp),%eax
801061b9:	89 44 24 04          	mov    %eax,0x4(%esp)
801061bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801061c4:	e8 e3 f4 ff ff       	call   801056ac <argstr>
801061c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801061cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061d0:	78 5e                	js     80106230 <sys_mknod+0x85>
     argint(1, &major) < 0 ||
801061d2:	8d 45 e8             	lea    -0x18(%ebp),%eax
801061d5:	89 44 24 04          	mov    %eax,0x4(%esp)
801061d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801061e0:	e8 37 f4 ff ff       	call   8010561c <argint>
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
801061e5:	85 c0                	test   %eax,%eax
801061e7:	78 47                	js     80106230 <sys_mknod+0x85>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801061e9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801061ec:	89 44 24 04          	mov    %eax,0x4(%esp)
801061f0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801061f7:	e8 20 f4 ff ff       	call   8010561c <argint>
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801061fc:	85 c0                	test   %eax,%eax
801061fe:	78 30                	js     80106230 <sys_mknod+0x85>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80106200:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106203:	0f bf c8             	movswl %ax,%ecx
80106206:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106209:	0f bf d0             	movswl %ax,%edx
8010620c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
8010620f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106213:	89 54 24 08          	mov    %edx,0x8(%esp)
80106217:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
8010621e:	00 
8010621f:	89 04 24             	mov    %eax,(%esp)
80106222:	e8 cb fb ff ff       	call   80105df2 <create>
80106227:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010622a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010622e:	75 0c                	jne    8010623c <sys_mknod+0x91>
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
80106230:	e8 fa cf ff ff       	call   8010322f <commit_trans>
    return -1;
80106235:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010623a:	eb 15                	jmp    80106251 <sys_mknod+0xa6>
  }
  iunlockput(ip);
8010623c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010623f:	89 04 24             	mov    %eax,(%esp)
80106242:	e8 93 b8 ff ff       	call   80101ada <iunlockput>
  commit_trans();
80106247:	e8 e3 cf ff ff       	call   8010322f <commit_trans>
  return 0;
8010624c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106251:	c9                   	leave  
80106252:	c3                   	ret    

80106253 <sys_chdir>:

int
sys_chdir(void)
{
80106253:	55                   	push   %ebp
80106254:	89 e5                	mov    %esp,%ebp
80106256:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80106259:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010625c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106260:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106267:	e8 40 f4 ff ff       	call   801056ac <argstr>
8010626c:	85 c0                	test   %eax,%eax
8010626e:	78 14                	js     80106284 <sys_chdir+0x31>
80106270:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106273:	89 04 24             	mov    %eax,(%esp)
80106276:	e8 86 c1 ff ff       	call   80102401 <namei>
8010627b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010627e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106282:	75 07                	jne    8010628b <sys_chdir+0x38>
    return -1;
80106284:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106289:	eb 57                	jmp    801062e2 <sys_chdir+0x8f>
  ilock(ip);
8010628b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010628e:	89 04 24             	mov    %eax,(%esp)
80106291:	e8 c0 b5 ff ff       	call   80101856 <ilock>
  if(ip->type != T_DIR){
80106296:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106299:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010629d:	66 83 f8 01          	cmp    $0x1,%ax
801062a1:	74 12                	je     801062b5 <sys_chdir+0x62>
    iunlockput(ip);
801062a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062a6:	89 04 24             	mov    %eax,(%esp)
801062a9:	e8 2c b8 ff ff       	call   80101ada <iunlockput>
    return -1;
801062ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062b3:	eb 2d                	jmp    801062e2 <sys_chdir+0x8f>
  }
  iunlock(ip);
801062b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062b8:	89 04 24             	mov    %eax,(%esp)
801062bb:	e8 e4 b6 ff ff       	call   801019a4 <iunlock>
  iput(proc->cwd);
801062c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062c6:	8b 40 68             	mov    0x68(%eax),%eax
801062c9:	89 04 24             	mov    %eax,(%esp)
801062cc:	e8 38 b7 ff ff       	call   80101a09 <iput>
  proc->cwd = ip;
801062d1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801062da:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
801062dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
801062e2:	c9                   	leave  
801062e3:	c3                   	ret    

801062e4 <sys_exec>:

int
sys_exec(void)
{
801062e4:	55                   	push   %ebp
801062e5:	89 e5                	mov    %esp,%ebp
801062e7:	81 ec a8 00 00 00    	sub    $0xa8,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801062ed:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062f0:	89 44 24 04          	mov    %eax,0x4(%esp)
801062f4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801062fb:	e8 ac f3 ff ff       	call   801056ac <argstr>
80106300:	85 c0                	test   %eax,%eax
80106302:	78 1a                	js     8010631e <sys_exec+0x3a>
80106304:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
8010630a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010630e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106315:	e8 02 f3 ff ff       	call   8010561c <argint>
8010631a:	85 c0                	test   %eax,%eax
8010631c:	79 0a                	jns    80106328 <sys_exec+0x44>
    return -1;
8010631e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106323:	e9 c8 00 00 00       	jmp    801063f0 <sys_exec+0x10c>
  }
  memset(argv, 0, sizeof(argv));
80106328:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
8010632f:	00 
80106330:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106337:	00 
80106338:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010633e:	89 04 24             	mov    %eax,(%esp)
80106341:	e8 90 ef ff ff       	call   801052d6 <memset>
  for(i=0;; i++){
80106346:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
8010634d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106350:	83 f8 1f             	cmp    $0x1f,%eax
80106353:	76 0a                	jbe    8010635f <sys_exec+0x7b>
      return -1;
80106355:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010635a:	e9 91 00 00 00       	jmp    801063f0 <sys_exec+0x10c>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010635f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106362:	c1 e0 02             	shl    $0x2,%eax
80106365:	89 c2                	mov    %eax,%edx
80106367:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
8010636d:	01 c2                	add    %eax,%edx
8010636f:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106375:	89 44 24 04          	mov    %eax,0x4(%esp)
80106379:	89 14 24             	mov    %edx,(%esp)
8010637c:	e8 ff f1 ff ff       	call   80105580 <fetchint>
80106381:	85 c0                	test   %eax,%eax
80106383:	79 07                	jns    8010638c <sys_exec+0xa8>
      return -1;
80106385:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010638a:	eb 64                	jmp    801063f0 <sys_exec+0x10c>
    if(uarg == 0){
8010638c:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106392:	85 c0                	test   %eax,%eax
80106394:	75 26                	jne    801063bc <sys_exec+0xd8>
      argv[i] = 0;
80106396:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106399:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
801063a0:	00 00 00 00 
      break;
801063a4:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801063a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063a8:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
801063ae:	89 54 24 04          	mov    %edx,0x4(%esp)
801063b2:	89 04 24             	mov    %eax,(%esp)
801063b5:	e8 36 a7 ff ff       	call   80100af0 <exec>
801063ba:	eb 34                	jmp    801063f0 <sys_exec+0x10c>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801063bc:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801063c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801063c5:	c1 e2 02             	shl    $0x2,%edx
801063c8:	01 c2                	add    %eax,%edx
801063ca:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
801063d0:	89 54 24 04          	mov    %edx,0x4(%esp)
801063d4:	89 04 24             	mov    %eax,(%esp)
801063d7:	e8 de f1 ff ff       	call   801055ba <fetchstr>
801063dc:	85 c0                	test   %eax,%eax
801063de:	79 07                	jns    801063e7 <sys_exec+0x103>
      return -1;
801063e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063e5:	eb 09                	jmp    801063f0 <sys_exec+0x10c>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801063e7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
801063eb:	e9 5d ff ff ff       	jmp    8010634d <sys_exec+0x69>
  return exec(path, argv);
}
801063f0:	c9                   	leave  
801063f1:	c3                   	ret    

801063f2 <sys_pipe>:

int
sys_pipe(void)
{
801063f2:	55                   	push   %ebp
801063f3:	89 e5                	mov    %esp,%ebp
801063f5:	83 ec 38             	sub    $0x38,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801063f8:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
801063ff:	00 
80106400:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106403:	89 44 24 04          	mov    %eax,0x4(%esp)
80106407:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010640e:	e8 37 f2 ff ff       	call   8010564a <argptr>
80106413:	85 c0                	test   %eax,%eax
80106415:	79 0a                	jns    80106421 <sys_pipe+0x2f>
    return -1;
80106417:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010641c:	e9 9b 00 00 00       	jmp    801064bc <sys_pipe+0xca>
  if(pipealloc(&rf, &wf) < 0)
80106421:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106424:	89 44 24 04          	mov    %eax,0x4(%esp)
80106428:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010642b:	89 04 24             	mov    %eax,(%esp)
8010642e:	e8 a5 d7 ff ff       	call   80103bd8 <pipealloc>
80106433:	85 c0                	test   %eax,%eax
80106435:	79 07                	jns    8010643e <sys_pipe+0x4c>
    return -1;
80106437:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010643c:	eb 7e                	jmp    801064bc <sys_pipe+0xca>
  fd0 = -1;
8010643e:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106445:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106448:	89 04 24             	mov    %eax,(%esp)
8010644b:	e8 99 f3 ff ff       	call   801057e9 <fdalloc>
80106450:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106453:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106457:	78 14                	js     8010646d <sys_pipe+0x7b>
80106459:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010645c:	89 04 24             	mov    %eax,(%esp)
8010645f:	e8 85 f3 ff ff       	call   801057e9 <fdalloc>
80106464:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106467:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010646b:	79 37                	jns    801064a4 <sys_pipe+0xb2>
    if(fd0 >= 0)
8010646d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106471:	78 14                	js     80106487 <sys_pipe+0x95>
      proc->ofile[fd0] = 0;
80106473:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106479:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010647c:	83 c2 08             	add    $0x8,%edx
8010647f:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106486:	00 
    fileclose(rf);
80106487:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010648a:	89 04 24             	mov    %eax,(%esp)
8010648d:	e8 36 ab ff ff       	call   80100fc8 <fileclose>
    fileclose(wf);
80106492:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106495:	89 04 24             	mov    %eax,(%esp)
80106498:	e8 2b ab ff ff       	call   80100fc8 <fileclose>
    return -1;
8010649d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064a2:	eb 18                	jmp    801064bc <sys_pipe+0xca>
  }
  fd[0] = fd0;
801064a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801064a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801064aa:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
801064ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
801064af:	8d 50 04             	lea    0x4(%eax),%edx
801064b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064b5:	89 02                	mov    %eax,(%edx)
  return 0;
801064b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
801064bc:	c9                   	leave  
801064bd:	c3                   	ret    

801064be <sys_thread_yield>:

void sys_thread_yield(void){
801064be:	55                   	push   %ebp
801064bf:	89 e5                	mov    %esp,%ebp
801064c1:	83 ec 08             	sub    $0x8,%esp
  thread_yield();
801064c4:	e8 18 e7 ff ff       	call   80104be1 <thread_yield>
}
801064c9:	c9                   	leave  
801064ca:	c3                   	ret    
801064cb:	90                   	nop

801064cc <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801064cc:	55                   	push   %ebp
801064cd:	89 e5                	mov    %esp,%ebp
801064cf:	83 ec 08             	sub    $0x8,%esp
  return fork();
801064d2:	e8 48 de ff ff       	call   8010431f <fork>
}
801064d7:	c9                   	leave  
801064d8:	c3                   	ret    

801064d9 <sys_clone>:

int
sys_clone(){
801064d9:	55                   	push   %ebp
801064da:	89 e5                	mov    %esp,%ebp
801064dc:	53                   	push   %ebx
801064dd:	83 ec 24             	sub    $0x24,%esp
    int stack;
    int size;
    int routine;
    int arg;

    if(argint(1,&size) < 0 || size <=0 || argint(0,&stack) <0 ||
801064e0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064e3:	89 44 24 04          	mov    %eax,0x4(%esp)
801064e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801064ee:	e8 29 f1 ff ff       	call   8010561c <argint>
801064f3:	85 c0                	test   %eax,%eax
801064f5:	78 4c                	js     80106543 <sys_clone+0x6a>
801064f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064fa:	85 c0                	test   %eax,%eax
801064fc:	7e 45                	jle    80106543 <sys_clone+0x6a>
801064fe:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106501:	89 44 24 04          	mov    %eax,0x4(%esp)
80106505:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010650c:	e8 0b f1 ff ff       	call   8010561c <argint>
80106511:	85 c0                	test   %eax,%eax
80106513:	78 2e                	js     80106543 <sys_clone+0x6a>
            argint(2,&routine) < 0 || argint(3,&arg)<0){
80106515:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106518:	89 44 24 04          	mov    %eax,0x4(%esp)
8010651c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106523:	e8 f4 f0 ff ff       	call   8010561c <argint>
    int stack;
    int size;
    int routine;
    int arg;

    if(argint(1,&size) < 0 || size <=0 || argint(0,&stack) <0 ||
80106528:	85 c0                	test   %eax,%eax
8010652a:	78 17                	js     80106543 <sys_clone+0x6a>
            argint(2,&routine) < 0 || argint(3,&arg)<0){
8010652c:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010652f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106533:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
8010653a:	e8 dd f0 ff ff       	call   8010561c <argint>
8010653f:	85 c0                	test   %eax,%eax
80106541:	79 07                	jns    8010654a <sys_clone+0x71>
        return -1;
80106543:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106548:	eb 20                	jmp    8010656a <sys_clone+0x91>
    }
    return clone(stack,size,routine,arg);
8010654a:	8b 5d e8             	mov    -0x18(%ebp),%ebx
8010654d:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80106550:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106553:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106556:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
8010655a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010655e:	89 54 24 04          	mov    %edx,0x4(%esp)
80106562:	89 04 24             	mov    %eax,(%esp)
80106565:	e8 25 df ff ff       	call   8010448f <clone>
}
8010656a:	83 c4 24             	add    $0x24,%esp
8010656d:	5b                   	pop    %ebx
8010656e:	5d                   	pop    %ebp
8010656f:	c3                   	ret    

80106570 <sys_exit>:

int
sys_exit(void)
{
80106570:	55                   	push   %ebp
80106571:	89 e5                	mov    %esp,%ebp
80106573:	83 ec 08             	sub    $0x8,%esp
  exit();
80106576:	e8 37 e1 ff ff       	call   801046b2 <exit>
  return 0;  // not reached
8010657b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106580:	c9                   	leave  
80106581:	c3                   	ret    

80106582 <sys_texit>:

int
sys_texit(void)
{
80106582:	55                   	push   %ebp
80106583:	89 e5                	mov    %esp,%ebp
80106585:	83 ec 08             	sub    $0x8,%esp
    texit();
80106588:	e8 40 e2 ff ff       	call   801047cd <texit>
    return 0;
8010658d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106592:	c9                   	leave  
80106593:	c3                   	ret    

80106594 <sys_wait>:

int
sys_wait(void)
{
80106594:	55                   	push   %ebp
80106595:	89 e5                	mov    %esp,%ebp
80106597:	83 ec 08             	sub    $0x8,%esp
  return wait();
8010659a:	e8 7a e3 ff ff       	call   80104919 <wait>
}
8010659f:	c9                   	leave  
801065a0:	c3                   	ret    

801065a1 <sys_kill>:

int
sys_kill(void)
{
801065a1:	55                   	push   %ebp
801065a2:	89 e5                	mov    %esp,%ebp
801065a4:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
801065a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801065aa:	89 44 24 04          	mov    %eax,0x4(%esp)
801065ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801065b5:	e8 62 f0 ff ff       	call   8010561c <argint>
801065ba:	85 c0                	test   %eax,%eax
801065bc:	79 07                	jns    801065c5 <sys_kill+0x24>
    return -1;
801065be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065c3:	eb 0b                	jmp    801065d0 <sys_kill+0x2f>
  return kill(pid);
801065c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065c8:	89 04 24             	mov    %eax,(%esp)
801065cb:	e8 ad e8 ff ff       	call   80104e7d <kill>
}
801065d0:	c9                   	leave  
801065d1:	c3                   	ret    

801065d2 <sys_getpid>:

int
sys_getpid(void)
{
801065d2:	55                   	push   %ebp
801065d3:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801065d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065db:	8b 40 10             	mov    0x10(%eax),%eax
}
801065de:	5d                   	pop    %ebp
801065df:	c3                   	ret    

801065e0 <sys_sbrk>:

int
sys_sbrk(void)
{
801065e0:	55                   	push   %ebp
801065e1:	89 e5                	mov    %esp,%ebp
801065e3:	83 ec 28             	sub    $0x28,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801065e6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801065e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801065ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801065f4:	e8 23 f0 ff ff       	call   8010561c <argint>
801065f9:	85 c0                	test   %eax,%eax
801065fb:	79 07                	jns    80106604 <sys_sbrk+0x24>
    return -1;
801065fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106602:	eb 24                	jmp    80106628 <sys_sbrk+0x48>
  addr = proc->sz;
80106604:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010660a:	8b 00                	mov    (%eax),%eax
8010660c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
8010660f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106612:	89 04 24             	mov    %eax,(%esp)
80106615:	e8 60 dc ff ff       	call   8010427a <growproc>
8010661a:	85 c0                	test   %eax,%eax
8010661c:	79 07                	jns    80106625 <sys_sbrk+0x45>
    return -1;
8010661e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106623:	eb 03                	jmp    80106628 <sys_sbrk+0x48>
  return addr;
80106625:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106628:	c9                   	leave  
80106629:	c3                   	ret    

8010662a <sys_sleep>:

int
sys_sleep(void)
{
8010662a:	55                   	push   %ebp
8010662b:	89 e5                	mov    %esp,%ebp
8010662d:	83 ec 28             	sub    $0x28,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80106630:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106633:	89 44 24 04          	mov    %eax,0x4(%esp)
80106637:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010663e:	e8 d9 ef ff ff       	call   8010561c <argint>
80106643:	85 c0                	test   %eax,%eax
80106645:	79 07                	jns    8010664e <sys_sleep+0x24>
    return -1;
80106647:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010664c:	eb 6c                	jmp    801066ba <sys_sleep+0x90>
  acquire(&tickslock);
8010664e:	c7 04 24 c0 21 11 80 	movl   $0x801121c0,(%esp)
80106655:	e8 25 ea ff ff       	call   8010507f <acquire>
  ticks0 = ticks;
8010665a:	a1 00 2a 11 80       	mov    0x80112a00,%eax
8010665f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106662:	eb 34                	jmp    80106698 <sys_sleep+0x6e>
    if(proc->killed){
80106664:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010666a:	8b 40 24             	mov    0x24(%eax),%eax
8010666d:	85 c0                	test   %eax,%eax
8010666f:	74 13                	je     80106684 <sys_sleep+0x5a>
      release(&tickslock);
80106671:	c7 04 24 c0 21 11 80 	movl   $0x801121c0,(%esp)
80106678:	e8 64 ea ff ff       	call   801050e1 <release>
      return -1;
8010667d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106682:	eb 36                	jmp    801066ba <sys_sleep+0x90>
    }
    sleep(&ticks, &tickslock);
80106684:	c7 44 24 04 c0 21 11 	movl   $0x801121c0,0x4(%esp)
8010668b:	80 
8010668c:	c7 04 24 00 2a 11 80 	movl   $0x80112a00,(%esp)
80106693:	e8 76 e6 ff ff       	call   80104d0e <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106698:	a1 00 2a 11 80       	mov    0x80112a00,%eax
8010669d:	2b 45 f4             	sub    -0xc(%ebp),%eax
801066a0:	89 c2                	mov    %eax,%edx
801066a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801066a5:	39 c2                	cmp    %eax,%edx
801066a7:	72 bb                	jb     80106664 <sys_sleep+0x3a>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801066a9:	c7 04 24 c0 21 11 80 	movl   $0x801121c0,(%esp)
801066b0:	e8 2c ea ff ff       	call   801050e1 <release>
  return 0;
801066b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
801066ba:	c9                   	leave  
801066bb:	c3                   	ret    

801066bc <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801066bc:	55                   	push   %ebp
801066bd:	89 e5                	mov    %esp,%ebp
801066bf:	83 ec 28             	sub    $0x28,%esp
  uint xticks;
  
  acquire(&tickslock);
801066c2:	c7 04 24 c0 21 11 80 	movl   $0x801121c0,(%esp)
801066c9:	e8 b1 e9 ff ff       	call   8010507f <acquire>
  xticks = ticks;
801066ce:	a1 00 2a 11 80       	mov    0x80112a00,%eax
801066d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
801066d6:	c7 04 24 c0 21 11 80 	movl   $0x801121c0,(%esp)
801066dd:	e8 ff e9 ff ff       	call   801050e1 <release>
  return xticks;
801066e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801066e5:	c9                   	leave  
801066e6:	c3                   	ret    

801066e7 <sys_tsleep>:

int
sys_tsleep(void)
{
801066e7:	55                   	push   %ebp
801066e8:	89 e5                	mov    %esp,%ebp
801066ea:	83 ec 08             	sub    $0x8,%esp
    tsleep();
801066ed:	e8 00 e9 ff ff       	call   80104ff2 <tsleep>
    return 0;
801066f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801066f7:	c9                   	leave  
801066f8:	c3                   	ret    

801066f9 <sys_twakeup>:

int 
sys_twakeup(void)
{
801066f9:	55                   	push   %ebp
801066fa:	89 e5                	mov    %esp,%ebp
801066fc:	83 ec 28             	sub    $0x28,%esp
    int tid;
    if(argint(0,&tid) < 0){
801066ff:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106702:	89 44 24 04          	mov    %eax,0x4(%esp)
80106706:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010670d:	e8 0a ef ff ff       	call   8010561c <argint>
80106712:	85 c0                	test   %eax,%eax
80106714:	79 07                	jns    8010671d <sys_twakeup+0x24>
        return -1;
80106716:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010671b:	eb 10                	jmp    8010672d <sys_twakeup+0x34>
    }
        twakeup(tid);
8010671d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106720:	89 04 24             	mov    %eax,(%esp)
80106723:	e8 c2 e6 ff ff       	call   80104dea <twakeup>
        return 0;
80106728:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010672d:	c9                   	leave  
8010672e:	c3                   	ret    
8010672f:	90                   	nop

80106730 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106730:	55                   	push   %ebp
80106731:	89 e5                	mov    %esp,%ebp
80106733:	83 ec 08             	sub    $0x8,%esp
80106736:	8b 55 08             	mov    0x8(%ebp),%edx
80106739:	8b 45 0c             	mov    0xc(%ebp),%eax
8010673c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106740:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106743:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106747:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010674b:	ee                   	out    %al,(%dx)
}
8010674c:	c9                   	leave  
8010674d:	c3                   	ret    

8010674e <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
8010674e:	55                   	push   %ebp
8010674f:	89 e5                	mov    %esp,%ebp
80106751:	83 ec 18             	sub    $0x18,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
80106754:	c7 44 24 04 34 00 00 	movl   $0x34,0x4(%esp)
8010675b:	00 
8010675c:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
80106763:	e8 c8 ff ff ff       	call   80106730 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
80106768:	c7 44 24 04 9c 00 00 	movl   $0x9c,0x4(%esp)
8010676f:	00 
80106770:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
80106777:	e8 b4 ff ff ff       	call   80106730 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
8010677c:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
80106783:	00 
80106784:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
8010678b:	e8 a0 ff ff ff       	call   80106730 <outb>
  picenable(IRQ_TIMER);
80106790:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106797:	e8 cd d2 ff ff       	call   80103a69 <picenable>
}
8010679c:	c9                   	leave  
8010679d:	c3                   	ret    
8010679e:	66 90                	xchg   %ax,%ax

801067a0 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801067a0:	1e                   	push   %ds
  pushl %es
801067a1:	06                   	push   %es
  pushl %fs
801067a2:	0f a0                	push   %fs
  pushl %gs
801067a4:	0f a8                	push   %gs
  pushal
801067a6:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
801067a7:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801067ab:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801067ad:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
801067af:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
801067b3:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
801067b5:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
801067b7:	54                   	push   %esp
  call trap
801067b8:	e8 d9 01 00 00       	call   80106996 <trap>
  addl $4, %esp
801067bd:	83 c4 04             	add    $0x4,%esp

801067c0 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801067c0:	61                   	popa   
  popl %gs
801067c1:	0f a9                	pop    %gs
  popl %fs
801067c3:	0f a1                	pop    %fs
  popl %es
801067c5:	07                   	pop    %es
  popl %ds
801067c6:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801067c7:	83 c4 08             	add    $0x8,%esp
  iret
801067ca:	cf                   	iret   
801067cb:	90                   	nop

801067cc <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
801067cc:	55                   	push   %ebp
801067cd:	89 e5                	mov    %esp,%ebp
801067cf:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
801067d2:	8b 45 0c             	mov    0xc(%ebp),%eax
801067d5:	83 e8 01             	sub    $0x1,%eax
801067d8:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801067dc:	8b 45 08             	mov    0x8(%ebp),%eax
801067df:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801067e3:	8b 45 08             	mov    0x8(%ebp),%eax
801067e6:	c1 e8 10             	shr    $0x10,%eax
801067e9:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801067ed:	8d 45 fa             	lea    -0x6(%ebp),%eax
801067f0:	0f 01 18             	lidtl  (%eax)
}
801067f3:	c9                   	leave  
801067f4:	c3                   	ret    

801067f5 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
801067f5:	55                   	push   %ebp
801067f6:	89 e5                	mov    %esp,%ebp
801067f8:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801067fb:	0f 20 d0             	mov    %cr2,%eax
801067fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80106801:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106804:	c9                   	leave  
80106805:	c3                   	ret    

80106806 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106806:	55                   	push   %ebp
80106807:	89 e5                	mov    %esp,%ebp
80106809:	83 ec 28             	sub    $0x28,%esp
  int i;

  for(i = 0; i < 256; i++)
8010680c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106813:	e9 c3 00 00 00       	jmp    801068db <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106818:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010681b:	8b 04 85 ac b0 10 80 	mov    -0x7fef4f54(,%eax,4),%eax
80106822:	89 c2                	mov    %eax,%edx
80106824:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106827:	66 89 14 c5 00 22 11 	mov    %dx,-0x7feede00(,%eax,8)
8010682e:	80 
8010682f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106832:	66 c7 04 c5 02 22 11 	movw   $0x8,-0x7feeddfe(,%eax,8)
80106839:	80 08 00 
8010683c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010683f:	0f b6 14 c5 04 22 11 	movzbl -0x7feeddfc(,%eax,8),%edx
80106846:	80 
80106847:	83 e2 e0             	and    $0xffffffe0,%edx
8010684a:	88 14 c5 04 22 11 80 	mov    %dl,-0x7feeddfc(,%eax,8)
80106851:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106854:	0f b6 14 c5 04 22 11 	movzbl -0x7feeddfc(,%eax,8),%edx
8010685b:	80 
8010685c:	83 e2 1f             	and    $0x1f,%edx
8010685f:	88 14 c5 04 22 11 80 	mov    %dl,-0x7feeddfc(,%eax,8)
80106866:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106869:	0f b6 14 c5 05 22 11 	movzbl -0x7feeddfb(,%eax,8),%edx
80106870:	80 
80106871:	83 e2 f0             	and    $0xfffffff0,%edx
80106874:	83 ca 0e             	or     $0xe,%edx
80106877:	88 14 c5 05 22 11 80 	mov    %dl,-0x7feeddfb(,%eax,8)
8010687e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106881:	0f b6 14 c5 05 22 11 	movzbl -0x7feeddfb(,%eax,8),%edx
80106888:	80 
80106889:	83 e2 ef             	and    $0xffffffef,%edx
8010688c:	88 14 c5 05 22 11 80 	mov    %dl,-0x7feeddfb(,%eax,8)
80106893:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106896:	0f b6 14 c5 05 22 11 	movzbl -0x7feeddfb(,%eax,8),%edx
8010689d:	80 
8010689e:	83 e2 9f             	and    $0xffffff9f,%edx
801068a1:	88 14 c5 05 22 11 80 	mov    %dl,-0x7feeddfb(,%eax,8)
801068a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068ab:	0f b6 14 c5 05 22 11 	movzbl -0x7feeddfb(,%eax,8),%edx
801068b2:	80 
801068b3:	83 ca 80             	or     $0xffffff80,%edx
801068b6:	88 14 c5 05 22 11 80 	mov    %dl,-0x7feeddfb(,%eax,8)
801068bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068c0:	8b 04 85 ac b0 10 80 	mov    -0x7fef4f54(,%eax,4),%eax
801068c7:	c1 e8 10             	shr    $0x10,%eax
801068ca:	89 c2                	mov    %eax,%edx
801068cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068cf:	66 89 14 c5 06 22 11 	mov    %dx,-0x7feeddfa(,%eax,8)
801068d6:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801068d7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801068db:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
801068e2:	0f 8e 30 ff ff ff    	jle    80106818 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801068e8:	a1 ac b1 10 80       	mov    0x8010b1ac,%eax
801068ed:	66 a3 00 24 11 80    	mov    %ax,0x80112400
801068f3:	66 c7 05 02 24 11 80 	movw   $0x8,0x80112402
801068fa:	08 00 
801068fc:	0f b6 05 04 24 11 80 	movzbl 0x80112404,%eax
80106903:	83 e0 e0             	and    $0xffffffe0,%eax
80106906:	a2 04 24 11 80       	mov    %al,0x80112404
8010690b:	0f b6 05 04 24 11 80 	movzbl 0x80112404,%eax
80106912:	83 e0 1f             	and    $0x1f,%eax
80106915:	a2 04 24 11 80       	mov    %al,0x80112404
8010691a:	0f b6 05 05 24 11 80 	movzbl 0x80112405,%eax
80106921:	83 c8 0f             	or     $0xf,%eax
80106924:	a2 05 24 11 80       	mov    %al,0x80112405
80106929:	0f b6 05 05 24 11 80 	movzbl 0x80112405,%eax
80106930:	83 e0 ef             	and    $0xffffffef,%eax
80106933:	a2 05 24 11 80       	mov    %al,0x80112405
80106938:	0f b6 05 05 24 11 80 	movzbl 0x80112405,%eax
8010693f:	83 c8 60             	or     $0x60,%eax
80106942:	a2 05 24 11 80       	mov    %al,0x80112405
80106947:	0f b6 05 05 24 11 80 	movzbl 0x80112405,%eax
8010694e:	83 c8 80             	or     $0xffffff80,%eax
80106951:	a2 05 24 11 80       	mov    %al,0x80112405
80106956:	a1 ac b1 10 80       	mov    0x8010b1ac,%eax
8010695b:	c1 e8 10             	shr    $0x10,%eax
8010695e:	66 a3 06 24 11 80    	mov    %ax,0x80112406
  
  initlock(&tickslock, "time");
80106964:	c7 44 24 04 b4 8b 10 	movl   $0x80108bb4,0x4(%esp)
8010696b:	80 
8010696c:	c7 04 24 c0 21 11 80 	movl   $0x801121c0,(%esp)
80106973:	e8 e6 e6 ff ff       	call   8010505e <initlock>
}
80106978:	c9                   	leave  
80106979:	c3                   	ret    

8010697a <idtinit>:

void
idtinit(void)
{
8010697a:	55                   	push   %ebp
8010697b:	89 e5                	mov    %esp,%ebp
8010697d:	83 ec 08             	sub    $0x8,%esp
  lidt(idt, sizeof(idt));
80106980:	c7 44 24 04 00 08 00 	movl   $0x800,0x4(%esp)
80106987:	00 
80106988:	c7 04 24 00 22 11 80 	movl   $0x80112200,(%esp)
8010698f:	e8 38 fe ff ff       	call   801067cc <lidt>
}
80106994:	c9                   	leave  
80106995:	c3                   	ret    

80106996 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106996:	55                   	push   %ebp
80106997:	89 e5                	mov    %esp,%ebp
80106999:	57                   	push   %edi
8010699a:	56                   	push   %esi
8010699b:	53                   	push   %ebx
8010699c:	83 ec 3c             	sub    $0x3c,%esp
  if(tf->trapno == T_SYSCALL){
8010699f:	8b 45 08             	mov    0x8(%ebp),%eax
801069a2:	8b 40 30             	mov    0x30(%eax),%eax
801069a5:	83 f8 40             	cmp    $0x40,%eax
801069a8:	75 3f                	jne    801069e9 <trap+0x53>
    if(proc->killed)
801069aa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069b0:	8b 40 24             	mov    0x24(%eax),%eax
801069b3:	85 c0                	test   %eax,%eax
801069b5:	74 05                	je     801069bc <trap+0x26>
      exit();
801069b7:	e8 f6 dc ff ff       	call   801046b2 <exit>
    proc->tf = tf;
801069bc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069c2:	8b 55 08             	mov    0x8(%ebp),%edx
801069c5:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
801069c8:	e8 16 ed ff ff       	call   801056e3 <syscall>
    if(proc->killed)
801069cd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069d3:	8b 40 24             	mov    0x24(%eax),%eax
801069d6:	85 c0                	test   %eax,%eax
801069d8:	74 0a                	je     801069e4 <trap+0x4e>
      exit();
801069da:	e8 d3 dc ff ff       	call   801046b2 <exit>
    return;
801069df:	e9 2d 02 00 00       	jmp    80106c11 <trap+0x27b>
801069e4:	e9 28 02 00 00       	jmp    80106c11 <trap+0x27b>
  }

  switch(tf->trapno){
801069e9:	8b 45 08             	mov    0x8(%ebp),%eax
801069ec:	8b 40 30             	mov    0x30(%eax),%eax
801069ef:	83 e8 20             	sub    $0x20,%eax
801069f2:	83 f8 1f             	cmp    $0x1f,%eax
801069f5:	0f 87 bc 00 00 00    	ja     80106ab7 <trap+0x121>
801069fb:	8b 04 85 5c 8c 10 80 	mov    -0x7fef73a4(,%eax,4),%eax
80106a02:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80106a04:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106a0a:	0f b6 00             	movzbl (%eax),%eax
80106a0d:	84 c0                	test   %al,%al
80106a0f:	75 31                	jne    80106a42 <trap+0xac>
      acquire(&tickslock);
80106a11:	c7 04 24 c0 21 11 80 	movl   $0x801121c0,(%esp)
80106a18:	e8 62 e6 ff ff       	call   8010507f <acquire>
      ticks++;
80106a1d:	a1 00 2a 11 80       	mov    0x80112a00,%eax
80106a22:	83 c0 01             	add    $0x1,%eax
80106a25:	a3 00 2a 11 80       	mov    %eax,0x80112a00
      wakeup(&ticks);
80106a2a:	c7 04 24 00 2a 11 80 	movl   $0x80112a00,(%esp)
80106a31:	e8 1c e4 ff ff       	call   80104e52 <wakeup>
      release(&tickslock);
80106a36:	c7 04 24 c0 21 11 80 	movl   $0x801121c0,(%esp)
80106a3d:	e8 9f e6 ff ff       	call   801050e1 <release>
    }
    lapiceoi();
80106a42:	e8 6d c4 ff ff       	call   80102eb4 <lapiceoi>
    break;
80106a47:	e9 41 01 00 00       	jmp    80106b8d <trap+0x1f7>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106a4c:	e8 8b bc ff ff       	call   801026dc <ideintr>
    lapiceoi();
80106a51:	e8 5e c4 ff ff       	call   80102eb4 <lapiceoi>
    break;
80106a56:	e9 32 01 00 00       	jmp    80106b8d <trap+0x1f7>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106a5b:	e8 40 c2 ff ff       	call   80102ca0 <kbdintr>
    lapiceoi();
80106a60:	e8 4f c4 ff ff       	call   80102eb4 <lapiceoi>
    break;
80106a65:	e9 23 01 00 00       	jmp    80106b8d <trap+0x1f7>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106a6a:	e8 9a 03 00 00       	call   80106e09 <uartintr>
    lapiceoi();
80106a6f:	e8 40 c4 ff ff       	call   80102eb4 <lapiceoi>
    break;
80106a74:	e9 14 01 00 00       	jmp    80106b8d <trap+0x1f7>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106a79:	8b 45 08             	mov    0x8(%ebp),%eax
80106a7c:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106a7f:	8b 45 08             	mov    0x8(%ebp),%eax
80106a82:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106a86:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106a89:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106a8f:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106a92:	0f b6 c0             	movzbl %al,%eax
80106a95:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106a99:	89 54 24 08          	mov    %edx,0x8(%esp)
80106a9d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106aa1:	c7 04 24 bc 8b 10 80 	movl   $0x80108bbc,(%esp)
80106aa8:	e8 f3 98 ff ff       	call   801003a0 <cprintf>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80106aad:	e8 02 c4 ff ff       	call   80102eb4 <lapiceoi>
    break;
80106ab2:	e9 d6 00 00 00       	jmp    80106b8d <trap+0x1f7>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106ab7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106abd:	85 c0                	test   %eax,%eax
80106abf:	74 11                	je     80106ad2 <trap+0x13c>
80106ac1:	8b 45 08             	mov    0x8(%ebp),%eax
80106ac4:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106ac8:	0f b7 c0             	movzwl %ax,%eax
80106acb:	83 e0 03             	and    $0x3,%eax
80106ace:	85 c0                	test   %eax,%eax
80106ad0:	75 46                	jne    80106b18 <trap+0x182>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106ad2:	e8 1e fd ff ff       	call   801067f5 <rcr2>
80106ad7:	8b 55 08             	mov    0x8(%ebp),%edx
80106ada:	8b 5a 38             	mov    0x38(%edx),%ebx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106add:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80106ae4:	0f b6 12             	movzbl (%edx),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106ae7:	0f b6 ca             	movzbl %dl,%ecx
80106aea:	8b 55 08             	mov    0x8(%ebp),%edx
80106aed:	8b 52 30             	mov    0x30(%edx),%edx
80106af0:	89 44 24 10          	mov    %eax,0x10(%esp)
80106af4:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80106af8:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106afc:	89 54 24 04          	mov    %edx,0x4(%esp)
80106b00:	c7 04 24 e0 8b 10 80 	movl   $0x80108be0,(%esp)
80106b07:	e8 94 98 ff ff       	call   801003a0 <cprintf>
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
80106b0c:	c7 04 24 12 8c 10 80 	movl   $0x80108c12,(%esp)
80106b13:	e8 22 9a ff ff       	call   8010053a <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106b18:	e8 d8 fc ff ff       	call   801067f5 <rcr2>
80106b1d:	89 c2                	mov    %eax,%edx
80106b1f:	8b 45 08             	mov    0x8(%ebp),%eax
80106b22:	8b 78 38             	mov    0x38(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106b25:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106b2b:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106b2e:	0f b6 f0             	movzbl %al,%esi
80106b31:	8b 45 08             	mov    0x8(%ebp),%eax
80106b34:	8b 58 34             	mov    0x34(%eax),%ebx
80106b37:	8b 45 08             	mov    0x8(%ebp),%eax
80106b3a:	8b 48 30             	mov    0x30(%eax),%ecx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106b3d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b43:	83 c0 6c             	add    $0x6c,%eax
80106b46:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b49:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106b4f:	8b 40 10             	mov    0x10(%eax),%eax
80106b52:	89 54 24 1c          	mov    %edx,0x1c(%esp)
80106b56:	89 7c 24 18          	mov    %edi,0x18(%esp)
80106b5a:	89 74 24 14          	mov    %esi,0x14(%esp)
80106b5e:	89 5c 24 10          	mov    %ebx,0x10(%esp)
80106b62:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106b66:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80106b69:	89 74 24 08          	mov    %esi,0x8(%esp)
80106b6d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b71:	c7 04 24 18 8c 10 80 	movl   $0x80108c18,(%esp)
80106b78:	e8 23 98 ff ff       	call   801003a0 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
80106b7d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b83:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106b8a:	eb 01                	jmp    80106b8d <trap+0x1f7>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106b8c:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106b8d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b93:	85 c0                	test   %eax,%eax
80106b95:	74 24                	je     80106bbb <trap+0x225>
80106b97:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b9d:	8b 40 24             	mov    0x24(%eax),%eax
80106ba0:	85 c0                	test   %eax,%eax
80106ba2:	74 17                	je     80106bbb <trap+0x225>
80106ba4:	8b 45 08             	mov    0x8(%ebp),%eax
80106ba7:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106bab:	0f b7 c0             	movzwl %ax,%eax
80106bae:	83 e0 03             	and    $0x3,%eax
80106bb1:	83 f8 03             	cmp    $0x3,%eax
80106bb4:	75 05                	jne    80106bbb <trap+0x225>
    exit();
80106bb6:	e8 f7 da ff ff       	call   801046b2 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106bbb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106bc1:	85 c0                	test   %eax,%eax
80106bc3:	74 1e                	je     80106be3 <trap+0x24d>
80106bc5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106bcb:	8b 40 0c             	mov    0xc(%eax),%eax
80106bce:	83 f8 04             	cmp    $0x4,%eax
80106bd1:	75 10                	jne    80106be3 <trap+0x24d>
80106bd3:	8b 45 08             	mov    0x8(%ebp),%eax
80106bd6:	8b 40 30             	mov    0x30(%eax),%eax
80106bd9:	83 f8 20             	cmp    $0x20,%eax
80106bdc:	75 05                	jne    80106be3 <trap+0x24d>
    yield();
80106bde:	e8 cc df ff ff       	call   80104baf <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106be3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106be9:	85 c0                	test   %eax,%eax
80106beb:	74 24                	je     80106c11 <trap+0x27b>
80106bed:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106bf3:	8b 40 24             	mov    0x24(%eax),%eax
80106bf6:	85 c0                	test   %eax,%eax
80106bf8:	74 17                	je     80106c11 <trap+0x27b>
80106bfa:	8b 45 08             	mov    0x8(%ebp),%eax
80106bfd:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106c01:	0f b7 c0             	movzwl %ax,%eax
80106c04:	83 e0 03             	and    $0x3,%eax
80106c07:	83 f8 03             	cmp    $0x3,%eax
80106c0a:	75 05                	jne    80106c11 <trap+0x27b>
    exit();
80106c0c:	e8 a1 da ff ff       	call   801046b2 <exit>
}
80106c11:	83 c4 3c             	add    $0x3c,%esp
80106c14:	5b                   	pop    %ebx
80106c15:	5e                   	pop    %esi
80106c16:	5f                   	pop    %edi
80106c17:	5d                   	pop    %ebp
80106c18:	c3                   	ret    
80106c19:	66 90                	xchg   %ax,%ax
80106c1b:	90                   	nop

80106c1c <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80106c1c:	55                   	push   %ebp
80106c1d:	89 e5                	mov    %esp,%ebp
80106c1f:	83 ec 14             	sub    $0x14,%esp
80106c22:	8b 45 08             	mov    0x8(%ebp),%eax
80106c25:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106c29:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106c2d:	89 c2                	mov    %eax,%edx
80106c2f:	ec                   	in     (%dx),%al
80106c30:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106c33:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106c37:	c9                   	leave  
80106c38:	c3                   	ret    

80106c39 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106c39:	55                   	push   %ebp
80106c3a:	89 e5                	mov    %esp,%ebp
80106c3c:	83 ec 08             	sub    $0x8,%esp
80106c3f:	8b 55 08             	mov    0x8(%ebp),%edx
80106c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c45:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106c49:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106c4c:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106c50:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106c54:	ee                   	out    %al,(%dx)
}
80106c55:	c9                   	leave  
80106c56:	c3                   	ret    

80106c57 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106c57:	55                   	push   %ebp
80106c58:	89 e5                	mov    %esp,%ebp
80106c5a:	83 ec 28             	sub    $0x28,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106c5d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106c64:	00 
80106c65:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
80106c6c:	e8 c8 ff ff ff       	call   80106c39 <outb>
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106c71:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
80106c78:	00 
80106c79:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80106c80:	e8 b4 ff ff ff       	call   80106c39 <outb>
  outb(COM1+0, 115200/9600);
80106c85:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
80106c8c:	00 
80106c8d:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106c94:	e8 a0 ff ff ff       	call   80106c39 <outb>
  outb(COM1+1, 0);
80106c99:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106ca0:	00 
80106ca1:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80106ca8:	e8 8c ff ff ff       	call   80106c39 <outb>
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106cad:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80106cb4:	00 
80106cb5:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80106cbc:	e8 78 ff ff ff       	call   80106c39 <outb>
  outb(COM1+4, 0);
80106cc1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106cc8:	00 
80106cc9:	c7 04 24 fc 03 00 00 	movl   $0x3fc,(%esp)
80106cd0:	e8 64 ff ff ff       	call   80106c39 <outb>
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106cd5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80106cdc:	00 
80106cdd:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80106ce4:	e8 50 ff ff ff       	call   80106c39 <outb>

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106ce9:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106cf0:	e8 27 ff ff ff       	call   80106c1c <inb>
80106cf5:	3c ff                	cmp    $0xff,%al
80106cf7:	75 02                	jne    80106cfb <uartinit+0xa4>
    return;
80106cf9:	eb 6a                	jmp    80106d65 <uartinit+0x10e>
  uart = 1;
80106cfb:	c7 05 6c b6 10 80 01 	movl   $0x1,0x8010b66c
80106d02:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106d05:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
80106d0c:	e8 0b ff ff ff       	call   80106c1c <inb>
  inb(COM1+0);
80106d11:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106d18:	e8 ff fe ff ff       	call   80106c1c <inb>
  picenable(IRQ_COM1);
80106d1d:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106d24:	e8 40 cd ff ff       	call   80103a69 <picenable>
  ioapicenable(IRQ_COM1, 0);
80106d29:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106d30:	00 
80106d31:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106d38:	e8 1f bc ff ff       	call   8010295c <ioapicenable>
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106d3d:	c7 45 f4 dc 8c 10 80 	movl   $0x80108cdc,-0xc(%ebp)
80106d44:	eb 15                	jmp    80106d5b <uartinit+0x104>
    uartputc(*p);
80106d46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d49:	0f b6 00             	movzbl (%eax),%eax
80106d4c:	0f be c0             	movsbl %al,%eax
80106d4f:	89 04 24             	mov    %eax,(%esp)
80106d52:	e8 10 00 00 00       	call   80106d67 <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106d57:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106d5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d5e:	0f b6 00             	movzbl (%eax),%eax
80106d61:	84 c0                	test   %al,%al
80106d63:	75 e1                	jne    80106d46 <uartinit+0xef>
    uartputc(*p);
}
80106d65:	c9                   	leave  
80106d66:	c3                   	ret    

80106d67 <uartputc>:

void
uartputc(int c)
{
80106d67:	55                   	push   %ebp
80106d68:	89 e5                	mov    %esp,%ebp
80106d6a:	83 ec 28             	sub    $0x28,%esp
  int i;

  if(!uart)
80106d6d:	a1 6c b6 10 80       	mov    0x8010b66c,%eax
80106d72:	85 c0                	test   %eax,%eax
80106d74:	75 02                	jne    80106d78 <uartputc+0x11>
    return;
80106d76:	eb 4b                	jmp    80106dc3 <uartputc+0x5c>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106d78:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106d7f:	eb 10                	jmp    80106d91 <uartputc+0x2a>
    microdelay(10);
80106d81:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80106d88:	e8 4c c1 ff ff       	call   80102ed9 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106d8d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106d91:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106d95:	7f 16                	jg     80106dad <uartputc+0x46>
80106d97:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106d9e:	e8 79 fe ff ff       	call   80106c1c <inb>
80106da3:	0f b6 c0             	movzbl %al,%eax
80106da6:	83 e0 20             	and    $0x20,%eax
80106da9:	85 c0                	test   %eax,%eax
80106dab:	74 d4                	je     80106d81 <uartputc+0x1a>
    microdelay(10);
  outb(COM1+0, c);
80106dad:	8b 45 08             	mov    0x8(%ebp),%eax
80106db0:	0f b6 c0             	movzbl %al,%eax
80106db3:	89 44 24 04          	mov    %eax,0x4(%esp)
80106db7:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106dbe:	e8 76 fe ff ff       	call   80106c39 <outb>
}
80106dc3:	c9                   	leave  
80106dc4:	c3                   	ret    

80106dc5 <uartgetc>:

static int
uartgetc(void)
{
80106dc5:	55                   	push   %ebp
80106dc6:	89 e5                	mov    %esp,%ebp
80106dc8:	83 ec 04             	sub    $0x4,%esp
  if(!uart)
80106dcb:	a1 6c b6 10 80       	mov    0x8010b66c,%eax
80106dd0:	85 c0                	test   %eax,%eax
80106dd2:	75 07                	jne    80106ddb <uartgetc+0x16>
    return -1;
80106dd4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106dd9:	eb 2c                	jmp    80106e07 <uartgetc+0x42>
  if(!(inb(COM1+5) & 0x01))
80106ddb:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106de2:	e8 35 fe ff ff       	call   80106c1c <inb>
80106de7:	0f b6 c0             	movzbl %al,%eax
80106dea:	83 e0 01             	and    $0x1,%eax
80106ded:	85 c0                	test   %eax,%eax
80106def:	75 07                	jne    80106df8 <uartgetc+0x33>
    return -1;
80106df1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106df6:	eb 0f                	jmp    80106e07 <uartgetc+0x42>
  return inb(COM1+0);
80106df8:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106dff:	e8 18 fe ff ff       	call   80106c1c <inb>
80106e04:	0f b6 c0             	movzbl %al,%eax
}
80106e07:	c9                   	leave  
80106e08:	c3                   	ret    

80106e09 <uartintr>:

void
uartintr(void)
{
80106e09:	55                   	push   %ebp
80106e0a:	89 e5                	mov    %esp,%ebp
80106e0c:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80106e0f:	c7 04 24 c5 6d 10 80 	movl   $0x80106dc5,(%esp)
80106e16:	e8 92 99 ff ff       	call   801007ad <consoleintr>
}
80106e1b:	c9                   	leave  
80106e1c:	c3                   	ret    
80106e1d:	66 90                	xchg   %ax,%ax
80106e1f:	90                   	nop

80106e20 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106e20:	6a 00                	push   $0x0
  pushl $0
80106e22:	6a 00                	push   $0x0
  jmp alltraps
80106e24:	e9 77 f9 ff ff       	jmp    801067a0 <alltraps>

80106e29 <vector1>:
.globl vector1
vector1:
  pushl $0
80106e29:	6a 00                	push   $0x0
  pushl $1
80106e2b:	6a 01                	push   $0x1
  jmp alltraps
80106e2d:	e9 6e f9 ff ff       	jmp    801067a0 <alltraps>

80106e32 <vector2>:
.globl vector2
vector2:
  pushl $0
80106e32:	6a 00                	push   $0x0
  pushl $2
80106e34:	6a 02                	push   $0x2
  jmp alltraps
80106e36:	e9 65 f9 ff ff       	jmp    801067a0 <alltraps>

80106e3b <vector3>:
.globl vector3
vector3:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $3
80106e3d:	6a 03                	push   $0x3
  jmp alltraps
80106e3f:	e9 5c f9 ff ff       	jmp    801067a0 <alltraps>

80106e44 <vector4>:
.globl vector4
vector4:
  pushl $0
80106e44:	6a 00                	push   $0x0
  pushl $4
80106e46:	6a 04                	push   $0x4
  jmp alltraps
80106e48:	e9 53 f9 ff ff       	jmp    801067a0 <alltraps>

80106e4d <vector5>:
.globl vector5
vector5:
  pushl $0
80106e4d:	6a 00                	push   $0x0
  pushl $5
80106e4f:	6a 05                	push   $0x5
  jmp alltraps
80106e51:	e9 4a f9 ff ff       	jmp    801067a0 <alltraps>

80106e56 <vector6>:
.globl vector6
vector6:
  pushl $0
80106e56:	6a 00                	push   $0x0
  pushl $6
80106e58:	6a 06                	push   $0x6
  jmp alltraps
80106e5a:	e9 41 f9 ff ff       	jmp    801067a0 <alltraps>

80106e5f <vector7>:
.globl vector7
vector7:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $7
80106e61:	6a 07                	push   $0x7
  jmp alltraps
80106e63:	e9 38 f9 ff ff       	jmp    801067a0 <alltraps>

80106e68 <vector8>:
.globl vector8
vector8:
  pushl $8
80106e68:	6a 08                	push   $0x8
  jmp alltraps
80106e6a:	e9 31 f9 ff ff       	jmp    801067a0 <alltraps>

80106e6f <vector9>:
.globl vector9
vector9:
  pushl $0
80106e6f:	6a 00                	push   $0x0
  pushl $9
80106e71:	6a 09                	push   $0x9
  jmp alltraps
80106e73:	e9 28 f9 ff ff       	jmp    801067a0 <alltraps>

80106e78 <vector10>:
.globl vector10
vector10:
  pushl $10
80106e78:	6a 0a                	push   $0xa
  jmp alltraps
80106e7a:	e9 21 f9 ff ff       	jmp    801067a0 <alltraps>

80106e7f <vector11>:
.globl vector11
vector11:
  pushl $11
80106e7f:	6a 0b                	push   $0xb
  jmp alltraps
80106e81:	e9 1a f9 ff ff       	jmp    801067a0 <alltraps>

80106e86 <vector12>:
.globl vector12
vector12:
  pushl $12
80106e86:	6a 0c                	push   $0xc
  jmp alltraps
80106e88:	e9 13 f9 ff ff       	jmp    801067a0 <alltraps>

80106e8d <vector13>:
.globl vector13
vector13:
  pushl $13
80106e8d:	6a 0d                	push   $0xd
  jmp alltraps
80106e8f:	e9 0c f9 ff ff       	jmp    801067a0 <alltraps>

80106e94 <vector14>:
.globl vector14
vector14:
  pushl $14
80106e94:	6a 0e                	push   $0xe
  jmp alltraps
80106e96:	e9 05 f9 ff ff       	jmp    801067a0 <alltraps>

80106e9b <vector15>:
.globl vector15
vector15:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $15
80106e9d:	6a 0f                	push   $0xf
  jmp alltraps
80106e9f:	e9 fc f8 ff ff       	jmp    801067a0 <alltraps>

80106ea4 <vector16>:
.globl vector16
vector16:
  pushl $0
80106ea4:	6a 00                	push   $0x0
  pushl $16
80106ea6:	6a 10                	push   $0x10
  jmp alltraps
80106ea8:	e9 f3 f8 ff ff       	jmp    801067a0 <alltraps>

80106ead <vector17>:
.globl vector17
vector17:
  pushl $17
80106ead:	6a 11                	push   $0x11
  jmp alltraps
80106eaf:	e9 ec f8 ff ff       	jmp    801067a0 <alltraps>

80106eb4 <vector18>:
.globl vector18
vector18:
  pushl $0
80106eb4:	6a 00                	push   $0x0
  pushl $18
80106eb6:	6a 12                	push   $0x12
  jmp alltraps
80106eb8:	e9 e3 f8 ff ff       	jmp    801067a0 <alltraps>

80106ebd <vector19>:
.globl vector19
vector19:
  pushl $0
80106ebd:	6a 00                	push   $0x0
  pushl $19
80106ebf:	6a 13                	push   $0x13
  jmp alltraps
80106ec1:	e9 da f8 ff ff       	jmp    801067a0 <alltraps>

80106ec6 <vector20>:
.globl vector20
vector20:
  pushl $0
80106ec6:	6a 00                	push   $0x0
  pushl $20
80106ec8:	6a 14                	push   $0x14
  jmp alltraps
80106eca:	e9 d1 f8 ff ff       	jmp    801067a0 <alltraps>

80106ecf <vector21>:
.globl vector21
vector21:
  pushl $0
80106ecf:	6a 00                	push   $0x0
  pushl $21
80106ed1:	6a 15                	push   $0x15
  jmp alltraps
80106ed3:	e9 c8 f8 ff ff       	jmp    801067a0 <alltraps>

80106ed8 <vector22>:
.globl vector22
vector22:
  pushl $0
80106ed8:	6a 00                	push   $0x0
  pushl $22
80106eda:	6a 16                	push   $0x16
  jmp alltraps
80106edc:	e9 bf f8 ff ff       	jmp    801067a0 <alltraps>

80106ee1 <vector23>:
.globl vector23
vector23:
  pushl $0
80106ee1:	6a 00                	push   $0x0
  pushl $23
80106ee3:	6a 17                	push   $0x17
  jmp alltraps
80106ee5:	e9 b6 f8 ff ff       	jmp    801067a0 <alltraps>

80106eea <vector24>:
.globl vector24
vector24:
  pushl $0
80106eea:	6a 00                	push   $0x0
  pushl $24
80106eec:	6a 18                	push   $0x18
  jmp alltraps
80106eee:	e9 ad f8 ff ff       	jmp    801067a0 <alltraps>

80106ef3 <vector25>:
.globl vector25
vector25:
  pushl $0
80106ef3:	6a 00                	push   $0x0
  pushl $25
80106ef5:	6a 19                	push   $0x19
  jmp alltraps
80106ef7:	e9 a4 f8 ff ff       	jmp    801067a0 <alltraps>

80106efc <vector26>:
.globl vector26
vector26:
  pushl $0
80106efc:	6a 00                	push   $0x0
  pushl $26
80106efe:	6a 1a                	push   $0x1a
  jmp alltraps
80106f00:	e9 9b f8 ff ff       	jmp    801067a0 <alltraps>

80106f05 <vector27>:
.globl vector27
vector27:
  pushl $0
80106f05:	6a 00                	push   $0x0
  pushl $27
80106f07:	6a 1b                	push   $0x1b
  jmp alltraps
80106f09:	e9 92 f8 ff ff       	jmp    801067a0 <alltraps>

80106f0e <vector28>:
.globl vector28
vector28:
  pushl $0
80106f0e:	6a 00                	push   $0x0
  pushl $28
80106f10:	6a 1c                	push   $0x1c
  jmp alltraps
80106f12:	e9 89 f8 ff ff       	jmp    801067a0 <alltraps>

80106f17 <vector29>:
.globl vector29
vector29:
  pushl $0
80106f17:	6a 00                	push   $0x0
  pushl $29
80106f19:	6a 1d                	push   $0x1d
  jmp alltraps
80106f1b:	e9 80 f8 ff ff       	jmp    801067a0 <alltraps>

80106f20 <vector30>:
.globl vector30
vector30:
  pushl $0
80106f20:	6a 00                	push   $0x0
  pushl $30
80106f22:	6a 1e                	push   $0x1e
  jmp alltraps
80106f24:	e9 77 f8 ff ff       	jmp    801067a0 <alltraps>

80106f29 <vector31>:
.globl vector31
vector31:
  pushl $0
80106f29:	6a 00                	push   $0x0
  pushl $31
80106f2b:	6a 1f                	push   $0x1f
  jmp alltraps
80106f2d:	e9 6e f8 ff ff       	jmp    801067a0 <alltraps>

80106f32 <vector32>:
.globl vector32
vector32:
  pushl $0
80106f32:	6a 00                	push   $0x0
  pushl $32
80106f34:	6a 20                	push   $0x20
  jmp alltraps
80106f36:	e9 65 f8 ff ff       	jmp    801067a0 <alltraps>

80106f3b <vector33>:
.globl vector33
vector33:
  pushl $0
80106f3b:	6a 00                	push   $0x0
  pushl $33
80106f3d:	6a 21                	push   $0x21
  jmp alltraps
80106f3f:	e9 5c f8 ff ff       	jmp    801067a0 <alltraps>

80106f44 <vector34>:
.globl vector34
vector34:
  pushl $0
80106f44:	6a 00                	push   $0x0
  pushl $34
80106f46:	6a 22                	push   $0x22
  jmp alltraps
80106f48:	e9 53 f8 ff ff       	jmp    801067a0 <alltraps>

80106f4d <vector35>:
.globl vector35
vector35:
  pushl $0
80106f4d:	6a 00                	push   $0x0
  pushl $35
80106f4f:	6a 23                	push   $0x23
  jmp alltraps
80106f51:	e9 4a f8 ff ff       	jmp    801067a0 <alltraps>

80106f56 <vector36>:
.globl vector36
vector36:
  pushl $0
80106f56:	6a 00                	push   $0x0
  pushl $36
80106f58:	6a 24                	push   $0x24
  jmp alltraps
80106f5a:	e9 41 f8 ff ff       	jmp    801067a0 <alltraps>

80106f5f <vector37>:
.globl vector37
vector37:
  pushl $0
80106f5f:	6a 00                	push   $0x0
  pushl $37
80106f61:	6a 25                	push   $0x25
  jmp alltraps
80106f63:	e9 38 f8 ff ff       	jmp    801067a0 <alltraps>

80106f68 <vector38>:
.globl vector38
vector38:
  pushl $0
80106f68:	6a 00                	push   $0x0
  pushl $38
80106f6a:	6a 26                	push   $0x26
  jmp alltraps
80106f6c:	e9 2f f8 ff ff       	jmp    801067a0 <alltraps>

80106f71 <vector39>:
.globl vector39
vector39:
  pushl $0
80106f71:	6a 00                	push   $0x0
  pushl $39
80106f73:	6a 27                	push   $0x27
  jmp alltraps
80106f75:	e9 26 f8 ff ff       	jmp    801067a0 <alltraps>

80106f7a <vector40>:
.globl vector40
vector40:
  pushl $0
80106f7a:	6a 00                	push   $0x0
  pushl $40
80106f7c:	6a 28                	push   $0x28
  jmp alltraps
80106f7e:	e9 1d f8 ff ff       	jmp    801067a0 <alltraps>

80106f83 <vector41>:
.globl vector41
vector41:
  pushl $0
80106f83:	6a 00                	push   $0x0
  pushl $41
80106f85:	6a 29                	push   $0x29
  jmp alltraps
80106f87:	e9 14 f8 ff ff       	jmp    801067a0 <alltraps>

80106f8c <vector42>:
.globl vector42
vector42:
  pushl $0
80106f8c:	6a 00                	push   $0x0
  pushl $42
80106f8e:	6a 2a                	push   $0x2a
  jmp alltraps
80106f90:	e9 0b f8 ff ff       	jmp    801067a0 <alltraps>

80106f95 <vector43>:
.globl vector43
vector43:
  pushl $0
80106f95:	6a 00                	push   $0x0
  pushl $43
80106f97:	6a 2b                	push   $0x2b
  jmp alltraps
80106f99:	e9 02 f8 ff ff       	jmp    801067a0 <alltraps>

80106f9e <vector44>:
.globl vector44
vector44:
  pushl $0
80106f9e:	6a 00                	push   $0x0
  pushl $44
80106fa0:	6a 2c                	push   $0x2c
  jmp alltraps
80106fa2:	e9 f9 f7 ff ff       	jmp    801067a0 <alltraps>

80106fa7 <vector45>:
.globl vector45
vector45:
  pushl $0
80106fa7:	6a 00                	push   $0x0
  pushl $45
80106fa9:	6a 2d                	push   $0x2d
  jmp alltraps
80106fab:	e9 f0 f7 ff ff       	jmp    801067a0 <alltraps>

80106fb0 <vector46>:
.globl vector46
vector46:
  pushl $0
80106fb0:	6a 00                	push   $0x0
  pushl $46
80106fb2:	6a 2e                	push   $0x2e
  jmp alltraps
80106fb4:	e9 e7 f7 ff ff       	jmp    801067a0 <alltraps>

80106fb9 <vector47>:
.globl vector47
vector47:
  pushl $0
80106fb9:	6a 00                	push   $0x0
  pushl $47
80106fbb:	6a 2f                	push   $0x2f
  jmp alltraps
80106fbd:	e9 de f7 ff ff       	jmp    801067a0 <alltraps>

80106fc2 <vector48>:
.globl vector48
vector48:
  pushl $0
80106fc2:	6a 00                	push   $0x0
  pushl $48
80106fc4:	6a 30                	push   $0x30
  jmp alltraps
80106fc6:	e9 d5 f7 ff ff       	jmp    801067a0 <alltraps>

80106fcb <vector49>:
.globl vector49
vector49:
  pushl $0
80106fcb:	6a 00                	push   $0x0
  pushl $49
80106fcd:	6a 31                	push   $0x31
  jmp alltraps
80106fcf:	e9 cc f7 ff ff       	jmp    801067a0 <alltraps>

80106fd4 <vector50>:
.globl vector50
vector50:
  pushl $0
80106fd4:	6a 00                	push   $0x0
  pushl $50
80106fd6:	6a 32                	push   $0x32
  jmp alltraps
80106fd8:	e9 c3 f7 ff ff       	jmp    801067a0 <alltraps>

80106fdd <vector51>:
.globl vector51
vector51:
  pushl $0
80106fdd:	6a 00                	push   $0x0
  pushl $51
80106fdf:	6a 33                	push   $0x33
  jmp alltraps
80106fe1:	e9 ba f7 ff ff       	jmp    801067a0 <alltraps>

80106fe6 <vector52>:
.globl vector52
vector52:
  pushl $0
80106fe6:	6a 00                	push   $0x0
  pushl $52
80106fe8:	6a 34                	push   $0x34
  jmp alltraps
80106fea:	e9 b1 f7 ff ff       	jmp    801067a0 <alltraps>

80106fef <vector53>:
.globl vector53
vector53:
  pushl $0
80106fef:	6a 00                	push   $0x0
  pushl $53
80106ff1:	6a 35                	push   $0x35
  jmp alltraps
80106ff3:	e9 a8 f7 ff ff       	jmp    801067a0 <alltraps>

80106ff8 <vector54>:
.globl vector54
vector54:
  pushl $0
80106ff8:	6a 00                	push   $0x0
  pushl $54
80106ffa:	6a 36                	push   $0x36
  jmp alltraps
80106ffc:	e9 9f f7 ff ff       	jmp    801067a0 <alltraps>

80107001 <vector55>:
.globl vector55
vector55:
  pushl $0
80107001:	6a 00                	push   $0x0
  pushl $55
80107003:	6a 37                	push   $0x37
  jmp alltraps
80107005:	e9 96 f7 ff ff       	jmp    801067a0 <alltraps>

8010700a <vector56>:
.globl vector56
vector56:
  pushl $0
8010700a:	6a 00                	push   $0x0
  pushl $56
8010700c:	6a 38                	push   $0x38
  jmp alltraps
8010700e:	e9 8d f7 ff ff       	jmp    801067a0 <alltraps>

80107013 <vector57>:
.globl vector57
vector57:
  pushl $0
80107013:	6a 00                	push   $0x0
  pushl $57
80107015:	6a 39                	push   $0x39
  jmp alltraps
80107017:	e9 84 f7 ff ff       	jmp    801067a0 <alltraps>

8010701c <vector58>:
.globl vector58
vector58:
  pushl $0
8010701c:	6a 00                	push   $0x0
  pushl $58
8010701e:	6a 3a                	push   $0x3a
  jmp alltraps
80107020:	e9 7b f7 ff ff       	jmp    801067a0 <alltraps>

80107025 <vector59>:
.globl vector59
vector59:
  pushl $0
80107025:	6a 00                	push   $0x0
  pushl $59
80107027:	6a 3b                	push   $0x3b
  jmp alltraps
80107029:	e9 72 f7 ff ff       	jmp    801067a0 <alltraps>

8010702e <vector60>:
.globl vector60
vector60:
  pushl $0
8010702e:	6a 00                	push   $0x0
  pushl $60
80107030:	6a 3c                	push   $0x3c
  jmp alltraps
80107032:	e9 69 f7 ff ff       	jmp    801067a0 <alltraps>

80107037 <vector61>:
.globl vector61
vector61:
  pushl $0
80107037:	6a 00                	push   $0x0
  pushl $61
80107039:	6a 3d                	push   $0x3d
  jmp alltraps
8010703b:	e9 60 f7 ff ff       	jmp    801067a0 <alltraps>

80107040 <vector62>:
.globl vector62
vector62:
  pushl $0
80107040:	6a 00                	push   $0x0
  pushl $62
80107042:	6a 3e                	push   $0x3e
  jmp alltraps
80107044:	e9 57 f7 ff ff       	jmp    801067a0 <alltraps>

80107049 <vector63>:
.globl vector63
vector63:
  pushl $0
80107049:	6a 00                	push   $0x0
  pushl $63
8010704b:	6a 3f                	push   $0x3f
  jmp alltraps
8010704d:	e9 4e f7 ff ff       	jmp    801067a0 <alltraps>

80107052 <vector64>:
.globl vector64
vector64:
  pushl $0
80107052:	6a 00                	push   $0x0
  pushl $64
80107054:	6a 40                	push   $0x40
  jmp alltraps
80107056:	e9 45 f7 ff ff       	jmp    801067a0 <alltraps>

8010705b <vector65>:
.globl vector65
vector65:
  pushl $0
8010705b:	6a 00                	push   $0x0
  pushl $65
8010705d:	6a 41                	push   $0x41
  jmp alltraps
8010705f:	e9 3c f7 ff ff       	jmp    801067a0 <alltraps>

80107064 <vector66>:
.globl vector66
vector66:
  pushl $0
80107064:	6a 00                	push   $0x0
  pushl $66
80107066:	6a 42                	push   $0x42
  jmp alltraps
80107068:	e9 33 f7 ff ff       	jmp    801067a0 <alltraps>

8010706d <vector67>:
.globl vector67
vector67:
  pushl $0
8010706d:	6a 00                	push   $0x0
  pushl $67
8010706f:	6a 43                	push   $0x43
  jmp alltraps
80107071:	e9 2a f7 ff ff       	jmp    801067a0 <alltraps>

80107076 <vector68>:
.globl vector68
vector68:
  pushl $0
80107076:	6a 00                	push   $0x0
  pushl $68
80107078:	6a 44                	push   $0x44
  jmp alltraps
8010707a:	e9 21 f7 ff ff       	jmp    801067a0 <alltraps>

8010707f <vector69>:
.globl vector69
vector69:
  pushl $0
8010707f:	6a 00                	push   $0x0
  pushl $69
80107081:	6a 45                	push   $0x45
  jmp alltraps
80107083:	e9 18 f7 ff ff       	jmp    801067a0 <alltraps>

80107088 <vector70>:
.globl vector70
vector70:
  pushl $0
80107088:	6a 00                	push   $0x0
  pushl $70
8010708a:	6a 46                	push   $0x46
  jmp alltraps
8010708c:	e9 0f f7 ff ff       	jmp    801067a0 <alltraps>

80107091 <vector71>:
.globl vector71
vector71:
  pushl $0
80107091:	6a 00                	push   $0x0
  pushl $71
80107093:	6a 47                	push   $0x47
  jmp alltraps
80107095:	e9 06 f7 ff ff       	jmp    801067a0 <alltraps>

8010709a <vector72>:
.globl vector72
vector72:
  pushl $0
8010709a:	6a 00                	push   $0x0
  pushl $72
8010709c:	6a 48                	push   $0x48
  jmp alltraps
8010709e:	e9 fd f6 ff ff       	jmp    801067a0 <alltraps>

801070a3 <vector73>:
.globl vector73
vector73:
  pushl $0
801070a3:	6a 00                	push   $0x0
  pushl $73
801070a5:	6a 49                	push   $0x49
  jmp alltraps
801070a7:	e9 f4 f6 ff ff       	jmp    801067a0 <alltraps>

801070ac <vector74>:
.globl vector74
vector74:
  pushl $0
801070ac:	6a 00                	push   $0x0
  pushl $74
801070ae:	6a 4a                	push   $0x4a
  jmp alltraps
801070b0:	e9 eb f6 ff ff       	jmp    801067a0 <alltraps>

801070b5 <vector75>:
.globl vector75
vector75:
  pushl $0
801070b5:	6a 00                	push   $0x0
  pushl $75
801070b7:	6a 4b                	push   $0x4b
  jmp alltraps
801070b9:	e9 e2 f6 ff ff       	jmp    801067a0 <alltraps>

801070be <vector76>:
.globl vector76
vector76:
  pushl $0
801070be:	6a 00                	push   $0x0
  pushl $76
801070c0:	6a 4c                	push   $0x4c
  jmp alltraps
801070c2:	e9 d9 f6 ff ff       	jmp    801067a0 <alltraps>

801070c7 <vector77>:
.globl vector77
vector77:
  pushl $0
801070c7:	6a 00                	push   $0x0
  pushl $77
801070c9:	6a 4d                	push   $0x4d
  jmp alltraps
801070cb:	e9 d0 f6 ff ff       	jmp    801067a0 <alltraps>

801070d0 <vector78>:
.globl vector78
vector78:
  pushl $0
801070d0:	6a 00                	push   $0x0
  pushl $78
801070d2:	6a 4e                	push   $0x4e
  jmp alltraps
801070d4:	e9 c7 f6 ff ff       	jmp    801067a0 <alltraps>

801070d9 <vector79>:
.globl vector79
vector79:
  pushl $0
801070d9:	6a 00                	push   $0x0
  pushl $79
801070db:	6a 4f                	push   $0x4f
  jmp alltraps
801070dd:	e9 be f6 ff ff       	jmp    801067a0 <alltraps>

801070e2 <vector80>:
.globl vector80
vector80:
  pushl $0
801070e2:	6a 00                	push   $0x0
  pushl $80
801070e4:	6a 50                	push   $0x50
  jmp alltraps
801070e6:	e9 b5 f6 ff ff       	jmp    801067a0 <alltraps>

801070eb <vector81>:
.globl vector81
vector81:
  pushl $0
801070eb:	6a 00                	push   $0x0
  pushl $81
801070ed:	6a 51                	push   $0x51
  jmp alltraps
801070ef:	e9 ac f6 ff ff       	jmp    801067a0 <alltraps>

801070f4 <vector82>:
.globl vector82
vector82:
  pushl $0
801070f4:	6a 00                	push   $0x0
  pushl $82
801070f6:	6a 52                	push   $0x52
  jmp alltraps
801070f8:	e9 a3 f6 ff ff       	jmp    801067a0 <alltraps>

801070fd <vector83>:
.globl vector83
vector83:
  pushl $0
801070fd:	6a 00                	push   $0x0
  pushl $83
801070ff:	6a 53                	push   $0x53
  jmp alltraps
80107101:	e9 9a f6 ff ff       	jmp    801067a0 <alltraps>

80107106 <vector84>:
.globl vector84
vector84:
  pushl $0
80107106:	6a 00                	push   $0x0
  pushl $84
80107108:	6a 54                	push   $0x54
  jmp alltraps
8010710a:	e9 91 f6 ff ff       	jmp    801067a0 <alltraps>

8010710f <vector85>:
.globl vector85
vector85:
  pushl $0
8010710f:	6a 00                	push   $0x0
  pushl $85
80107111:	6a 55                	push   $0x55
  jmp alltraps
80107113:	e9 88 f6 ff ff       	jmp    801067a0 <alltraps>

80107118 <vector86>:
.globl vector86
vector86:
  pushl $0
80107118:	6a 00                	push   $0x0
  pushl $86
8010711a:	6a 56                	push   $0x56
  jmp alltraps
8010711c:	e9 7f f6 ff ff       	jmp    801067a0 <alltraps>

80107121 <vector87>:
.globl vector87
vector87:
  pushl $0
80107121:	6a 00                	push   $0x0
  pushl $87
80107123:	6a 57                	push   $0x57
  jmp alltraps
80107125:	e9 76 f6 ff ff       	jmp    801067a0 <alltraps>

8010712a <vector88>:
.globl vector88
vector88:
  pushl $0
8010712a:	6a 00                	push   $0x0
  pushl $88
8010712c:	6a 58                	push   $0x58
  jmp alltraps
8010712e:	e9 6d f6 ff ff       	jmp    801067a0 <alltraps>

80107133 <vector89>:
.globl vector89
vector89:
  pushl $0
80107133:	6a 00                	push   $0x0
  pushl $89
80107135:	6a 59                	push   $0x59
  jmp alltraps
80107137:	e9 64 f6 ff ff       	jmp    801067a0 <alltraps>

8010713c <vector90>:
.globl vector90
vector90:
  pushl $0
8010713c:	6a 00                	push   $0x0
  pushl $90
8010713e:	6a 5a                	push   $0x5a
  jmp alltraps
80107140:	e9 5b f6 ff ff       	jmp    801067a0 <alltraps>

80107145 <vector91>:
.globl vector91
vector91:
  pushl $0
80107145:	6a 00                	push   $0x0
  pushl $91
80107147:	6a 5b                	push   $0x5b
  jmp alltraps
80107149:	e9 52 f6 ff ff       	jmp    801067a0 <alltraps>

8010714e <vector92>:
.globl vector92
vector92:
  pushl $0
8010714e:	6a 00                	push   $0x0
  pushl $92
80107150:	6a 5c                	push   $0x5c
  jmp alltraps
80107152:	e9 49 f6 ff ff       	jmp    801067a0 <alltraps>

80107157 <vector93>:
.globl vector93
vector93:
  pushl $0
80107157:	6a 00                	push   $0x0
  pushl $93
80107159:	6a 5d                	push   $0x5d
  jmp alltraps
8010715b:	e9 40 f6 ff ff       	jmp    801067a0 <alltraps>

80107160 <vector94>:
.globl vector94
vector94:
  pushl $0
80107160:	6a 00                	push   $0x0
  pushl $94
80107162:	6a 5e                	push   $0x5e
  jmp alltraps
80107164:	e9 37 f6 ff ff       	jmp    801067a0 <alltraps>

80107169 <vector95>:
.globl vector95
vector95:
  pushl $0
80107169:	6a 00                	push   $0x0
  pushl $95
8010716b:	6a 5f                	push   $0x5f
  jmp alltraps
8010716d:	e9 2e f6 ff ff       	jmp    801067a0 <alltraps>

80107172 <vector96>:
.globl vector96
vector96:
  pushl $0
80107172:	6a 00                	push   $0x0
  pushl $96
80107174:	6a 60                	push   $0x60
  jmp alltraps
80107176:	e9 25 f6 ff ff       	jmp    801067a0 <alltraps>

8010717b <vector97>:
.globl vector97
vector97:
  pushl $0
8010717b:	6a 00                	push   $0x0
  pushl $97
8010717d:	6a 61                	push   $0x61
  jmp alltraps
8010717f:	e9 1c f6 ff ff       	jmp    801067a0 <alltraps>

80107184 <vector98>:
.globl vector98
vector98:
  pushl $0
80107184:	6a 00                	push   $0x0
  pushl $98
80107186:	6a 62                	push   $0x62
  jmp alltraps
80107188:	e9 13 f6 ff ff       	jmp    801067a0 <alltraps>

8010718d <vector99>:
.globl vector99
vector99:
  pushl $0
8010718d:	6a 00                	push   $0x0
  pushl $99
8010718f:	6a 63                	push   $0x63
  jmp alltraps
80107191:	e9 0a f6 ff ff       	jmp    801067a0 <alltraps>

80107196 <vector100>:
.globl vector100
vector100:
  pushl $0
80107196:	6a 00                	push   $0x0
  pushl $100
80107198:	6a 64                	push   $0x64
  jmp alltraps
8010719a:	e9 01 f6 ff ff       	jmp    801067a0 <alltraps>

8010719f <vector101>:
.globl vector101
vector101:
  pushl $0
8010719f:	6a 00                	push   $0x0
  pushl $101
801071a1:	6a 65                	push   $0x65
  jmp alltraps
801071a3:	e9 f8 f5 ff ff       	jmp    801067a0 <alltraps>

801071a8 <vector102>:
.globl vector102
vector102:
  pushl $0
801071a8:	6a 00                	push   $0x0
  pushl $102
801071aa:	6a 66                	push   $0x66
  jmp alltraps
801071ac:	e9 ef f5 ff ff       	jmp    801067a0 <alltraps>

801071b1 <vector103>:
.globl vector103
vector103:
  pushl $0
801071b1:	6a 00                	push   $0x0
  pushl $103
801071b3:	6a 67                	push   $0x67
  jmp alltraps
801071b5:	e9 e6 f5 ff ff       	jmp    801067a0 <alltraps>

801071ba <vector104>:
.globl vector104
vector104:
  pushl $0
801071ba:	6a 00                	push   $0x0
  pushl $104
801071bc:	6a 68                	push   $0x68
  jmp alltraps
801071be:	e9 dd f5 ff ff       	jmp    801067a0 <alltraps>

801071c3 <vector105>:
.globl vector105
vector105:
  pushl $0
801071c3:	6a 00                	push   $0x0
  pushl $105
801071c5:	6a 69                	push   $0x69
  jmp alltraps
801071c7:	e9 d4 f5 ff ff       	jmp    801067a0 <alltraps>

801071cc <vector106>:
.globl vector106
vector106:
  pushl $0
801071cc:	6a 00                	push   $0x0
  pushl $106
801071ce:	6a 6a                	push   $0x6a
  jmp alltraps
801071d0:	e9 cb f5 ff ff       	jmp    801067a0 <alltraps>

801071d5 <vector107>:
.globl vector107
vector107:
  pushl $0
801071d5:	6a 00                	push   $0x0
  pushl $107
801071d7:	6a 6b                	push   $0x6b
  jmp alltraps
801071d9:	e9 c2 f5 ff ff       	jmp    801067a0 <alltraps>

801071de <vector108>:
.globl vector108
vector108:
  pushl $0
801071de:	6a 00                	push   $0x0
  pushl $108
801071e0:	6a 6c                	push   $0x6c
  jmp alltraps
801071e2:	e9 b9 f5 ff ff       	jmp    801067a0 <alltraps>

801071e7 <vector109>:
.globl vector109
vector109:
  pushl $0
801071e7:	6a 00                	push   $0x0
  pushl $109
801071e9:	6a 6d                	push   $0x6d
  jmp alltraps
801071eb:	e9 b0 f5 ff ff       	jmp    801067a0 <alltraps>

801071f0 <vector110>:
.globl vector110
vector110:
  pushl $0
801071f0:	6a 00                	push   $0x0
  pushl $110
801071f2:	6a 6e                	push   $0x6e
  jmp alltraps
801071f4:	e9 a7 f5 ff ff       	jmp    801067a0 <alltraps>

801071f9 <vector111>:
.globl vector111
vector111:
  pushl $0
801071f9:	6a 00                	push   $0x0
  pushl $111
801071fb:	6a 6f                	push   $0x6f
  jmp alltraps
801071fd:	e9 9e f5 ff ff       	jmp    801067a0 <alltraps>

80107202 <vector112>:
.globl vector112
vector112:
  pushl $0
80107202:	6a 00                	push   $0x0
  pushl $112
80107204:	6a 70                	push   $0x70
  jmp alltraps
80107206:	e9 95 f5 ff ff       	jmp    801067a0 <alltraps>

8010720b <vector113>:
.globl vector113
vector113:
  pushl $0
8010720b:	6a 00                	push   $0x0
  pushl $113
8010720d:	6a 71                	push   $0x71
  jmp alltraps
8010720f:	e9 8c f5 ff ff       	jmp    801067a0 <alltraps>

80107214 <vector114>:
.globl vector114
vector114:
  pushl $0
80107214:	6a 00                	push   $0x0
  pushl $114
80107216:	6a 72                	push   $0x72
  jmp alltraps
80107218:	e9 83 f5 ff ff       	jmp    801067a0 <alltraps>

8010721d <vector115>:
.globl vector115
vector115:
  pushl $0
8010721d:	6a 00                	push   $0x0
  pushl $115
8010721f:	6a 73                	push   $0x73
  jmp alltraps
80107221:	e9 7a f5 ff ff       	jmp    801067a0 <alltraps>

80107226 <vector116>:
.globl vector116
vector116:
  pushl $0
80107226:	6a 00                	push   $0x0
  pushl $116
80107228:	6a 74                	push   $0x74
  jmp alltraps
8010722a:	e9 71 f5 ff ff       	jmp    801067a0 <alltraps>

8010722f <vector117>:
.globl vector117
vector117:
  pushl $0
8010722f:	6a 00                	push   $0x0
  pushl $117
80107231:	6a 75                	push   $0x75
  jmp alltraps
80107233:	e9 68 f5 ff ff       	jmp    801067a0 <alltraps>

80107238 <vector118>:
.globl vector118
vector118:
  pushl $0
80107238:	6a 00                	push   $0x0
  pushl $118
8010723a:	6a 76                	push   $0x76
  jmp alltraps
8010723c:	e9 5f f5 ff ff       	jmp    801067a0 <alltraps>

80107241 <vector119>:
.globl vector119
vector119:
  pushl $0
80107241:	6a 00                	push   $0x0
  pushl $119
80107243:	6a 77                	push   $0x77
  jmp alltraps
80107245:	e9 56 f5 ff ff       	jmp    801067a0 <alltraps>

8010724a <vector120>:
.globl vector120
vector120:
  pushl $0
8010724a:	6a 00                	push   $0x0
  pushl $120
8010724c:	6a 78                	push   $0x78
  jmp alltraps
8010724e:	e9 4d f5 ff ff       	jmp    801067a0 <alltraps>

80107253 <vector121>:
.globl vector121
vector121:
  pushl $0
80107253:	6a 00                	push   $0x0
  pushl $121
80107255:	6a 79                	push   $0x79
  jmp alltraps
80107257:	e9 44 f5 ff ff       	jmp    801067a0 <alltraps>

8010725c <vector122>:
.globl vector122
vector122:
  pushl $0
8010725c:	6a 00                	push   $0x0
  pushl $122
8010725e:	6a 7a                	push   $0x7a
  jmp alltraps
80107260:	e9 3b f5 ff ff       	jmp    801067a0 <alltraps>

80107265 <vector123>:
.globl vector123
vector123:
  pushl $0
80107265:	6a 00                	push   $0x0
  pushl $123
80107267:	6a 7b                	push   $0x7b
  jmp alltraps
80107269:	e9 32 f5 ff ff       	jmp    801067a0 <alltraps>

8010726e <vector124>:
.globl vector124
vector124:
  pushl $0
8010726e:	6a 00                	push   $0x0
  pushl $124
80107270:	6a 7c                	push   $0x7c
  jmp alltraps
80107272:	e9 29 f5 ff ff       	jmp    801067a0 <alltraps>

80107277 <vector125>:
.globl vector125
vector125:
  pushl $0
80107277:	6a 00                	push   $0x0
  pushl $125
80107279:	6a 7d                	push   $0x7d
  jmp alltraps
8010727b:	e9 20 f5 ff ff       	jmp    801067a0 <alltraps>

80107280 <vector126>:
.globl vector126
vector126:
  pushl $0
80107280:	6a 00                	push   $0x0
  pushl $126
80107282:	6a 7e                	push   $0x7e
  jmp alltraps
80107284:	e9 17 f5 ff ff       	jmp    801067a0 <alltraps>

80107289 <vector127>:
.globl vector127
vector127:
  pushl $0
80107289:	6a 00                	push   $0x0
  pushl $127
8010728b:	6a 7f                	push   $0x7f
  jmp alltraps
8010728d:	e9 0e f5 ff ff       	jmp    801067a0 <alltraps>

80107292 <vector128>:
.globl vector128
vector128:
  pushl $0
80107292:	6a 00                	push   $0x0
  pushl $128
80107294:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80107299:	e9 02 f5 ff ff       	jmp    801067a0 <alltraps>

8010729e <vector129>:
.globl vector129
vector129:
  pushl $0
8010729e:	6a 00                	push   $0x0
  pushl $129
801072a0:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801072a5:	e9 f6 f4 ff ff       	jmp    801067a0 <alltraps>

801072aa <vector130>:
.globl vector130
vector130:
  pushl $0
801072aa:	6a 00                	push   $0x0
  pushl $130
801072ac:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801072b1:	e9 ea f4 ff ff       	jmp    801067a0 <alltraps>

801072b6 <vector131>:
.globl vector131
vector131:
  pushl $0
801072b6:	6a 00                	push   $0x0
  pushl $131
801072b8:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801072bd:	e9 de f4 ff ff       	jmp    801067a0 <alltraps>

801072c2 <vector132>:
.globl vector132
vector132:
  pushl $0
801072c2:	6a 00                	push   $0x0
  pushl $132
801072c4:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801072c9:	e9 d2 f4 ff ff       	jmp    801067a0 <alltraps>

801072ce <vector133>:
.globl vector133
vector133:
  pushl $0
801072ce:	6a 00                	push   $0x0
  pushl $133
801072d0:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801072d5:	e9 c6 f4 ff ff       	jmp    801067a0 <alltraps>

801072da <vector134>:
.globl vector134
vector134:
  pushl $0
801072da:	6a 00                	push   $0x0
  pushl $134
801072dc:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801072e1:	e9 ba f4 ff ff       	jmp    801067a0 <alltraps>

801072e6 <vector135>:
.globl vector135
vector135:
  pushl $0
801072e6:	6a 00                	push   $0x0
  pushl $135
801072e8:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801072ed:	e9 ae f4 ff ff       	jmp    801067a0 <alltraps>

801072f2 <vector136>:
.globl vector136
vector136:
  pushl $0
801072f2:	6a 00                	push   $0x0
  pushl $136
801072f4:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801072f9:	e9 a2 f4 ff ff       	jmp    801067a0 <alltraps>

801072fe <vector137>:
.globl vector137
vector137:
  pushl $0
801072fe:	6a 00                	push   $0x0
  pushl $137
80107300:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107305:	e9 96 f4 ff ff       	jmp    801067a0 <alltraps>

8010730a <vector138>:
.globl vector138
vector138:
  pushl $0
8010730a:	6a 00                	push   $0x0
  pushl $138
8010730c:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107311:	e9 8a f4 ff ff       	jmp    801067a0 <alltraps>

80107316 <vector139>:
.globl vector139
vector139:
  pushl $0
80107316:	6a 00                	push   $0x0
  pushl $139
80107318:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
8010731d:	e9 7e f4 ff ff       	jmp    801067a0 <alltraps>

80107322 <vector140>:
.globl vector140
vector140:
  pushl $0
80107322:	6a 00                	push   $0x0
  pushl $140
80107324:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107329:	e9 72 f4 ff ff       	jmp    801067a0 <alltraps>

8010732e <vector141>:
.globl vector141
vector141:
  pushl $0
8010732e:	6a 00                	push   $0x0
  pushl $141
80107330:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107335:	e9 66 f4 ff ff       	jmp    801067a0 <alltraps>

8010733a <vector142>:
.globl vector142
vector142:
  pushl $0
8010733a:	6a 00                	push   $0x0
  pushl $142
8010733c:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107341:	e9 5a f4 ff ff       	jmp    801067a0 <alltraps>

80107346 <vector143>:
.globl vector143
vector143:
  pushl $0
80107346:	6a 00                	push   $0x0
  pushl $143
80107348:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
8010734d:	e9 4e f4 ff ff       	jmp    801067a0 <alltraps>

80107352 <vector144>:
.globl vector144
vector144:
  pushl $0
80107352:	6a 00                	push   $0x0
  pushl $144
80107354:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107359:	e9 42 f4 ff ff       	jmp    801067a0 <alltraps>

8010735e <vector145>:
.globl vector145
vector145:
  pushl $0
8010735e:	6a 00                	push   $0x0
  pushl $145
80107360:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107365:	e9 36 f4 ff ff       	jmp    801067a0 <alltraps>

8010736a <vector146>:
.globl vector146
vector146:
  pushl $0
8010736a:	6a 00                	push   $0x0
  pushl $146
8010736c:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107371:	e9 2a f4 ff ff       	jmp    801067a0 <alltraps>

80107376 <vector147>:
.globl vector147
vector147:
  pushl $0
80107376:	6a 00                	push   $0x0
  pushl $147
80107378:	68 93 00 00 00       	push   $0x93
  jmp alltraps
8010737d:	e9 1e f4 ff ff       	jmp    801067a0 <alltraps>

80107382 <vector148>:
.globl vector148
vector148:
  pushl $0
80107382:	6a 00                	push   $0x0
  pushl $148
80107384:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80107389:	e9 12 f4 ff ff       	jmp    801067a0 <alltraps>

8010738e <vector149>:
.globl vector149
vector149:
  pushl $0
8010738e:	6a 00                	push   $0x0
  pushl $149
80107390:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107395:	e9 06 f4 ff ff       	jmp    801067a0 <alltraps>

8010739a <vector150>:
.globl vector150
vector150:
  pushl $0
8010739a:	6a 00                	push   $0x0
  pushl $150
8010739c:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801073a1:	e9 fa f3 ff ff       	jmp    801067a0 <alltraps>

801073a6 <vector151>:
.globl vector151
vector151:
  pushl $0
801073a6:	6a 00                	push   $0x0
  pushl $151
801073a8:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801073ad:	e9 ee f3 ff ff       	jmp    801067a0 <alltraps>

801073b2 <vector152>:
.globl vector152
vector152:
  pushl $0
801073b2:	6a 00                	push   $0x0
  pushl $152
801073b4:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801073b9:	e9 e2 f3 ff ff       	jmp    801067a0 <alltraps>

801073be <vector153>:
.globl vector153
vector153:
  pushl $0
801073be:	6a 00                	push   $0x0
  pushl $153
801073c0:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801073c5:	e9 d6 f3 ff ff       	jmp    801067a0 <alltraps>

801073ca <vector154>:
.globl vector154
vector154:
  pushl $0
801073ca:	6a 00                	push   $0x0
  pushl $154
801073cc:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801073d1:	e9 ca f3 ff ff       	jmp    801067a0 <alltraps>

801073d6 <vector155>:
.globl vector155
vector155:
  pushl $0
801073d6:	6a 00                	push   $0x0
  pushl $155
801073d8:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801073dd:	e9 be f3 ff ff       	jmp    801067a0 <alltraps>

801073e2 <vector156>:
.globl vector156
vector156:
  pushl $0
801073e2:	6a 00                	push   $0x0
  pushl $156
801073e4:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801073e9:	e9 b2 f3 ff ff       	jmp    801067a0 <alltraps>

801073ee <vector157>:
.globl vector157
vector157:
  pushl $0
801073ee:	6a 00                	push   $0x0
  pushl $157
801073f0:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801073f5:	e9 a6 f3 ff ff       	jmp    801067a0 <alltraps>

801073fa <vector158>:
.globl vector158
vector158:
  pushl $0
801073fa:	6a 00                	push   $0x0
  pushl $158
801073fc:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107401:	e9 9a f3 ff ff       	jmp    801067a0 <alltraps>

80107406 <vector159>:
.globl vector159
vector159:
  pushl $0
80107406:	6a 00                	push   $0x0
  pushl $159
80107408:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
8010740d:	e9 8e f3 ff ff       	jmp    801067a0 <alltraps>

80107412 <vector160>:
.globl vector160
vector160:
  pushl $0
80107412:	6a 00                	push   $0x0
  pushl $160
80107414:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80107419:	e9 82 f3 ff ff       	jmp    801067a0 <alltraps>

8010741e <vector161>:
.globl vector161
vector161:
  pushl $0
8010741e:	6a 00                	push   $0x0
  pushl $161
80107420:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107425:	e9 76 f3 ff ff       	jmp    801067a0 <alltraps>

8010742a <vector162>:
.globl vector162
vector162:
  pushl $0
8010742a:	6a 00                	push   $0x0
  pushl $162
8010742c:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107431:	e9 6a f3 ff ff       	jmp    801067a0 <alltraps>

80107436 <vector163>:
.globl vector163
vector163:
  pushl $0
80107436:	6a 00                	push   $0x0
  pushl $163
80107438:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
8010743d:	e9 5e f3 ff ff       	jmp    801067a0 <alltraps>

80107442 <vector164>:
.globl vector164
vector164:
  pushl $0
80107442:	6a 00                	push   $0x0
  pushl $164
80107444:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107449:	e9 52 f3 ff ff       	jmp    801067a0 <alltraps>

8010744e <vector165>:
.globl vector165
vector165:
  pushl $0
8010744e:	6a 00                	push   $0x0
  pushl $165
80107450:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107455:	e9 46 f3 ff ff       	jmp    801067a0 <alltraps>

8010745a <vector166>:
.globl vector166
vector166:
  pushl $0
8010745a:	6a 00                	push   $0x0
  pushl $166
8010745c:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107461:	e9 3a f3 ff ff       	jmp    801067a0 <alltraps>

80107466 <vector167>:
.globl vector167
vector167:
  pushl $0
80107466:	6a 00                	push   $0x0
  pushl $167
80107468:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
8010746d:	e9 2e f3 ff ff       	jmp    801067a0 <alltraps>

80107472 <vector168>:
.globl vector168
vector168:
  pushl $0
80107472:	6a 00                	push   $0x0
  pushl $168
80107474:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107479:	e9 22 f3 ff ff       	jmp    801067a0 <alltraps>

8010747e <vector169>:
.globl vector169
vector169:
  pushl $0
8010747e:	6a 00                	push   $0x0
  pushl $169
80107480:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107485:	e9 16 f3 ff ff       	jmp    801067a0 <alltraps>

8010748a <vector170>:
.globl vector170
vector170:
  pushl $0
8010748a:	6a 00                	push   $0x0
  pushl $170
8010748c:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107491:	e9 0a f3 ff ff       	jmp    801067a0 <alltraps>

80107496 <vector171>:
.globl vector171
vector171:
  pushl $0
80107496:	6a 00                	push   $0x0
  pushl $171
80107498:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
8010749d:	e9 fe f2 ff ff       	jmp    801067a0 <alltraps>

801074a2 <vector172>:
.globl vector172
vector172:
  pushl $0
801074a2:	6a 00                	push   $0x0
  pushl $172
801074a4:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801074a9:	e9 f2 f2 ff ff       	jmp    801067a0 <alltraps>

801074ae <vector173>:
.globl vector173
vector173:
  pushl $0
801074ae:	6a 00                	push   $0x0
  pushl $173
801074b0:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801074b5:	e9 e6 f2 ff ff       	jmp    801067a0 <alltraps>

801074ba <vector174>:
.globl vector174
vector174:
  pushl $0
801074ba:	6a 00                	push   $0x0
  pushl $174
801074bc:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801074c1:	e9 da f2 ff ff       	jmp    801067a0 <alltraps>

801074c6 <vector175>:
.globl vector175
vector175:
  pushl $0
801074c6:	6a 00                	push   $0x0
  pushl $175
801074c8:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801074cd:	e9 ce f2 ff ff       	jmp    801067a0 <alltraps>

801074d2 <vector176>:
.globl vector176
vector176:
  pushl $0
801074d2:	6a 00                	push   $0x0
  pushl $176
801074d4:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801074d9:	e9 c2 f2 ff ff       	jmp    801067a0 <alltraps>

801074de <vector177>:
.globl vector177
vector177:
  pushl $0
801074de:	6a 00                	push   $0x0
  pushl $177
801074e0:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801074e5:	e9 b6 f2 ff ff       	jmp    801067a0 <alltraps>

801074ea <vector178>:
.globl vector178
vector178:
  pushl $0
801074ea:	6a 00                	push   $0x0
  pushl $178
801074ec:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801074f1:	e9 aa f2 ff ff       	jmp    801067a0 <alltraps>

801074f6 <vector179>:
.globl vector179
vector179:
  pushl $0
801074f6:	6a 00                	push   $0x0
  pushl $179
801074f8:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801074fd:	e9 9e f2 ff ff       	jmp    801067a0 <alltraps>

80107502 <vector180>:
.globl vector180
vector180:
  pushl $0
80107502:	6a 00                	push   $0x0
  pushl $180
80107504:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107509:	e9 92 f2 ff ff       	jmp    801067a0 <alltraps>

8010750e <vector181>:
.globl vector181
vector181:
  pushl $0
8010750e:	6a 00                	push   $0x0
  pushl $181
80107510:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107515:	e9 86 f2 ff ff       	jmp    801067a0 <alltraps>

8010751a <vector182>:
.globl vector182
vector182:
  pushl $0
8010751a:	6a 00                	push   $0x0
  pushl $182
8010751c:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107521:	e9 7a f2 ff ff       	jmp    801067a0 <alltraps>

80107526 <vector183>:
.globl vector183
vector183:
  pushl $0
80107526:	6a 00                	push   $0x0
  pushl $183
80107528:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
8010752d:	e9 6e f2 ff ff       	jmp    801067a0 <alltraps>

80107532 <vector184>:
.globl vector184
vector184:
  pushl $0
80107532:	6a 00                	push   $0x0
  pushl $184
80107534:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107539:	e9 62 f2 ff ff       	jmp    801067a0 <alltraps>

8010753e <vector185>:
.globl vector185
vector185:
  pushl $0
8010753e:	6a 00                	push   $0x0
  pushl $185
80107540:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107545:	e9 56 f2 ff ff       	jmp    801067a0 <alltraps>

8010754a <vector186>:
.globl vector186
vector186:
  pushl $0
8010754a:	6a 00                	push   $0x0
  pushl $186
8010754c:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107551:	e9 4a f2 ff ff       	jmp    801067a0 <alltraps>

80107556 <vector187>:
.globl vector187
vector187:
  pushl $0
80107556:	6a 00                	push   $0x0
  pushl $187
80107558:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
8010755d:	e9 3e f2 ff ff       	jmp    801067a0 <alltraps>

80107562 <vector188>:
.globl vector188
vector188:
  pushl $0
80107562:	6a 00                	push   $0x0
  pushl $188
80107564:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107569:	e9 32 f2 ff ff       	jmp    801067a0 <alltraps>

8010756e <vector189>:
.globl vector189
vector189:
  pushl $0
8010756e:	6a 00                	push   $0x0
  pushl $189
80107570:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107575:	e9 26 f2 ff ff       	jmp    801067a0 <alltraps>

8010757a <vector190>:
.globl vector190
vector190:
  pushl $0
8010757a:	6a 00                	push   $0x0
  pushl $190
8010757c:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107581:	e9 1a f2 ff ff       	jmp    801067a0 <alltraps>

80107586 <vector191>:
.globl vector191
vector191:
  pushl $0
80107586:	6a 00                	push   $0x0
  pushl $191
80107588:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
8010758d:	e9 0e f2 ff ff       	jmp    801067a0 <alltraps>

80107592 <vector192>:
.globl vector192
vector192:
  pushl $0
80107592:	6a 00                	push   $0x0
  pushl $192
80107594:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107599:	e9 02 f2 ff ff       	jmp    801067a0 <alltraps>

8010759e <vector193>:
.globl vector193
vector193:
  pushl $0
8010759e:	6a 00                	push   $0x0
  pushl $193
801075a0:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801075a5:	e9 f6 f1 ff ff       	jmp    801067a0 <alltraps>

801075aa <vector194>:
.globl vector194
vector194:
  pushl $0
801075aa:	6a 00                	push   $0x0
  pushl $194
801075ac:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801075b1:	e9 ea f1 ff ff       	jmp    801067a0 <alltraps>

801075b6 <vector195>:
.globl vector195
vector195:
  pushl $0
801075b6:	6a 00                	push   $0x0
  pushl $195
801075b8:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801075bd:	e9 de f1 ff ff       	jmp    801067a0 <alltraps>

801075c2 <vector196>:
.globl vector196
vector196:
  pushl $0
801075c2:	6a 00                	push   $0x0
  pushl $196
801075c4:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801075c9:	e9 d2 f1 ff ff       	jmp    801067a0 <alltraps>

801075ce <vector197>:
.globl vector197
vector197:
  pushl $0
801075ce:	6a 00                	push   $0x0
  pushl $197
801075d0:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801075d5:	e9 c6 f1 ff ff       	jmp    801067a0 <alltraps>

801075da <vector198>:
.globl vector198
vector198:
  pushl $0
801075da:	6a 00                	push   $0x0
  pushl $198
801075dc:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801075e1:	e9 ba f1 ff ff       	jmp    801067a0 <alltraps>

801075e6 <vector199>:
.globl vector199
vector199:
  pushl $0
801075e6:	6a 00                	push   $0x0
  pushl $199
801075e8:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801075ed:	e9 ae f1 ff ff       	jmp    801067a0 <alltraps>

801075f2 <vector200>:
.globl vector200
vector200:
  pushl $0
801075f2:	6a 00                	push   $0x0
  pushl $200
801075f4:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801075f9:	e9 a2 f1 ff ff       	jmp    801067a0 <alltraps>

801075fe <vector201>:
.globl vector201
vector201:
  pushl $0
801075fe:	6a 00                	push   $0x0
  pushl $201
80107600:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107605:	e9 96 f1 ff ff       	jmp    801067a0 <alltraps>

8010760a <vector202>:
.globl vector202
vector202:
  pushl $0
8010760a:	6a 00                	push   $0x0
  pushl $202
8010760c:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107611:	e9 8a f1 ff ff       	jmp    801067a0 <alltraps>

80107616 <vector203>:
.globl vector203
vector203:
  pushl $0
80107616:	6a 00                	push   $0x0
  pushl $203
80107618:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
8010761d:	e9 7e f1 ff ff       	jmp    801067a0 <alltraps>

80107622 <vector204>:
.globl vector204
vector204:
  pushl $0
80107622:	6a 00                	push   $0x0
  pushl $204
80107624:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107629:	e9 72 f1 ff ff       	jmp    801067a0 <alltraps>

8010762e <vector205>:
.globl vector205
vector205:
  pushl $0
8010762e:	6a 00                	push   $0x0
  pushl $205
80107630:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107635:	e9 66 f1 ff ff       	jmp    801067a0 <alltraps>

8010763a <vector206>:
.globl vector206
vector206:
  pushl $0
8010763a:	6a 00                	push   $0x0
  pushl $206
8010763c:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107641:	e9 5a f1 ff ff       	jmp    801067a0 <alltraps>

80107646 <vector207>:
.globl vector207
vector207:
  pushl $0
80107646:	6a 00                	push   $0x0
  pushl $207
80107648:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
8010764d:	e9 4e f1 ff ff       	jmp    801067a0 <alltraps>

80107652 <vector208>:
.globl vector208
vector208:
  pushl $0
80107652:	6a 00                	push   $0x0
  pushl $208
80107654:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107659:	e9 42 f1 ff ff       	jmp    801067a0 <alltraps>

8010765e <vector209>:
.globl vector209
vector209:
  pushl $0
8010765e:	6a 00                	push   $0x0
  pushl $209
80107660:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107665:	e9 36 f1 ff ff       	jmp    801067a0 <alltraps>

8010766a <vector210>:
.globl vector210
vector210:
  pushl $0
8010766a:	6a 00                	push   $0x0
  pushl $210
8010766c:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107671:	e9 2a f1 ff ff       	jmp    801067a0 <alltraps>

80107676 <vector211>:
.globl vector211
vector211:
  pushl $0
80107676:	6a 00                	push   $0x0
  pushl $211
80107678:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
8010767d:	e9 1e f1 ff ff       	jmp    801067a0 <alltraps>

80107682 <vector212>:
.globl vector212
vector212:
  pushl $0
80107682:	6a 00                	push   $0x0
  pushl $212
80107684:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107689:	e9 12 f1 ff ff       	jmp    801067a0 <alltraps>

8010768e <vector213>:
.globl vector213
vector213:
  pushl $0
8010768e:	6a 00                	push   $0x0
  pushl $213
80107690:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107695:	e9 06 f1 ff ff       	jmp    801067a0 <alltraps>

8010769a <vector214>:
.globl vector214
vector214:
  pushl $0
8010769a:	6a 00                	push   $0x0
  pushl $214
8010769c:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801076a1:	e9 fa f0 ff ff       	jmp    801067a0 <alltraps>

801076a6 <vector215>:
.globl vector215
vector215:
  pushl $0
801076a6:	6a 00                	push   $0x0
  pushl $215
801076a8:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801076ad:	e9 ee f0 ff ff       	jmp    801067a0 <alltraps>

801076b2 <vector216>:
.globl vector216
vector216:
  pushl $0
801076b2:	6a 00                	push   $0x0
  pushl $216
801076b4:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801076b9:	e9 e2 f0 ff ff       	jmp    801067a0 <alltraps>

801076be <vector217>:
.globl vector217
vector217:
  pushl $0
801076be:	6a 00                	push   $0x0
  pushl $217
801076c0:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801076c5:	e9 d6 f0 ff ff       	jmp    801067a0 <alltraps>

801076ca <vector218>:
.globl vector218
vector218:
  pushl $0
801076ca:	6a 00                	push   $0x0
  pushl $218
801076cc:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801076d1:	e9 ca f0 ff ff       	jmp    801067a0 <alltraps>

801076d6 <vector219>:
.globl vector219
vector219:
  pushl $0
801076d6:	6a 00                	push   $0x0
  pushl $219
801076d8:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801076dd:	e9 be f0 ff ff       	jmp    801067a0 <alltraps>

801076e2 <vector220>:
.globl vector220
vector220:
  pushl $0
801076e2:	6a 00                	push   $0x0
  pushl $220
801076e4:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801076e9:	e9 b2 f0 ff ff       	jmp    801067a0 <alltraps>

801076ee <vector221>:
.globl vector221
vector221:
  pushl $0
801076ee:	6a 00                	push   $0x0
  pushl $221
801076f0:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801076f5:	e9 a6 f0 ff ff       	jmp    801067a0 <alltraps>

801076fa <vector222>:
.globl vector222
vector222:
  pushl $0
801076fa:	6a 00                	push   $0x0
  pushl $222
801076fc:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107701:	e9 9a f0 ff ff       	jmp    801067a0 <alltraps>

80107706 <vector223>:
.globl vector223
vector223:
  pushl $0
80107706:	6a 00                	push   $0x0
  pushl $223
80107708:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
8010770d:	e9 8e f0 ff ff       	jmp    801067a0 <alltraps>

80107712 <vector224>:
.globl vector224
vector224:
  pushl $0
80107712:	6a 00                	push   $0x0
  pushl $224
80107714:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107719:	e9 82 f0 ff ff       	jmp    801067a0 <alltraps>

8010771e <vector225>:
.globl vector225
vector225:
  pushl $0
8010771e:	6a 00                	push   $0x0
  pushl $225
80107720:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107725:	e9 76 f0 ff ff       	jmp    801067a0 <alltraps>

8010772a <vector226>:
.globl vector226
vector226:
  pushl $0
8010772a:	6a 00                	push   $0x0
  pushl $226
8010772c:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107731:	e9 6a f0 ff ff       	jmp    801067a0 <alltraps>

80107736 <vector227>:
.globl vector227
vector227:
  pushl $0
80107736:	6a 00                	push   $0x0
  pushl $227
80107738:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
8010773d:	e9 5e f0 ff ff       	jmp    801067a0 <alltraps>

80107742 <vector228>:
.globl vector228
vector228:
  pushl $0
80107742:	6a 00                	push   $0x0
  pushl $228
80107744:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107749:	e9 52 f0 ff ff       	jmp    801067a0 <alltraps>

8010774e <vector229>:
.globl vector229
vector229:
  pushl $0
8010774e:	6a 00                	push   $0x0
  pushl $229
80107750:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107755:	e9 46 f0 ff ff       	jmp    801067a0 <alltraps>

8010775a <vector230>:
.globl vector230
vector230:
  pushl $0
8010775a:	6a 00                	push   $0x0
  pushl $230
8010775c:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107761:	e9 3a f0 ff ff       	jmp    801067a0 <alltraps>

80107766 <vector231>:
.globl vector231
vector231:
  pushl $0
80107766:	6a 00                	push   $0x0
  pushl $231
80107768:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
8010776d:	e9 2e f0 ff ff       	jmp    801067a0 <alltraps>

80107772 <vector232>:
.globl vector232
vector232:
  pushl $0
80107772:	6a 00                	push   $0x0
  pushl $232
80107774:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107779:	e9 22 f0 ff ff       	jmp    801067a0 <alltraps>

8010777e <vector233>:
.globl vector233
vector233:
  pushl $0
8010777e:	6a 00                	push   $0x0
  pushl $233
80107780:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107785:	e9 16 f0 ff ff       	jmp    801067a0 <alltraps>

8010778a <vector234>:
.globl vector234
vector234:
  pushl $0
8010778a:	6a 00                	push   $0x0
  pushl $234
8010778c:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107791:	e9 0a f0 ff ff       	jmp    801067a0 <alltraps>

80107796 <vector235>:
.globl vector235
vector235:
  pushl $0
80107796:	6a 00                	push   $0x0
  pushl $235
80107798:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
8010779d:	e9 fe ef ff ff       	jmp    801067a0 <alltraps>

801077a2 <vector236>:
.globl vector236
vector236:
  pushl $0
801077a2:	6a 00                	push   $0x0
  pushl $236
801077a4:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801077a9:	e9 f2 ef ff ff       	jmp    801067a0 <alltraps>

801077ae <vector237>:
.globl vector237
vector237:
  pushl $0
801077ae:	6a 00                	push   $0x0
  pushl $237
801077b0:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801077b5:	e9 e6 ef ff ff       	jmp    801067a0 <alltraps>

801077ba <vector238>:
.globl vector238
vector238:
  pushl $0
801077ba:	6a 00                	push   $0x0
  pushl $238
801077bc:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801077c1:	e9 da ef ff ff       	jmp    801067a0 <alltraps>

801077c6 <vector239>:
.globl vector239
vector239:
  pushl $0
801077c6:	6a 00                	push   $0x0
  pushl $239
801077c8:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801077cd:	e9 ce ef ff ff       	jmp    801067a0 <alltraps>

801077d2 <vector240>:
.globl vector240
vector240:
  pushl $0
801077d2:	6a 00                	push   $0x0
  pushl $240
801077d4:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801077d9:	e9 c2 ef ff ff       	jmp    801067a0 <alltraps>

801077de <vector241>:
.globl vector241
vector241:
  pushl $0
801077de:	6a 00                	push   $0x0
  pushl $241
801077e0:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801077e5:	e9 b6 ef ff ff       	jmp    801067a0 <alltraps>

801077ea <vector242>:
.globl vector242
vector242:
  pushl $0
801077ea:	6a 00                	push   $0x0
  pushl $242
801077ec:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801077f1:	e9 aa ef ff ff       	jmp    801067a0 <alltraps>

801077f6 <vector243>:
.globl vector243
vector243:
  pushl $0
801077f6:	6a 00                	push   $0x0
  pushl $243
801077f8:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801077fd:	e9 9e ef ff ff       	jmp    801067a0 <alltraps>

80107802 <vector244>:
.globl vector244
vector244:
  pushl $0
80107802:	6a 00                	push   $0x0
  pushl $244
80107804:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107809:	e9 92 ef ff ff       	jmp    801067a0 <alltraps>

8010780e <vector245>:
.globl vector245
vector245:
  pushl $0
8010780e:	6a 00                	push   $0x0
  pushl $245
80107810:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107815:	e9 86 ef ff ff       	jmp    801067a0 <alltraps>

8010781a <vector246>:
.globl vector246
vector246:
  pushl $0
8010781a:	6a 00                	push   $0x0
  pushl $246
8010781c:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107821:	e9 7a ef ff ff       	jmp    801067a0 <alltraps>

80107826 <vector247>:
.globl vector247
vector247:
  pushl $0
80107826:	6a 00                	push   $0x0
  pushl $247
80107828:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
8010782d:	e9 6e ef ff ff       	jmp    801067a0 <alltraps>

80107832 <vector248>:
.globl vector248
vector248:
  pushl $0
80107832:	6a 00                	push   $0x0
  pushl $248
80107834:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107839:	e9 62 ef ff ff       	jmp    801067a0 <alltraps>

8010783e <vector249>:
.globl vector249
vector249:
  pushl $0
8010783e:	6a 00                	push   $0x0
  pushl $249
80107840:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107845:	e9 56 ef ff ff       	jmp    801067a0 <alltraps>

8010784a <vector250>:
.globl vector250
vector250:
  pushl $0
8010784a:	6a 00                	push   $0x0
  pushl $250
8010784c:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107851:	e9 4a ef ff ff       	jmp    801067a0 <alltraps>

80107856 <vector251>:
.globl vector251
vector251:
  pushl $0
80107856:	6a 00                	push   $0x0
  pushl $251
80107858:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
8010785d:	e9 3e ef ff ff       	jmp    801067a0 <alltraps>

80107862 <vector252>:
.globl vector252
vector252:
  pushl $0
80107862:	6a 00                	push   $0x0
  pushl $252
80107864:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107869:	e9 32 ef ff ff       	jmp    801067a0 <alltraps>

8010786e <vector253>:
.globl vector253
vector253:
  pushl $0
8010786e:	6a 00                	push   $0x0
  pushl $253
80107870:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107875:	e9 26 ef ff ff       	jmp    801067a0 <alltraps>

8010787a <vector254>:
.globl vector254
vector254:
  pushl $0
8010787a:	6a 00                	push   $0x0
  pushl $254
8010787c:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107881:	e9 1a ef ff ff       	jmp    801067a0 <alltraps>

80107886 <vector255>:
.globl vector255
vector255:
  pushl $0
80107886:	6a 00                	push   $0x0
  pushl $255
80107888:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
8010788d:	e9 0e ef ff ff       	jmp    801067a0 <alltraps>
80107892:	66 90                	xchg   %ax,%ax

80107894 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80107894:	55                   	push   %ebp
80107895:	89 e5                	mov    %esp,%ebp
80107897:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
8010789a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010789d:	83 e8 01             	sub    $0x1,%eax
801078a0:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801078a4:	8b 45 08             	mov    0x8(%ebp),%eax
801078a7:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801078ab:	8b 45 08             	mov    0x8(%ebp),%eax
801078ae:	c1 e8 10             	shr    $0x10,%eax
801078b1:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
801078b5:	8d 45 fa             	lea    -0x6(%ebp),%eax
801078b8:	0f 01 10             	lgdtl  (%eax)
}
801078bb:	c9                   	leave  
801078bc:	c3                   	ret    

801078bd <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
801078bd:	55                   	push   %ebp
801078be:	89 e5                	mov    %esp,%ebp
801078c0:	83 ec 04             	sub    $0x4,%esp
801078c3:	8b 45 08             	mov    0x8(%ebp),%eax
801078c6:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
801078ca:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801078ce:	0f 00 d8             	ltr    %ax
}
801078d1:	c9                   	leave  
801078d2:	c3                   	ret    

801078d3 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
801078d3:	55                   	push   %ebp
801078d4:	89 e5                	mov    %esp,%ebp
801078d6:	83 ec 04             	sub    $0x4,%esp
801078d9:	8b 45 08             	mov    0x8(%ebp),%eax
801078dc:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
801078e0:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801078e4:	8e e8                	mov    %eax,%gs
}
801078e6:	c9                   	leave  
801078e7:	c3                   	ret    

801078e8 <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
801078e8:	55                   	push   %ebp
801078e9:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
801078eb:	8b 45 08             	mov    0x8(%ebp),%eax
801078ee:	0f 22 d8             	mov    %eax,%cr3
}
801078f1:	5d                   	pop    %ebp
801078f2:	c3                   	ret    

801078f3 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
801078f3:	55                   	push   %ebp
801078f4:	89 e5                	mov    %esp,%ebp
801078f6:	8b 45 08             	mov    0x8(%ebp),%eax
801078f9:	05 00 00 00 80       	add    $0x80000000,%eax
801078fe:	5d                   	pop    %ebp
801078ff:	c3                   	ret    

80107900 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80107900:	55                   	push   %ebp
80107901:	89 e5                	mov    %esp,%ebp
80107903:	8b 45 08             	mov    0x8(%ebp),%eax
80107906:	05 00 00 00 80       	add    $0x80000000,%eax
8010790b:	5d                   	pop    %ebp
8010790c:	c3                   	ret    

8010790d <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
8010790d:	55                   	push   %ebp
8010790e:	89 e5                	mov    %esp,%ebp
80107910:	53                   	push   %ebx
80107911:	83 ec 24             	sub    $0x24,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107914:	e8 43 b5 ff ff       	call   80102e5c <cpunum>
80107919:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010791f:	05 40 f9 10 80       	add    $0x8010f940,%eax
80107924:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107927:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010792a:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80107930:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107933:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107939:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010793c:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80107940:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107943:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107947:	83 e2 f0             	and    $0xfffffff0,%edx
8010794a:	83 ca 0a             	or     $0xa,%edx
8010794d:	88 50 7d             	mov    %dl,0x7d(%eax)
80107950:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107953:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107957:	83 ca 10             	or     $0x10,%edx
8010795a:	88 50 7d             	mov    %dl,0x7d(%eax)
8010795d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107960:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107964:	83 e2 9f             	and    $0xffffff9f,%edx
80107967:	88 50 7d             	mov    %dl,0x7d(%eax)
8010796a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010796d:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107971:	83 ca 80             	or     $0xffffff80,%edx
80107974:	88 50 7d             	mov    %dl,0x7d(%eax)
80107977:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010797a:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010797e:	83 ca 0f             	or     $0xf,%edx
80107981:	88 50 7e             	mov    %dl,0x7e(%eax)
80107984:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107987:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010798b:	83 e2 ef             	and    $0xffffffef,%edx
8010798e:	88 50 7e             	mov    %dl,0x7e(%eax)
80107991:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107994:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107998:	83 e2 df             	and    $0xffffffdf,%edx
8010799b:	88 50 7e             	mov    %dl,0x7e(%eax)
8010799e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079a1:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801079a5:	83 ca 40             	or     $0x40,%edx
801079a8:	88 50 7e             	mov    %dl,0x7e(%eax)
801079ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ae:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801079b2:	83 ca 80             	or     $0xffffff80,%edx
801079b5:	88 50 7e             	mov    %dl,0x7e(%eax)
801079b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079bb:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801079bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079c2:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
801079c9:	ff ff 
801079cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ce:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
801079d5:	00 00 
801079d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079da:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
801079e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079e4:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801079eb:	83 e2 f0             	and    $0xfffffff0,%edx
801079ee:	83 ca 02             	or     $0x2,%edx
801079f1:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801079f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079fa:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107a01:	83 ca 10             	or     $0x10,%edx
80107a04:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107a0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a0d:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107a14:	83 e2 9f             	and    $0xffffff9f,%edx
80107a17:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107a1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a20:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107a27:	83 ca 80             	or     $0xffffff80,%edx
80107a2a:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107a30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a33:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107a3a:	83 ca 0f             	or     $0xf,%edx
80107a3d:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107a43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a46:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107a4d:	83 e2 ef             	and    $0xffffffef,%edx
80107a50:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107a56:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a59:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107a60:	83 e2 df             	and    $0xffffffdf,%edx
80107a63:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a6c:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107a73:	83 ca 40             	or     $0x40,%edx
80107a76:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107a7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a7f:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107a86:	83 ca 80             	or     $0xffffff80,%edx
80107a89:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a92:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107a99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a9c:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107aa3:	ff ff 
80107aa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aa8:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107aaf:	00 00 
80107ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ab4:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107abb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107abe:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107ac5:	83 e2 f0             	and    $0xfffffff0,%edx
80107ac8:	83 ca 0a             	or     $0xa,%edx
80107acb:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107ad1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ad4:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107adb:	83 ca 10             	or     $0x10,%edx
80107ade:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107ae4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ae7:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107aee:	83 ca 60             	or     $0x60,%edx
80107af1:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107afa:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107b01:	83 ca 80             	or     $0xffffff80,%edx
80107b04:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107b0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b0d:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107b14:	83 ca 0f             	or     $0xf,%edx
80107b17:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b20:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107b27:	83 e2 ef             	and    $0xffffffef,%edx
80107b2a:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107b30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b33:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107b3a:	83 e2 df             	and    $0xffffffdf,%edx
80107b3d:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107b43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b46:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107b4d:	83 ca 40             	or     $0x40,%edx
80107b50:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107b56:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b59:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107b60:	83 ca 80             	or     $0xffffff80,%edx
80107b63:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107b69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b6c:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107b73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b76:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107b7d:	ff ff 
80107b7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b82:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107b89:	00 00 
80107b8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b8e:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107b95:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b98:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107b9f:	83 e2 f0             	and    $0xfffffff0,%edx
80107ba2:	83 ca 02             	or     $0x2,%edx
80107ba5:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107bab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bae:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107bb5:	83 ca 10             	or     $0x10,%edx
80107bb8:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107bbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc1:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107bc8:	83 ca 60             	or     $0x60,%edx
80107bcb:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107bd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd4:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107bdb:	83 ca 80             	or     $0xffffff80,%edx
80107bde:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107be4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107be7:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107bee:	83 ca 0f             	or     $0xf,%edx
80107bf1:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107bf7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bfa:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c01:	83 e2 ef             	and    $0xffffffef,%edx
80107c04:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c0d:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c14:	83 e2 df             	and    $0xffffffdf,%edx
80107c17:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107c1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c20:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c27:	83 ca 40             	or     $0x40,%edx
80107c2a:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107c30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c33:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107c3a:	83 ca 80             	or     $0xffffff80,%edx
80107c3d:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107c43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c46:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107c4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c50:	05 b4 00 00 00       	add    $0xb4,%eax
80107c55:	89 c3                	mov    %eax,%ebx
80107c57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c5a:	05 b4 00 00 00       	add    $0xb4,%eax
80107c5f:	c1 e8 10             	shr    $0x10,%eax
80107c62:	89 c1                	mov    %eax,%ecx
80107c64:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c67:	05 b4 00 00 00       	add    $0xb4,%eax
80107c6c:	c1 e8 18             	shr    $0x18,%eax
80107c6f:	89 c2                	mov    %eax,%edx
80107c71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c74:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107c7b:	00 00 
80107c7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c80:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107c87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c8a:	88 88 8c 00 00 00    	mov    %cl,0x8c(%eax)
80107c90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c93:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107c9a:	83 e1 f0             	and    $0xfffffff0,%ecx
80107c9d:	83 c9 02             	or     $0x2,%ecx
80107ca0:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107ca6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ca9:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107cb0:	83 c9 10             	or     $0x10,%ecx
80107cb3:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107cb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cbc:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107cc3:	83 e1 9f             	and    $0xffffff9f,%ecx
80107cc6:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107ccc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ccf:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107cd6:	83 c9 80             	or     $0xffffff80,%ecx
80107cd9:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107cdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ce2:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107ce9:	83 e1 f0             	and    $0xfffffff0,%ecx
80107cec:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107cf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cf5:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107cfc:	83 e1 ef             	and    $0xffffffef,%ecx
80107cff:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107d05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d08:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107d0f:	83 e1 df             	and    $0xffffffdf,%ecx
80107d12:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107d18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d1b:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107d22:	83 c9 40             	or     $0x40,%ecx
80107d25:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107d2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d2e:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107d35:	83 c9 80             	or     $0xffffff80,%ecx
80107d38:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107d3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d41:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107d47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d4a:	83 c0 70             	add    $0x70,%eax
80107d4d:	c7 44 24 04 38 00 00 	movl   $0x38,0x4(%esp)
80107d54:	00 
80107d55:	89 04 24             	mov    %eax,(%esp)
80107d58:	e8 37 fb ff ff       	call   80107894 <lgdt>
  loadgs(SEG_KCPU << 3);
80107d5d:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
80107d64:	e8 6a fb ff ff       	call   801078d3 <loadgs>
  
  // Initialize cpu-local storage.
  cpu = c;
80107d69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d6c:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107d72:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107d79:	00 00 00 00 
}
80107d7d:	83 c4 24             	add    $0x24,%esp
80107d80:	5b                   	pop    %ebx
80107d81:	5d                   	pop    %ebp
80107d82:	c3                   	ret    

80107d83 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107d83:	55                   	push   %ebp
80107d84:	89 e5                	mov    %esp,%ebp
80107d86:	83 ec 28             	sub    $0x28,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107d89:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d8c:	c1 e8 16             	shr    $0x16,%eax
80107d8f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107d96:	8b 45 08             	mov    0x8(%ebp),%eax
80107d99:	01 d0                	add    %edx,%eax
80107d9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107d9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107da1:	8b 00                	mov    (%eax),%eax
80107da3:	83 e0 01             	and    $0x1,%eax
80107da6:	85 c0                	test   %eax,%eax
80107da8:	74 17                	je     80107dc1 <walkpgdir+0x3e>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107daa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107dad:	8b 00                	mov    (%eax),%eax
80107daf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107db4:	89 04 24             	mov    %eax,(%esp)
80107db7:	e8 44 fb ff ff       	call   80107900 <p2v>
80107dbc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107dbf:	eb 4b                	jmp    80107e0c <walkpgdir+0x89>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107dc1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107dc5:	74 0e                	je     80107dd5 <walkpgdir+0x52>
80107dc7:	e8 17 ad ff ff       	call   80102ae3 <kalloc>
80107dcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107dcf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107dd3:	75 07                	jne    80107ddc <walkpgdir+0x59>
      return 0;
80107dd5:	b8 00 00 00 00       	mov    $0x0,%eax
80107dda:	eb 47                	jmp    80107e23 <walkpgdir+0xa0>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107ddc:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107de3:	00 
80107de4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107deb:	00 
80107dec:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107def:	89 04 24             	mov    %eax,(%esp)
80107df2:	e8 df d4 ff ff       	call   801052d6 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107df7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dfa:	89 04 24             	mov    %eax,(%esp)
80107dfd:	e8 f1 fa ff ff       	call   801078f3 <v2p>
80107e02:	83 c8 07             	or     $0x7,%eax
80107e05:	89 c2                	mov    %eax,%edx
80107e07:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e0a:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107e0c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e0f:	c1 e8 0c             	shr    $0xc,%eax
80107e12:	25 ff 03 00 00       	and    $0x3ff,%eax
80107e17:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107e1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e21:	01 d0                	add    %edx,%eax
}
80107e23:	c9                   	leave  
80107e24:	c3                   	ret    

80107e25 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107e25:	55                   	push   %ebp
80107e26:	89 e5                	mov    %esp,%ebp
80107e28:	83 ec 28             	sub    $0x28,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107e2b:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e2e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e33:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107e36:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e39:	8b 45 10             	mov    0x10(%ebp),%eax
80107e3c:	01 d0                	add    %edx,%eax
80107e3e:	83 e8 01             	sub    $0x1,%eax
80107e41:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e46:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107e49:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
80107e50:	00 
80107e51:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e54:	89 44 24 04          	mov    %eax,0x4(%esp)
80107e58:	8b 45 08             	mov    0x8(%ebp),%eax
80107e5b:	89 04 24             	mov    %eax,(%esp)
80107e5e:	e8 20 ff ff ff       	call   80107d83 <walkpgdir>
80107e63:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107e66:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107e6a:	75 07                	jne    80107e73 <mappages+0x4e>
      return -1;
80107e6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e71:	eb 48                	jmp    80107ebb <mappages+0x96>
    if(*pte & PTE_P)
80107e73:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107e76:	8b 00                	mov    (%eax),%eax
80107e78:	83 e0 01             	and    $0x1,%eax
80107e7b:	85 c0                	test   %eax,%eax
80107e7d:	74 0c                	je     80107e8b <mappages+0x66>
      panic("remap");
80107e7f:	c7 04 24 e4 8c 10 80 	movl   $0x80108ce4,(%esp)
80107e86:	e8 af 86 ff ff       	call   8010053a <panic>
    *pte = pa | perm | PTE_P;
80107e8b:	8b 45 18             	mov    0x18(%ebp),%eax
80107e8e:	0b 45 14             	or     0x14(%ebp),%eax
80107e91:	83 c8 01             	or     $0x1,%eax
80107e94:	89 c2                	mov    %eax,%edx
80107e96:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107e99:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107e9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e9e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107ea1:	75 08                	jne    80107eab <mappages+0x86>
      break;
80107ea3:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107ea4:	b8 00 00 00 00       	mov    $0x0,%eax
80107ea9:	eb 10                	jmp    80107ebb <mappages+0x96>
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
80107eab:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107eb2:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107eb9:	eb 8e                	jmp    80107e49 <mappages+0x24>
  return 0;
}
80107ebb:	c9                   	leave  
80107ebc:	c3                   	ret    

80107ebd <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107ebd:	55                   	push   %ebp
80107ebe:	89 e5                	mov    %esp,%ebp
80107ec0:	53                   	push   %ebx
80107ec1:	83 ec 34             	sub    $0x34,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107ec4:	e8 1a ac ff ff       	call   80102ae3 <kalloc>
80107ec9:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107ecc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107ed0:	75 0a                	jne    80107edc <setupkvm+0x1f>
    return 0;
80107ed2:	b8 00 00 00 00       	mov    $0x0,%eax
80107ed7:	e9 98 00 00 00       	jmp    80107f74 <setupkvm+0xb7>
  memset(pgdir, 0, PGSIZE);
80107edc:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107ee3:	00 
80107ee4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107eeb:	00 
80107eec:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107eef:	89 04 24             	mov    %eax,(%esp)
80107ef2:	e8 df d3 ff ff       	call   801052d6 <memset>
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107ef7:	c7 04 24 00 00 00 0e 	movl   $0xe000000,(%esp)
80107efe:	e8 fd f9 ff ff       	call   80107900 <p2v>
80107f03:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107f08:	76 0c                	jbe    80107f16 <setupkvm+0x59>
    panic("PHYSTOP too high");
80107f0a:	c7 04 24 ea 8c 10 80 	movl   $0x80108cea,(%esp)
80107f11:	e8 24 86 ff ff       	call   8010053a <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107f16:	c7 45 f4 c0 b4 10 80 	movl   $0x8010b4c0,-0xc(%ebp)
80107f1d:	eb 49                	jmp    80107f68 <setupkvm+0xab>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107f1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f22:	8b 48 0c             	mov    0xc(%eax),%ecx
80107f25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f28:	8b 50 04             	mov    0x4(%eax),%edx
80107f2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f2e:	8b 58 08             	mov    0x8(%eax),%ebx
80107f31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f34:	8b 40 04             	mov    0x4(%eax),%eax
80107f37:	29 c3                	sub    %eax,%ebx
80107f39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f3c:	8b 00                	mov    (%eax),%eax
80107f3e:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80107f42:	89 54 24 0c          	mov    %edx,0xc(%esp)
80107f46:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80107f4a:	89 44 24 04          	mov    %eax,0x4(%esp)
80107f4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107f51:	89 04 24             	mov    %eax,(%esp)
80107f54:	e8 cc fe ff ff       	call   80107e25 <mappages>
80107f59:	85 c0                	test   %eax,%eax
80107f5b:	79 07                	jns    80107f64 <setupkvm+0xa7>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107f5d:	b8 00 00 00 00       	mov    $0x0,%eax
80107f62:	eb 10                	jmp    80107f74 <setupkvm+0xb7>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107f64:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107f68:	81 7d f4 00 b5 10 80 	cmpl   $0x8010b500,-0xc(%ebp)
80107f6f:	72 ae                	jb     80107f1f <setupkvm+0x62>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107f71:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107f74:	83 c4 34             	add    $0x34,%esp
80107f77:	5b                   	pop    %ebx
80107f78:	5d                   	pop    %ebp
80107f79:	c3                   	ret    

80107f7a <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107f7a:	55                   	push   %ebp
80107f7b:	89 e5                	mov    %esp,%ebp
80107f7d:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107f80:	e8 38 ff ff ff       	call   80107ebd <setupkvm>
80107f85:	a3 58 2a 11 80       	mov    %eax,0x80112a58
  switchkvm();
80107f8a:	e8 02 00 00 00       	call   80107f91 <switchkvm>
}
80107f8f:	c9                   	leave  
80107f90:	c3                   	ret    

80107f91 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107f91:	55                   	push   %ebp
80107f92:	89 e5                	mov    %esp,%ebp
80107f94:	83 ec 04             	sub    $0x4,%esp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107f97:	a1 58 2a 11 80       	mov    0x80112a58,%eax
80107f9c:	89 04 24             	mov    %eax,(%esp)
80107f9f:	e8 4f f9 ff ff       	call   801078f3 <v2p>
80107fa4:	89 04 24             	mov    %eax,(%esp)
80107fa7:	e8 3c f9 ff ff       	call   801078e8 <lcr3>
}
80107fac:	c9                   	leave  
80107fad:	c3                   	ret    

80107fae <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107fae:	55                   	push   %ebp
80107faf:	89 e5                	mov    %esp,%ebp
80107fb1:	53                   	push   %ebx
80107fb2:	83 ec 14             	sub    $0x14,%esp
  pushcli();
80107fb5:	e8 19 d2 ff ff       	call   801051d3 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107fba:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107fc0:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107fc7:	83 c2 08             	add    $0x8,%edx
80107fca:	89 d3                	mov    %edx,%ebx
80107fcc:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107fd3:	83 c2 08             	add    $0x8,%edx
80107fd6:	c1 ea 10             	shr    $0x10,%edx
80107fd9:	89 d1                	mov    %edx,%ecx
80107fdb:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107fe2:	83 c2 08             	add    $0x8,%edx
80107fe5:	c1 ea 18             	shr    $0x18,%edx
80107fe8:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107fef:	67 00 
80107ff1:	66 89 98 a2 00 00 00 	mov    %bx,0xa2(%eax)
80107ff8:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
80107ffe:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80108005:	83 e1 f0             	and    $0xfffffff0,%ecx
80108008:	83 c9 09             	or     $0x9,%ecx
8010800b:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80108011:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80108018:	83 c9 10             	or     $0x10,%ecx
8010801b:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80108021:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80108028:	83 e1 9f             	and    $0xffffff9f,%ecx
8010802b:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80108031:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80108038:	83 c9 80             	or     $0xffffff80,%ecx
8010803b:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80108041:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80108048:	83 e1 f0             	and    $0xfffffff0,%ecx
8010804b:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108051:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80108058:	83 e1 ef             	and    $0xffffffef,%ecx
8010805b:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108061:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80108068:	83 e1 df             	and    $0xffffffdf,%ecx
8010806b:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108071:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80108078:	83 c9 40             	or     $0x40,%ecx
8010807b:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108081:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80108088:	83 e1 7f             	and    $0x7f,%ecx
8010808b:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108091:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80108097:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010809d:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801080a4:	83 e2 ef             	and    $0xffffffef,%edx
801080a7:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
801080ad:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801080b3:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
801080b9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801080bf:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801080c6:	8b 52 08             	mov    0x8(%edx),%edx
801080c9:	81 c2 00 10 00 00    	add    $0x1000,%edx
801080cf:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
801080d2:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
801080d9:	e8 df f7 ff ff       	call   801078bd <ltr>
  if(p->pgdir == 0)
801080de:	8b 45 08             	mov    0x8(%ebp),%eax
801080e1:	8b 40 04             	mov    0x4(%eax),%eax
801080e4:	85 c0                	test   %eax,%eax
801080e6:	75 0c                	jne    801080f4 <switchuvm+0x146>
    panic("switchuvm: no pgdir");
801080e8:	c7 04 24 fb 8c 10 80 	movl   $0x80108cfb,(%esp)
801080ef:	e8 46 84 ff ff       	call   8010053a <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
801080f4:	8b 45 08             	mov    0x8(%ebp),%eax
801080f7:	8b 40 04             	mov    0x4(%eax),%eax
801080fa:	89 04 24             	mov    %eax,(%esp)
801080fd:	e8 f1 f7 ff ff       	call   801078f3 <v2p>
80108102:	89 04 24             	mov    %eax,(%esp)
80108105:	e8 de f7 ff ff       	call   801078e8 <lcr3>
  popcli();
8010810a:	e8 08 d1 ff ff       	call   80105217 <popcli>
}
8010810f:	83 c4 14             	add    $0x14,%esp
80108112:	5b                   	pop    %ebx
80108113:	5d                   	pop    %ebp
80108114:	c3                   	ret    

80108115 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80108115:	55                   	push   %ebp
80108116:	89 e5                	mov    %esp,%ebp
80108118:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  
  if(sz >= PGSIZE)
8010811b:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80108122:	76 0c                	jbe    80108130 <inituvm+0x1b>
    panic("inituvm: more than a page");
80108124:	c7 04 24 0f 8d 10 80 	movl   $0x80108d0f,(%esp)
8010812b:	e8 0a 84 ff ff       	call   8010053a <panic>
  mem = kalloc();
80108130:	e8 ae a9 ff ff       	call   80102ae3 <kalloc>
80108135:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80108138:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010813f:	00 
80108140:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80108147:	00 
80108148:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010814b:	89 04 24             	mov    %eax,(%esp)
8010814e:	e8 83 d1 ff ff       	call   801052d6 <memset>
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80108153:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108156:	89 04 24             	mov    %eax,(%esp)
80108159:	e8 95 f7 ff ff       	call   801078f3 <v2p>
8010815e:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
80108165:	00 
80108166:	89 44 24 0c          	mov    %eax,0xc(%esp)
8010816a:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108171:	00 
80108172:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80108179:	00 
8010817a:	8b 45 08             	mov    0x8(%ebp),%eax
8010817d:	89 04 24             	mov    %eax,(%esp)
80108180:	e8 a0 fc ff ff       	call   80107e25 <mappages>
  memmove(mem, init, sz);
80108185:	8b 45 10             	mov    0x10(%ebp),%eax
80108188:	89 44 24 08          	mov    %eax,0x8(%esp)
8010818c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010818f:	89 44 24 04          	mov    %eax,0x4(%esp)
80108193:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108196:	89 04 24             	mov    %eax,(%esp)
80108199:	e8 07 d2 ff ff       	call   801053a5 <memmove>
}
8010819e:	c9                   	leave  
8010819f:	c3                   	ret    

801081a0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801081a0:	55                   	push   %ebp
801081a1:	89 e5                	mov    %esp,%ebp
801081a3:	53                   	push   %ebx
801081a4:	83 ec 24             	sub    $0x24,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801081a7:	8b 45 0c             	mov    0xc(%ebp),%eax
801081aa:	25 ff 0f 00 00       	and    $0xfff,%eax
801081af:	85 c0                	test   %eax,%eax
801081b1:	74 0c                	je     801081bf <loaduvm+0x1f>
    panic("loaduvm: addr must be page aligned");
801081b3:	c7 04 24 2c 8d 10 80 	movl   $0x80108d2c,(%esp)
801081ba:	e8 7b 83 ff ff       	call   8010053a <panic>
  for(i = 0; i < sz; i += PGSIZE){
801081bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801081c6:	e9 a9 00 00 00       	jmp    80108274 <loaduvm+0xd4>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801081cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081ce:	8b 55 0c             	mov    0xc(%ebp),%edx
801081d1:	01 d0                	add    %edx,%eax
801081d3:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801081da:	00 
801081db:	89 44 24 04          	mov    %eax,0x4(%esp)
801081df:	8b 45 08             	mov    0x8(%ebp),%eax
801081e2:	89 04 24             	mov    %eax,(%esp)
801081e5:	e8 99 fb ff ff       	call   80107d83 <walkpgdir>
801081ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
801081ed:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801081f1:	75 0c                	jne    801081ff <loaduvm+0x5f>
      panic("loaduvm: address should exist");
801081f3:	c7 04 24 4f 8d 10 80 	movl   $0x80108d4f,(%esp)
801081fa:	e8 3b 83 ff ff       	call   8010053a <panic>
    pa = PTE_ADDR(*pte);
801081ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108202:	8b 00                	mov    (%eax),%eax
80108204:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108209:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
8010820c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010820f:	8b 55 18             	mov    0x18(%ebp),%edx
80108212:	29 c2                	sub    %eax,%edx
80108214:	89 d0                	mov    %edx,%eax
80108216:	3d ff 0f 00 00       	cmp    $0xfff,%eax
8010821b:	77 0f                	ja     8010822c <loaduvm+0x8c>
      n = sz - i;
8010821d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108220:	8b 55 18             	mov    0x18(%ebp),%edx
80108223:	29 c2                	sub    %eax,%edx
80108225:	89 d0                	mov    %edx,%eax
80108227:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010822a:	eb 07                	jmp    80108233 <loaduvm+0x93>
    else
      n = PGSIZE;
8010822c:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80108233:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108236:	8b 55 14             	mov    0x14(%ebp),%edx
80108239:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010823c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010823f:	89 04 24             	mov    %eax,(%esp)
80108242:	e8 b9 f6 ff ff       	call   80107900 <p2v>
80108247:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010824a:	89 54 24 0c          	mov    %edx,0xc(%esp)
8010824e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80108252:	89 44 24 04          	mov    %eax,0x4(%esp)
80108256:	8b 45 10             	mov    0x10(%ebp),%eax
80108259:	89 04 24             	mov    %eax,(%esp)
8010825c:	e8 02 9b ff ff       	call   80101d63 <readi>
80108261:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80108264:	74 07                	je     8010826d <loaduvm+0xcd>
      return -1;
80108266:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010826b:	eb 18                	jmp    80108285 <loaduvm+0xe5>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
8010826d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108274:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108277:	3b 45 18             	cmp    0x18(%ebp),%eax
8010827a:	0f 82 4b ff ff ff    	jb     801081cb <loaduvm+0x2b>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80108280:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108285:	83 c4 24             	add    $0x24,%esp
80108288:	5b                   	pop    %ebx
80108289:	5d                   	pop    %ebp
8010828a:	c3                   	ret    

8010828b <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010828b:	55                   	push   %ebp
8010828c:	89 e5                	mov    %esp,%ebp
8010828e:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80108291:	8b 45 10             	mov    0x10(%ebp),%eax
80108294:	85 c0                	test   %eax,%eax
80108296:	79 0a                	jns    801082a2 <allocuvm+0x17>
    return 0;
80108298:	b8 00 00 00 00       	mov    $0x0,%eax
8010829d:	e9 c1 00 00 00       	jmp    80108363 <allocuvm+0xd8>
  if(newsz < oldsz)
801082a2:	8b 45 10             	mov    0x10(%ebp),%eax
801082a5:	3b 45 0c             	cmp    0xc(%ebp),%eax
801082a8:	73 08                	jae    801082b2 <allocuvm+0x27>
    return oldsz;
801082aa:	8b 45 0c             	mov    0xc(%ebp),%eax
801082ad:	e9 b1 00 00 00       	jmp    80108363 <allocuvm+0xd8>

  a = PGROUNDUP(oldsz);
801082b2:	8b 45 0c             	mov    0xc(%ebp),%eax
801082b5:	05 ff 0f 00 00       	add    $0xfff,%eax
801082ba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
801082c2:	e9 8d 00 00 00       	jmp    80108354 <allocuvm+0xc9>
    mem = kalloc();
801082c7:	e8 17 a8 ff ff       	call   80102ae3 <kalloc>
801082cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
801082cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801082d3:	75 2c                	jne    80108301 <allocuvm+0x76>
      cprintf("allocuvm out of memory\n");
801082d5:	c7 04 24 6d 8d 10 80 	movl   $0x80108d6d,(%esp)
801082dc:	e8 bf 80 ff ff       	call   801003a0 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
801082e1:	8b 45 0c             	mov    0xc(%ebp),%eax
801082e4:	89 44 24 08          	mov    %eax,0x8(%esp)
801082e8:	8b 45 10             	mov    0x10(%ebp),%eax
801082eb:	89 44 24 04          	mov    %eax,0x4(%esp)
801082ef:	8b 45 08             	mov    0x8(%ebp),%eax
801082f2:	89 04 24             	mov    %eax,(%esp)
801082f5:	e8 6b 00 00 00       	call   80108365 <deallocuvm>
      return 0;
801082fa:	b8 00 00 00 00       	mov    $0x0,%eax
801082ff:	eb 62                	jmp    80108363 <allocuvm+0xd8>
    }
    memset(mem, 0, PGSIZE);
80108301:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108308:	00 
80108309:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80108310:	00 
80108311:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108314:	89 04 24             	mov    %eax,(%esp)
80108317:	e8 ba cf ff ff       	call   801052d6 <memset>
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
8010831c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010831f:	89 04 24             	mov    %eax,(%esp)
80108322:	e8 cc f5 ff ff       	call   801078f3 <v2p>
80108327:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010832a:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
80108331:	00 
80108332:	89 44 24 0c          	mov    %eax,0xc(%esp)
80108336:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010833d:	00 
8010833e:	89 54 24 04          	mov    %edx,0x4(%esp)
80108342:	8b 45 08             	mov    0x8(%ebp),%eax
80108345:	89 04 24             	mov    %eax,(%esp)
80108348:	e8 d8 fa ff ff       	call   80107e25 <mappages>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
8010834d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108354:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108357:	3b 45 10             	cmp    0x10(%ebp),%eax
8010835a:	0f 82 67 ff ff ff    	jb     801082c7 <allocuvm+0x3c>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80108360:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108363:	c9                   	leave  
80108364:	c3                   	ret    

80108365 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108365:	55                   	push   %ebp
80108366:	89 e5                	mov    %esp,%ebp
80108368:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010836b:	8b 45 10             	mov    0x10(%ebp),%eax
8010836e:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108371:	72 08                	jb     8010837b <deallocuvm+0x16>
    return oldsz;
80108373:	8b 45 0c             	mov    0xc(%ebp),%eax
80108376:	e9 a4 00 00 00       	jmp    8010841f <deallocuvm+0xba>

  a = PGROUNDUP(newsz);
8010837b:	8b 45 10             	mov    0x10(%ebp),%eax
8010837e:	05 ff 0f 00 00       	add    $0xfff,%eax
80108383:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108388:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010838b:	e9 80 00 00 00       	jmp    80108410 <deallocuvm+0xab>
    pte = walkpgdir(pgdir, (char*)a, 0);
80108390:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108393:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010839a:	00 
8010839b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010839f:	8b 45 08             	mov    0x8(%ebp),%eax
801083a2:	89 04 24             	mov    %eax,(%esp)
801083a5:	e8 d9 f9 ff ff       	call   80107d83 <walkpgdir>
801083aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
801083ad:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801083b1:	75 09                	jne    801083bc <deallocuvm+0x57>
      a += (NPTENTRIES - 1) * PGSIZE;
801083b3:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
801083ba:	eb 4d                	jmp    80108409 <deallocuvm+0xa4>
    else if((*pte & PTE_P) != 0){
801083bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801083bf:	8b 00                	mov    (%eax),%eax
801083c1:	83 e0 01             	and    $0x1,%eax
801083c4:	85 c0                	test   %eax,%eax
801083c6:	74 41                	je     80108409 <deallocuvm+0xa4>
      pa = PTE_ADDR(*pte);
801083c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801083cb:	8b 00                	mov    (%eax),%eax
801083cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801083d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
801083d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801083d9:	75 0c                	jne    801083e7 <deallocuvm+0x82>
        panic("kfree");
801083db:	c7 04 24 85 8d 10 80 	movl   $0x80108d85,(%esp)
801083e2:	e8 53 81 ff ff       	call   8010053a <panic>
      char *v = p2v(pa);
801083e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801083ea:	89 04 24             	mov    %eax,(%esp)
801083ed:	e8 0e f5 ff ff       	call   80107900 <p2v>
801083f2:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
801083f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801083f8:	89 04 24             	mov    %eax,(%esp)
801083fb:	e8 4a a6 ff ff       	call   80102a4a <kfree>
      *pte = 0;
80108400:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108403:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80108409:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108410:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108413:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108416:	0f 82 74 ff ff ff    	jb     80108390 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
8010841c:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010841f:	c9                   	leave  
80108420:	c3                   	ret    

80108421 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108421:	55                   	push   %ebp
80108422:	89 e5                	mov    %esp,%ebp
80108424:	83 ec 28             	sub    $0x28,%esp
  uint i;

  if(pgdir == 0)
80108427:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010842b:	75 0c                	jne    80108439 <freevm+0x18>
    panic("freevm: no pgdir");
8010842d:	c7 04 24 8b 8d 10 80 	movl   $0x80108d8b,(%esp)
80108434:	e8 01 81 ff ff       	call   8010053a <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80108439:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108440:	00 
80108441:	c7 44 24 04 00 00 00 	movl   $0x80000000,0x4(%esp)
80108448:	80 
80108449:	8b 45 08             	mov    0x8(%ebp),%eax
8010844c:	89 04 24             	mov    %eax,(%esp)
8010844f:	e8 11 ff ff ff       	call   80108365 <deallocuvm>
  for(i = 0; i < NPDENTRIES; i++){
80108454:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010845b:	eb 48                	jmp    801084a5 <freevm+0x84>
    if(pgdir[i] & PTE_P){
8010845d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108460:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108467:	8b 45 08             	mov    0x8(%ebp),%eax
8010846a:	01 d0                	add    %edx,%eax
8010846c:	8b 00                	mov    (%eax),%eax
8010846e:	83 e0 01             	and    $0x1,%eax
80108471:	85 c0                	test   %eax,%eax
80108473:	74 2c                	je     801084a1 <freevm+0x80>
      char * v = p2v(PTE_ADDR(pgdir[i]));
80108475:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108478:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010847f:	8b 45 08             	mov    0x8(%ebp),%eax
80108482:	01 d0                	add    %edx,%eax
80108484:	8b 00                	mov    (%eax),%eax
80108486:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010848b:	89 04 24             	mov    %eax,(%esp)
8010848e:	e8 6d f4 ff ff       	call   80107900 <p2v>
80108493:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80108496:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108499:	89 04 24             	mov    %eax,(%esp)
8010849c:	e8 a9 a5 ff ff       	call   80102a4a <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801084a1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801084a5:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
801084ac:	76 af                	jbe    8010845d <freevm+0x3c>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801084ae:	8b 45 08             	mov    0x8(%ebp),%eax
801084b1:	89 04 24             	mov    %eax,(%esp)
801084b4:	e8 91 a5 ff ff       	call   80102a4a <kfree>
}
801084b9:	c9                   	leave  
801084ba:	c3                   	ret    

801084bb <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801084bb:	55                   	push   %ebp
801084bc:	89 e5                	mov    %esp,%ebp
801084be:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801084c1:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801084c8:	00 
801084c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801084cc:	89 44 24 04          	mov    %eax,0x4(%esp)
801084d0:	8b 45 08             	mov    0x8(%ebp),%eax
801084d3:	89 04 24             	mov    %eax,(%esp)
801084d6:	e8 a8 f8 ff ff       	call   80107d83 <walkpgdir>
801084db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
801084de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801084e2:	75 0c                	jne    801084f0 <clearpteu+0x35>
    panic("clearpteu");
801084e4:	c7 04 24 9c 8d 10 80 	movl   $0x80108d9c,(%esp)
801084eb:	e8 4a 80 ff ff       	call   8010053a <panic>
  *pte &= ~PTE_U;
801084f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084f3:	8b 00                	mov    (%eax),%eax
801084f5:	83 e0 fb             	and    $0xfffffffb,%eax
801084f8:	89 c2                	mov    %eax,%edx
801084fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084fd:	89 10                	mov    %edx,(%eax)
}
801084ff:	c9                   	leave  
80108500:	c3                   	ret    

80108501 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108501:	55                   	push   %ebp
80108502:	89 e5                	mov    %esp,%ebp
80108504:	53                   	push   %ebx
80108505:	83 ec 44             	sub    $0x44,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108508:	e8 b0 f9 ff ff       	call   80107ebd <setupkvm>
8010850d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108510:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108514:	75 0a                	jne    80108520 <copyuvm+0x1f>
    return 0;
80108516:	b8 00 00 00 00       	mov    $0x0,%eax
8010851b:	e9 fd 00 00 00       	jmp    8010861d <copyuvm+0x11c>
  for(i = PGSIZE; i < sz; i += PGSIZE){
80108520:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
80108527:	e9 d0 00 00 00       	jmp    801085fc <copyuvm+0xfb>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
8010852c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010852f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108536:	00 
80108537:	89 44 24 04          	mov    %eax,0x4(%esp)
8010853b:	8b 45 08             	mov    0x8(%ebp),%eax
8010853e:	89 04 24             	mov    %eax,(%esp)
80108541:	e8 3d f8 ff ff       	call   80107d83 <walkpgdir>
80108546:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108549:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010854d:	75 0c                	jne    8010855b <copyuvm+0x5a>
      panic("copyuvm: pte should exist");
8010854f:	c7 04 24 a6 8d 10 80 	movl   $0x80108da6,(%esp)
80108556:	e8 df 7f ff ff       	call   8010053a <panic>
    if(!(*pte & PTE_P))
8010855b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010855e:	8b 00                	mov    (%eax),%eax
80108560:	83 e0 01             	and    $0x1,%eax
80108563:	85 c0                	test   %eax,%eax
80108565:	75 0c                	jne    80108573 <copyuvm+0x72>
      panic("copyuvm: page not present");
80108567:	c7 04 24 c0 8d 10 80 	movl   $0x80108dc0,(%esp)
8010856e:	e8 c7 7f ff ff       	call   8010053a <panic>
    pa = PTE_ADDR(*pte);
80108573:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108576:	8b 00                	mov    (%eax),%eax
80108578:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010857d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
80108580:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108583:	8b 00                	mov    (%eax),%eax
80108585:	25 ff 0f 00 00       	and    $0xfff,%eax
8010858a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
8010858d:	e8 51 a5 ff ff       	call   80102ae3 <kalloc>
80108592:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108595:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80108599:	75 02                	jne    8010859d <copyuvm+0x9c>
      goto bad;
8010859b:	eb 70                	jmp    8010860d <copyuvm+0x10c>
    memmove(mem, (char*)p2v(pa), PGSIZE);
8010859d:	8b 45 e8             	mov    -0x18(%ebp),%eax
801085a0:	89 04 24             	mov    %eax,(%esp)
801085a3:	e8 58 f3 ff ff       	call   80107900 <p2v>
801085a8:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801085af:	00 
801085b0:	89 44 24 04          	mov    %eax,0x4(%esp)
801085b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801085b7:	89 04 24             	mov    %eax,(%esp)
801085ba:	e8 e6 cd ff ff       	call   801053a5 <memmove>
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
801085bf:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801085c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801085c5:	89 04 24             	mov    %eax,(%esp)
801085c8:	e8 26 f3 ff ff       	call   801078f3 <v2p>
801085cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
801085d0:	89 5c 24 10          	mov    %ebx,0x10(%esp)
801085d4:	89 44 24 0c          	mov    %eax,0xc(%esp)
801085d8:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801085df:	00 
801085e0:	89 54 24 04          	mov    %edx,0x4(%esp)
801085e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801085e7:	89 04 24             	mov    %eax,(%esp)
801085ea:	e8 36 f8 ff ff       	call   80107e25 <mappages>
801085ef:	85 c0                	test   %eax,%eax
801085f1:	79 02                	jns    801085f5 <copyuvm+0xf4>
      goto bad;
801085f3:	eb 18                	jmp    8010860d <copyuvm+0x10c>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = PGSIZE; i < sz; i += PGSIZE){
801085f5:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801085fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085ff:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108602:	0f 82 24 ff ff ff    	jb     8010852c <copyuvm+0x2b>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
  }
  return d;
80108608:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010860b:	eb 10                	jmp    8010861d <copyuvm+0x11c>

bad:
  freevm(d);
8010860d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108610:	89 04 24             	mov    %eax,(%esp)
80108613:	e8 09 fe ff ff       	call   80108421 <freevm>
  return 0;
80108618:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010861d:	83 c4 44             	add    $0x44,%esp
80108620:	5b                   	pop    %ebx
80108621:	5d                   	pop    %ebp
80108622:	c3                   	ret    

80108623 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108623:	55                   	push   %ebp
80108624:	89 e5                	mov    %esp,%ebp
80108626:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108629:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108630:	00 
80108631:	8b 45 0c             	mov    0xc(%ebp),%eax
80108634:	89 44 24 04          	mov    %eax,0x4(%esp)
80108638:	8b 45 08             	mov    0x8(%ebp),%eax
8010863b:	89 04 24             	mov    %eax,(%esp)
8010863e:	e8 40 f7 ff ff       	call   80107d83 <walkpgdir>
80108643:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
80108646:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108649:	8b 00                	mov    (%eax),%eax
8010864b:	83 e0 01             	and    $0x1,%eax
8010864e:	85 c0                	test   %eax,%eax
80108650:	75 07                	jne    80108659 <uva2ka+0x36>
    return 0;
80108652:	b8 00 00 00 00       	mov    $0x0,%eax
80108657:	eb 25                	jmp    8010867e <uva2ka+0x5b>
  if((*pte & PTE_U) == 0)
80108659:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010865c:	8b 00                	mov    (%eax),%eax
8010865e:	83 e0 04             	and    $0x4,%eax
80108661:	85 c0                	test   %eax,%eax
80108663:	75 07                	jne    8010866c <uva2ka+0x49>
    return 0;
80108665:	b8 00 00 00 00       	mov    $0x0,%eax
8010866a:	eb 12                	jmp    8010867e <uva2ka+0x5b>
  return (char*)p2v(PTE_ADDR(*pte));
8010866c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010866f:	8b 00                	mov    (%eax),%eax
80108671:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108676:	89 04 24             	mov    %eax,(%esp)
80108679:	e8 82 f2 ff ff       	call   80107900 <p2v>
}
8010867e:	c9                   	leave  
8010867f:	c3                   	ret    

80108680 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108680:	55                   	push   %ebp
80108681:	89 e5                	mov    %esp,%ebp
80108683:	83 ec 28             	sub    $0x28,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80108686:	8b 45 10             	mov    0x10(%ebp),%eax
80108689:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
8010868c:	e9 87 00 00 00       	jmp    80108718 <copyout+0x98>
    va0 = (uint)PGROUNDDOWN(va);
80108691:	8b 45 0c             	mov    0xc(%ebp),%eax
80108694:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108699:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
8010869c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010869f:	89 44 24 04          	mov    %eax,0x4(%esp)
801086a3:	8b 45 08             	mov    0x8(%ebp),%eax
801086a6:	89 04 24             	mov    %eax,(%esp)
801086a9:	e8 75 ff ff ff       	call   80108623 <uva2ka>
801086ae:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
801086b1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801086b5:	75 07                	jne    801086be <copyout+0x3e>
      return -1;
801086b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801086bc:	eb 69                	jmp    80108727 <copyout+0xa7>
    n = PGSIZE - (va - va0);
801086be:	8b 45 0c             	mov    0xc(%ebp),%eax
801086c1:	8b 55 ec             	mov    -0x14(%ebp),%edx
801086c4:	29 c2                	sub    %eax,%edx
801086c6:	89 d0                	mov    %edx,%eax
801086c8:	05 00 10 00 00       	add    $0x1000,%eax
801086cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
801086d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801086d3:	3b 45 14             	cmp    0x14(%ebp),%eax
801086d6:	76 06                	jbe    801086de <copyout+0x5e>
      n = len;
801086d8:	8b 45 14             	mov    0x14(%ebp),%eax
801086db:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
801086de:	8b 45 ec             	mov    -0x14(%ebp),%eax
801086e1:	8b 55 0c             	mov    0xc(%ebp),%edx
801086e4:	29 c2                	sub    %eax,%edx
801086e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
801086e9:	01 c2                	add    %eax,%edx
801086eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801086ee:	89 44 24 08          	mov    %eax,0x8(%esp)
801086f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086f5:	89 44 24 04          	mov    %eax,0x4(%esp)
801086f9:	89 14 24             	mov    %edx,(%esp)
801086fc:	e8 a4 cc ff ff       	call   801053a5 <memmove>
    len -= n;
80108701:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108704:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80108707:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010870a:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
8010870d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108710:	05 00 10 00 00       	add    $0x1000,%eax
80108715:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108718:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010871c:	0f 85 6f ff ff ff    	jne    80108691 <copyout+0x11>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80108722:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108727:	c9                   	leave  
80108728:	c3                   	ret    
