
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 70 c6 10 80       	mov    $0x8010c670,%esp
8010002d:	b8 c8 33 10 80       	mov    $0x801033c8,%eax
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
8010003a:	c7 44 24 04 b0 86 10 	movl   $0x801086b0,0x4(%esp)
80100041:	80 
80100042:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
80100049:	e8 90 4f 00 00       	call   80104fde <initlock>

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
801000bd:	e8 3d 4f 00 00       	call   80104fff <acquire>

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
80100104:	e8 58 4f 00 00       	call   80105061 <release>
        return b;
80100109:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010010c:	e9 93 00 00 00       	jmp    801001a4 <bget+0xf4>
      }
      sleep(b, &bcache.lock);
80100111:	c7 44 24 04 80 c6 10 	movl   $0x8010c680,0x4(%esp)
80100118:	80 
80100119:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010011c:	89 04 24             	mov    %eax,(%esp)
8010011f:	e8 68 4b 00 00       	call   80104c8c <sleep>
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
8010017c:	e8 e0 4e 00 00       	call   80105061 <release>
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
80100198:	c7 04 24 b7 86 10 80 	movl   $0x801086b7,(%esp)
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
801001ef:	c7 04 24 c8 86 10 80 	movl   $0x801086c8,(%esp)
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
80100229:	c7 04 24 cf 86 10 80 	movl   $0x801086cf,(%esp)
80100230:	e8 05 03 00 00       	call   8010053a <panic>

  acquire(&bcache.lock);
80100235:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
8010023c:	e8 be 4d 00 00       	call   80104fff <acquire>

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
8010029d:	e8 2e 4b 00 00       	call   80104dd0 <wakeup>

  release(&bcache.lock);
801002a2:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
801002a9:	e8 b3 4d 00 00       	call   80105061 <release>
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
801003bb:	e8 3f 4c 00 00       	call   80104fff <acquire>

  if (fmt == 0)
801003c0:	8b 45 08             	mov    0x8(%ebp),%eax
801003c3:	85 c0                	test   %eax,%eax
801003c5:	75 0c                	jne    801003d3 <cprintf+0x33>
    panic("null fmt");
801003c7:	c7 04 24 d6 86 10 80 	movl   $0x801086d6,(%esp)
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
801004b0:	c7 45 ec df 86 10 80 	movl   $0x801086df,-0x14(%ebp)
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
80100533:	e8 29 4b 00 00       	call   80105061 <release>
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
8010055f:	c7 04 24 e6 86 10 80 	movl   $0x801086e6,(%esp)
80100566:	e8 35 fe ff ff       	call   801003a0 <cprintf>
  cprintf(s);
8010056b:	8b 45 08             	mov    0x8(%ebp),%eax
8010056e:	89 04 24             	mov    %eax,(%esp)
80100571:	e8 2a fe ff ff       	call   801003a0 <cprintf>
  cprintf("\n");
80100576:	c7 04 24 f5 86 10 80 	movl   $0x801086f5,(%esp)
8010057d:	e8 1e fe ff ff       	call   801003a0 <cprintf>
  getcallerpcs(&s, pcs);
80100582:	8d 45 cc             	lea    -0x34(%ebp),%eax
80100585:	89 44 24 04          	mov    %eax,0x4(%esp)
80100589:	8d 45 08             	lea    0x8(%ebp),%eax
8010058c:	89 04 24             	mov    %eax,(%esp)
8010058f:	e8 1c 4b 00 00       	call   801050b0 <getcallerpcs>
  for(i=0; i<10; i++)
80100594:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010059b:	eb 1b                	jmp    801005b8 <panic+0x7e>
    cprintf(" %p", pcs[i]);
8010059d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005a0:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801005a8:	c7 04 24 f7 86 10 80 	movl   $0x801086f7,(%esp)
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
801006b2:	e8 6e 4c 00 00       	call   80105325 <memmove>
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
801006e1:	e8 70 4b 00 00       	call   80105256 <memset>
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
80100776:	e8 70 65 00 00       	call   80106ceb <uartputc>
8010077b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100782:	e8 64 65 00 00       	call   80106ceb <uartputc>
80100787:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010078e:	e8 58 65 00 00       	call   80106ceb <uartputc>
80100793:	eb 0b                	jmp    801007a0 <consputc+0x50>
  } else
    uartputc(c);
80100795:	8b 45 08             	mov    0x8(%ebp),%eax
80100798:	89 04 24             	mov    %eax,(%esp)
8010079b:	e8 4b 65 00 00       	call   80106ceb <uartputc>
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
801007ba:	e8 40 48 00 00       	call   80104fff <acquire>
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
801007ea:	e8 87 46 00 00       	call   80104e76 <procdump>
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
801008f3:	e8 d8 44 00 00       	call   80104dd0 <wakeup>
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
80100914:	e8 48 47 00 00       	call   80105061 <release>
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
80100939:	e8 c1 46 00 00       	call   80104fff <acquire>
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
80100959:	e8 03 47 00 00       	call   80105061 <release>
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
80100982:	e8 05 43 00 00       	call   80104c8c <sleep>

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
801009fe:	e8 5e 46 00 00       	call   80105061 <release>
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
80100a32:	e8 c8 45 00 00       	call   80104fff <acquire>
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
80100a6c:	e8 f0 45 00 00       	call   80105061 <release>
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
80100a87:	c7 44 24 04 fb 86 10 	movl   $0x801086fb,0x4(%esp)
80100a8e:	80 
80100a8f:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100a96:	e8 43 45 00 00       	call   80104fde <initlock>
  initlock(&input.lock, "input");
80100a9b:	c7 44 24 04 03 87 10 	movl   $0x80108703,0x4(%esp)
80100aa2:	80 
80100aa3:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
80100aaa:	e8 2f 45 00 00       	call   80104fde <initlock>

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
	...

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
80100b6a:	e8 d2 72 00 00       	call   80107e41 <setupkvm>
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
80100c0b:	e8 ff 75 00 00       	call   8010820f <allocuvm>
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
80100c49:	e8 d6 74 00 00       	call   80108124 <loaduvm>
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
80100cb2:	e8 58 75 00 00       	call   8010820f <allocuvm>
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
80100ce3:	e8 57 77 00 00       	call   8010843f <clearpteu>

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
80100d19:	e8 a2 47 00 00       	call   801054c0 <strlen>
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
80100d42:	e8 79 47 00 00       	call   801054c0 <strlen>
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
80100d72:	e8 8d 78 00 00       	call   80108604 <copyout>
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
80100e19:	e8 e6 77 00 00       	call   80108604 <copyout>
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
80100e71:	e8 00 46 00 00       	call   80105476 <safestrcpy>

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
80100ec3:	e8 6a 70 00 00       	call   80107f32 <switchuvm>
  freevm(oldpgdir);
80100ec8:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100ecb:	89 04 24             	mov    %eax,(%esp)
80100ece:	e8 d2 74 00 00       	call   801083a5 <freevm>
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
80100ee6:	e8 ba 74 00 00       	call   801083a5 <freevm>
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
	...

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
80100f0a:	c7 44 24 04 09 87 10 	movl   $0x80108709,0x4(%esp)
80100f11:	80 
80100f12:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100f19:	e8 c0 40 00 00       	call   80104fde <initlock>
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
80100f2d:	e8 cd 40 00 00       	call   80104fff <acquire>
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
80100f56:	e8 06 41 00 00       	call   80105061 <release>
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
80100f74:	e8 e8 40 00 00       	call   80105061 <release>
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
80100f8d:	e8 6d 40 00 00       	call   80104fff <acquire>
  if(f->ref < 1)
80100f92:	8b 45 08             	mov    0x8(%ebp),%eax
80100f95:	8b 40 04             	mov    0x4(%eax),%eax
80100f98:	85 c0                	test   %eax,%eax
80100f9a:	7f 0c                	jg     80100fa8 <filedup+0x28>
    panic("filedup");
80100f9c:	c7 04 24 10 87 10 80 	movl   $0x80108710,(%esp)
80100fa3:	e8 92 f5 ff ff       	call   8010053a <panic>
  f->ref++;
80100fa8:	8b 45 08             	mov    0x8(%ebp),%eax
80100fab:	8b 40 04             	mov    0x4(%eax),%eax
80100fae:	8d 50 01             	lea    0x1(%eax),%edx
80100fb1:	8b 45 08             	mov    0x8(%ebp),%eax
80100fb4:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80100fb7:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100fbe:	e8 9e 40 00 00       	call   80105061 <release>
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
80100fd5:	e8 25 40 00 00       	call   80104fff <acquire>
  if(f->ref < 1)
80100fda:	8b 45 08             	mov    0x8(%ebp),%eax
80100fdd:	8b 40 04             	mov    0x4(%eax),%eax
80100fe0:	85 c0                	test   %eax,%eax
80100fe2:	7f 0c                	jg     80100ff0 <fileclose+0x28>
    panic("fileclose");
80100fe4:	c7 04 24 18 87 10 80 	movl   $0x80108718,(%esp)
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
80101010:	e8 4c 40 00 00       	call   80105061 <release>
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
8010105a:	e8 02 40 00 00       	call   80105061 <release>
  
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
8010119b:	c7 04 24 22 87 10 80 	movl   $0x80108722,(%esp)
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
801012a7:	c7 04 24 2b 87 10 80 	movl   $0x8010872b,(%esp)
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
801012d9:	c7 04 24 3b 87 10 80 	movl   $0x8010873b,(%esp)
801012e0:	e8 55 f2 ff ff       	call   8010053a <panic>
}
801012e5:	83 c4 24             	add    $0x24,%esp
801012e8:	5b                   	pop    %ebx
801012e9:	5d                   	pop    %ebp
801012ea:	c3                   	ret    
	...

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
80101320:	e8 00 40 00 00       	call   80105325 <memmove>
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
80101366:	e8 eb 3e 00 00       	call   80105256 <memset>
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
801014c3:	c7 04 24 45 87 10 80 	movl   $0x80108745,(%esp)
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
80101555:	c7 04 24 5b 87 10 80 	movl   $0x8010875b,(%esp)
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
801015a5:	c7 44 24 04 6e 87 10 	movl   $0x8010876e,0x4(%esp)
801015ac:	80 
801015ad:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
801015b4:	e8 25 3a 00 00       	call   80104fde <initlock>
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
80101636:	e8 1b 3c 00 00       	call   80105256 <memset>
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
8010168c:	c7 04 24 75 87 10 80 	movl   $0x80108775,(%esp)
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
80101735:	e8 eb 3b 00 00       	call   80105325 <memmove>
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
8010175f:	e8 9b 38 00 00       	call   80104fff <acquire>

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
801017a9:	e8 b3 38 00 00       	call   80105061 <release>
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
801017dc:	c7 04 24 87 87 10 80 	movl   $0x80108787,(%esp)
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
8010181a:	e8 42 38 00 00       	call   80105061 <release>

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
80101831:	e8 c9 37 00 00       	call   80104fff <acquire>
  ip->ref++;
80101836:	8b 45 08             	mov    0x8(%ebp),%eax
80101839:	8b 40 08             	mov    0x8(%eax),%eax
8010183c:	8d 50 01             	lea    0x1(%eax),%edx
8010183f:	8b 45 08             	mov    0x8(%ebp),%eax
80101842:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101845:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
8010184c:	e8 10 38 00 00       	call   80105061 <release>
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
8010186c:	c7 04 24 97 87 10 80 	movl   $0x80108797,(%esp)
80101873:	e8 c2 ec ff ff       	call   8010053a <panic>

  acquire(&icache.lock);
80101878:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
8010187f:	e8 7b 37 00 00       	call   80104fff <acquire>
  while(ip->flags & I_BUSY)
80101884:	eb 13                	jmp    80101899 <ilock+0x43>
    sleep(ip, &icache.lock);
80101886:	c7 44 24 04 80 e8 10 	movl   $0x8010e880,0x4(%esp)
8010188d:	80 
8010188e:	8b 45 08             	mov    0x8(%ebp),%eax
80101891:	89 04 24             	mov    %eax,(%esp)
80101894:	e8 f3 33 00 00       	call   80104c8c <sleep>

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
801018be:	e8 9e 37 00 00       	call   80105061 <release>

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
80101969:	e8 b7 39 00 00       	call   80105325 <memmove>
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
80101996:	c7 04 24 9d 87 10 80 	movl   $0x8010879d,(%esp)
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
801019c7:	c7 04 24 ac 87 10 80 	movl   $0x801087ac,(%esp)
801019ce:	e8 67 eb ff ff       	call   8010053a <panic>

  acquire(&icache.lock);
801019d3:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
801019da:	e8 20 36 00 00       	call   80104fff <acquire>
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
801019f6:	e8 d5 33 00 00       	call   80104dd0 <wakeup>
  release(&icache.lock);
801019fb:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101a02:	e8 5a 36 00 00       	call   80105061 <release>
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
80101a16:	e8 e4 35 00 00       	call   80104fff <acquire>
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
80101a54:	c7 04 24 b4 87 10 80 	movl   $0x801087b4,(%esp)
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
80101a78:	e8 e4 35 00 00       	call   80105061 <release>
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
80101aa3:	e8 57 35 00 00       	call   80104fff <acquire>
    ip->flags = 0;
80101aa8:	8b 45 08             	mov    0x8(%ebp),%eax
80101aab:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101ab2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ab5:	89 04 24             	mov    %eax,(%esp)
80101ab8:	e8 13 33 00 00       	call   80104dd0 <wakeup>
  }
  ip->ref--;
80101abd:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac0:	8b 40 08             	mov    0x8(%eax),%eax
80101ac3:	8d 50 ff             	lea    -0x1(%eax),%edx
80101ac6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac9:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101acc:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101ad3:	e8 89 35 00 00       	call   80105061 <release>
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
80101bf3:	c7 04 24 be 87 10 80 	movl   $0x801087be,(%esp)
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
80101e94:	e8 8c 34 00 00       	call   80105325 <memmove>
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
80101ff3:	e8 2d 33 00 00       	call   80105325 <memmove>
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
80102071:	e8 52 33 00 00       	call   801053c8 <strncmp>
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
8010208b:	c7 04 24 d1 87 10 80 	movl   $0x801087d1,(%esp)
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
801020c9:	c7 04 24 e3 87 10 80 	movl   $0x801087e3,(%esp)
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
801021ae:	c7 04 24 e3 87 10 80 	movl   $0x801087e3,(%esp)
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
801021f3:	e8 26 32 00 00       	call   8010541e <strncpy>
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
80102225:	c7 04 24 f0 87 10 80 	movl   $0x801087f0,(%esp)
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
801022aa:	e8 76 30 00 00       	call   80105325 <memmove>
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
801022c5:	e8 5b 30 00 00       	call   80105325 <memmove>
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
80102445:	00 00                	add    %al,(%eax)
	...

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
80102517:	c7 44 24 04 f8 87 10 	movl   $0x801087f8,0x4(%esp)
8010251e:	80 
8010251f:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
80102526:	e8 b3 2a 00 00       	call   80104fde <initlock>
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
801025c3:	c7 04 24 fc 87 10 80 	movl   $0x801087fc,(%esp)
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
801026e9:	e8 11 29 00 00       	call   80104fff <acquire>
  if((b = idequeue) == 0){
801026ee:	a1 54 b6 10 80       	mov    0x8010b654,%eax
801026f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801026fa:	75 11                	jne    8010270d <ideintr+0x31>
    release(&idelock);
801026fc:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
80102703:	e8 59 29 00 00       	call   80105061 <release>
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
80102776:	e8 55 26 00 00       	call   80104dd0 <wakeup>
  
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
80102798:	e8 c4 28 00 00       	call   80105061 <release>
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
801027b1:	c7 04 24 05 88 10 80 	movl   $0x80108805,(%esp)
801027b8:	e8 7d dd ff ff       	call   8010053a <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801027bd:	8b 45 08             	mov    0x8(%ebp),%eax
801027c0:	8b 00                	mov    (%eax),%eax
801027c2:	83 e0 06             	and    $0x6,%eax
801027c5:	83 f8 02             	cmp    $0x2,%eax
801027c8:	75 0c                	jne    801027d6 <iderw+0x37>
    panic("iderw: nothing to do");
801027ca:	c7 04 24 19 88 10 80 	movl   $0x80108819,(%esp)
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
801027e9:	c7 04 24 2e 88 10 80 	movl   $0x8010882e,(%esp)
801027f0:	e8 45 dd ff ff       	call   8010053a <panic>

  acquire(&idelock);  //DOC:acquire-lock
801027f5:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
801027fc:	e8 fe 27 00 00       	call   80104fff <acquire>

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
80102857:	e8 30 24 00 00       	call   80104c8c <sleep>
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
80102870:	e8 ec 27 00 00       	call   80105061 <release>
}
80102875:	c9                   	leave  
80102876:	c3                   	ret    
	...

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
801028ff:	c7 04 24 4c 88 10 80 	movl   $0x8010884c,(%esp)
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
	...

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
801029bb:	c7 44 24 04 7e 88 10 	movl   $0x8010887e,0x4(%esp)
801029c2:	80 
801029c3:	c7 04 24 60 f8 10 80 	movl   $0x8010f860,(%esp)
801029ca:	e8 0f 26 00 00       	call   80104fde <initlock>
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
80102a5c:	81 7d 08 1c 2a 11 80 	cmpl   $0x80112a1c,0x8(%ebp)
80102a63:	72 12                	jb     80102a77 <kfree+0x2d>
80102a65:	8b 45 08             	mov    0x8(%ebp),%eax
80102a68:	89 04 24             	mov    %eax,(%esp)
80102a6b:	e8 38 ff ff ff       	call   801029a8 <v2p>
80102a70:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102a75:	76 0c                	jbe    80102a83 <kfree+0x39>
    panic("kfree");
80102a77:	c7 04 24 83 88 10 80 	movl   $0x80108883,(%esp)
80102a7e:	e8 b7 da ff ff       	call   8010053a <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102a83:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80102a8a:	00 
80102a8b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102a92:	00 
80102a93:	8b 45 08             	mov    0x8(%ebp),%eax
80102a96:	89 04 24             	mov    %eax,(%esp)
80102a99:	e8 b8 27 00 00       	call   80105256 <memset>

  if(kmem.use_lock)
80102a9e:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102aa3:	85 c0                	test   %eax,%eax
80102aa5:	74 0c                	je     80102ab3 <kfree+0x69>
    acquire(&kmem.lock);
80102aa7:	c7 04 24 60 f8 10 80 	movl   $0x8010f860,(%esp)
80102aae:	e8 4c 25 00 00       	call   80104fff <acquire>
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
80102adc:	e8 80 25 00 00       	call   80105061 <release>
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
80102af9:	e8 01 25 00 00       	call   80104fff <acquire>
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
80102b26:	e8 36 25 00 00       	call   80105061 <release>
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
80102e89:	c7 04 24 8c 88 10 80 	movl   $0x8010888c,(%esp)
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
80102fde:	c7 44 24 04 b8 88 10 	movl   $0x801088b8,0x4(%esp)
80102fe5:	80 
80102fe6:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
80102fed:	e8 ec 1f 00 00       	call   80104fde <initlock>
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
801030a1:	e8 7f 22 00 00       	call   80105325 <memmove>
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
801031f3:	e8 07 1e 00 00       	call   80104fff <acquire>
  while (log.busy) {
801031f8:	eb 14                	jmp    8010320e <begin_trans+0x28>
    sleep(&log, &log.lock);
801031fa:	c7 44 24 04 a0 f8 10 	movl   $0x8010f8a0,0x4(%esp)
80103201:	80 
80103202:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
80103209:	e8 7e 1a 00 00       	call   80104c8c <sleep>

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
80103228:	e8 34 1e 00 00       	call   80105061 <release>
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
8010325e:	e8 9c 1d 00 00       	call   80104fff <acquire>
  log.busy = 0;
80103263:	c7 05 dc f8 10 80 00 	movl   $0x0,0x8010f8dc
8010326a:	00 00 00 
  wakeup(&log);
8010326d:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
80103274:	e8 57 1b 00 00       	call   80104dd0 <wakeup>
  release(&log.lock);
80103279:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
80103280:	e8 dc 1d 00 00       	call   80105061 <release>
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
801032a9:	c7 04 24 bc 88 10 80 	movl   $0x801088bc,(%esp)
801032b0:	e8 85 d2 ff ff       	call   8010053a <panic>
  if (!log.busy)
801032b5:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
801032ba:	85 c0                	test   %eax,%eax
801032bc:	75 0c                	jne    801032ca <log_write+0x43>
    panic("write outside of trans");
801032be:	c7 04 24 d2 88 10 80 	movl   $0x801088d2,(%esp)
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
8010334f:	e8 d1 1f 00 00       	call   80105325 <memmove>
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
	...

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
801033d9:	c7 04 24 1c 2a 11 80 	movl   $0x80112a1c,(%esp)
801033e0:	e8 d0 f5 ff ff       	call   801029b5 <kinit1>
  kvmalloc();      // kernel page table
801033e5:	e8 14 4b 00 00       	call   80107efe <kvmalloc>
  mpinit();        // collect info about this machine
801033ea:	e8 47 04 00 00       	call   80103836 <mpinit>
  lapicinit();
801033ef:	e8 0f f9 ff ff       	call   80102d03 <lapicinit>
  seginit();       // set up segments
801033f4:	e8 98 44 00 00       	call   80107891 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
801033f9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801033ff:	0f b6 00             	movzbl (%eax),%eax
80103402:	0f b6 c0             	movzbl %al,%eax
80103405:	89 44 24 04          	mov    %eax,0x4(%esp)
80103409:	c7 04 24 e9 88 10 80 	movl   $0x801088e9,(%esp)
80103410:	e8 8b cf ff ff       	call   801003a0 <cprintf>
  picinit();       // interrupt controller
80103415:	e8 7d 06 00 00       	call   80103a97 <picinit>
  ioapicinit();    // another interrupt controller
8010341a:	e8 8a f4 ff ff       	call   801028a9 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
8010341f:	e8 5d d6 ff ff       	call   80100a81 <consoleinit>
  uartinit();      // serial port
80103424:	e8 b2 37 00 00       	call   80106bdb <uartinit>
  pinit();         // process table
80103429:	e8 fa 0b 00 00       	call   80104028 <pinit>
  tvinit();        // trap vectors
8010342e:	e8 57 33 00 00       	call   8010678a <tvinit>
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
80103450:	e8 7d 32 00 00       	call   801066d2 <timerinit>
  startothers();   // start other processors
80103455:	e8 7f 00 00 00       	call   801034d9 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
8010345a:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80103461:	8e 
80103462:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103469:	e8 7f f5 ff ff       	call   801029ed <kinit2>
  userinit();      // first user process
8010346e:	e8 d3 0c 00 00       	call   80104146 <userinit>
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
8010347e:	e8 92 4a 00 00       	call   80107f15 <switchkvm>
  seginit();
80103483:	e8 09 44 00 00       	call   80107891 <seginit>
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
801034a8:	c7 04 24 00 89 10 80 	movl   $0x80108900,(%esp)
801034af:	e8 ec ce ff ff       	call   801003a0 <cprintf>
  idtinit();       // load idt register
801034b4:	e8 45 34 00 00       	call   801068fe <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
801034b9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801034bf:	05 a8 00 00 00       	add    $0xa8,%eax
801034c4:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801034cb:	00 
801034cc:	89 04 24             	mov    %eax,(%esp)
801034cf:	e8 da fe ff ff       	call   801033ae <xchg>
  scheduler();     // start running processes
801034d4:	e8 34 15 00 00       	call   80104a0d <scheduler>

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
80103506:	e8 1a 1e 00 00       	call   80105325 <memmove>

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
	...

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
80103689:	c7 44 24 04 14 89 10 	movl   $0x80108914,0x4(%esp)
80103690:	80 
80103691:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103694:	89 04 24             	mov    %eax,(%esp)
80103697:	e8 31 1c 00 00       	call   801052cd <memcmp>
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
801037ca:	c7 44 24 04 19 89 10 	movl   $0x80108919,0x4(%esp)
801037d1:	80 
801037d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801037d5:	89 04 24             	mov    %eax,(%esp)
801037d8:	e8 f0 1a 00 00       	call   801052cd <memcmp>
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
801038a6:	8b 04 85 5c 89 10 80 	mov    -0x7fef76a4(,%eax,4),%eax
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
801038df:	c7 04 24 1e 89 10 80 	movl   $0x8010891e,(%esp)
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
80103972:	c7 04 24 3c 89 10 80 	movl   $0x8010893c,(%esp)
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
801039fd:	00 00                	add    %al,(%eax)
	...

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
80103bbc:	66 83 f8 ff          	cmp    $0xffffffff,%ax
80103bc0:	74 12                	je     80103bd4 <picinit+0x13d>
    picsetmask(irqmask);
80103bc2:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103bc9:	0f b7 c0             	movzwl %ax,%eax
80103bcc:	89 04 24             	mov    %eax,(%esp)
80103bcf:	e8 4a fe ff ff       	call   80103a1e <picsetmask>
}
80103bd4:	c9                   	leave  
80103bd5:	c3                   	ret    
	...

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
80103c70:	c7 44 24 04 70 89 10 	movl   $0x80108970,0x4(%esp)
80103c77:	80 
80103c78:	89 04 24             	mov    %eax,(%esp)
80103c7b:	e8 5e 13 00 00       	call   80104fde <initlock>
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
80103d27:	e8 d3 12 00 00       	call   80104fff <acquire>
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
80103d4a:	e8 81 10 00 00       	call   80104dd0 <wakeup>
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
80103d69:	e8 62 10 00 00       	call   80104dd0 <wakeup>
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
80103d8e:	e8 ce 12 00 00       	call   80105061 <release>
    kfree((char*)p);
80103d93:	8b 45 08             	mov    0x8(%ebp),%eax
80103d96:	89 04 24             	mov    %eax,(%esp)
80103d99:	e8 ac ec ff ff       	call   80102a4a <kfree>
80103d9e:	eb 0b                	jmp    80103dab <pipeclose+0x90>
  } else
    release(&p->lock);
80103da0:	8b 45 08             	mov    0x8(%ebp),%eax
80103da3:	89 04 24             	mov    %eax,(%esp)
80103da6:	e8 b6 12 00 00       	call   80105061 <release>
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
80103db9:	e8 41 12 00 00       	call   80104fff <acquire>
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
80103dec:	e8 70 12 00 00       	call   80105061 <release>
        return -1;
80103df1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103df6:	e9 9f 00 00 00       	jmp    80103e9a <pipewrite+0xed>
      }
      wakeup(&p->nread);
80103dfb:	8b 45 08             	mov    0x8(%ebp),%eax
80103dfe:	05 34 02 00 00       	add    $0x234,%eax
80103e03:	89 04 24             	mov    %eax,(%esp)
80103e06:	e8 c5 0f 00 00       	call   80104dd0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103e0b:	8b 45 08             	mov    0x8(%ebp),%eax
80103e0e:	8b 55 08             	mov    0x8(%ebp),%edx
80103e11:	81 c2 38 02 00 00    	add    $0x238,%edx
80103e17:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e1b:	89 14 24             	mov    %edx,(%esp)
80103e1e:	e8 69 0e 00 00       	call   80104c8c <sleep>
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
80103e87:	e8 44 0f 00 00       	call   80104dd0 <wakeup>
  release(&p->lock);
80103e8c:	8b 45 08             	mov    0x8(%ebp),%eax
80103e8f:	89 04 24             	mov    %eax,(%esp)
80103e92:	e8 ca 11 00 00       	call   80105061 <release>
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
80103ea9:	e8 51 11 00 00       	call   80104fff <acquire>
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
80103ec3:	e8 99 11 00 00       	call   80105061 <release>
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
80103ee5:	e8 a2 0d 00 00       	call   80104c8c <sleep>
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
80103f74:	e8 57 0e 00 00       	call   80104dd0 <wakeup>
  release(&p->lock);
80103f79:	8b 45 08             	mov    0x8(%ebp),%eax
80103f7c:	89 04 24             	mov    %eax,(%esp)
80103f7f:	e8 dd 10 00 00       	call   80105061 <release>
  return i;
80103f84:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103f87:	83 c4 24             	add    $0x24,%esp
80103f8a:	5b                   	pop    %ebx
80103f8b:	5d                   	pop    %ebp
80103f8c:	c3                   	ret    
80103f8d:	00 00                	add    %al,(%eax)
	...

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
8010402e:	c7 44 24 04 78 89 10 	movl   $0x80108978,0x4(%esp)
80104035:	80 
80104036:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
8010403d:	e8 9c 0f 00 00       	call   80104fde <initlock>
}
80104042:	c9                   	leave  
80104043:	c3                   	ret    

80104044 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
    static struct proc*
allocproc(void)
{
80104044:	55                   	push   %ebp
80104045:	89 e5                	mov    %esp,%ebp
80104047:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    char *sp;

    acquire(&ptable.lock);
8010404a:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104051:	e8 a9 0f 00 00       	call   80104fff <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104056:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
8010405d:	eb 53                	jmp    801040b2 <allocproc+0x6e>
        if(p->state == UNUSED)
8010405f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104062:	8b 40 0c             	mov    0xc(%eax),%eax
80104065:	85 c0                	test   %eax,%eax
80104067:	75 42                	jne    801040ab <allocproc+0x67>
            goto found;
80104069:	90                   	nop
    release(&ptable.lock);
    return 0;

found:
    p->state = EMBRYO;
8010406a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010406d:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
    p->pid = nextpid++;
80104074:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80104079:	8d 50 01             	lea    0x1(%eax),%edx
8010407c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80104082:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104085:	89 42 10             	mov    %eax,0x10(%edx)
    release(&ptable.lock);
80104088:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
8010408f:	e8 cd 0f 00 00       	call   80105061 <release>

    // Allocate kernel stack.
    if((p->kstack = kalloc()) == 0){
80104094:	e8 4a ea ff ff       	call   80102ae3 <kalloc>
80104099:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010409c:	89 42 08             	mov    %eax,0x8(%edx)
8010409f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040a2:	8b 40 08             	mov    0x8(%eax),%eax
801040a5:	85 c0                	test   %eax,%eax
801040a7:	75 36                	jne    801040df <allocproc+0x9b>
801040a9:	eb 23                	jmp    801040ce <allocproc+0x8a>
{
    struct proc *p;
    char *sp;

    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040ab:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
801040b2:	81 7d f4 74 21 11 80 	cmpl   $0x80112174,-0xc(%ebp)
801040b9:	72 a4                	jb     8010405f <allocproc+0x1b>
        if(p->state == UNUSED)
            goto found;
    release(&ptable.lock);
801040bb:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801040c2:	e8 9a 0f 00 00       	call   80105061 <release>
    return 0;
801040c7:	b8 00 00 00 00       	mov    $0x0,%eax
801040cc:	eb 76                	jmp    80104144 <allocproc+0x100>
    p->pid = nextpid++;
    release(&ptable.lock);

    // Allocate kernel stack.
    if((p->kstack = kalloc()) == 0){
        p->state = UNUSED;
801040ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040d1:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        return 0;
801040d8:	b8 00 00 00 00       	mov    $0x0,%eax
801040dd:	eb 65                	jmp    80104144 <allocproc+0x100>
    }
    sp = p->kstack + KSTACKSIZE;
801040df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040e2:	8b 40 08             	mov    0x8(%eax),%eax
801040e5:	05 00 10 00 00       	add    $0x1000,%eax
801040ea:	89 45 f0             	mov    %eax,-0x10(%ebp)

    // Leave room for trap frame.
    sp -= sizeof *p->tf;
801040ed:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
    p->tf = (struct trapframe*)sp;
801040f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040f4:	8b 55 f0             	mov    -0x10(%ebp),%edx
801040f7:	89 50 18             	mov    %edx,0x18(%eax)

    // Set up new context to start executing at forkret,
    // which returns to trapret.
    sp -= 4;
801040fa:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
    *(uint*)sp = (uint)trapret;
801040fe:	ba 44 67 10 80       	mov    $0x80106744,%edx
80104103:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104106:	89 10                	mov    %edx,(%eax)

    sp -= sizeof *p->context;
80104108:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
    p->context = (struct context*)sp;
8010410c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010410f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104112:	89 50 1c             	mov    %edx,0x1c(%eax)
    memset(p->context, 0, sizeof *p->context);
80104115:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104118:	8b 40 1c             	mov    0x1c(%eax),%eax
8010411b:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104122:	00 
80104123:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010412a:	00 
8010412b:	89 04 24             	mov    %eax,(%esp)
8010412e:	e8 23 11 00 00       	call   80105256 <memset>
    p->context->eip = (uint)forkret;
80104133:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104136:	8b 40 1c             	mov    0x1c(%eax),%eax
80104139:	ba 60 4c 10 80       	mov    $0x80104c60,%edx
8010413e:	89 50 10             	mov    %edx,0x10(%eax)

    return p;
80104141:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104144:	c9                   	leave  
80104145:	c3                   	ret    

80104146 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
    void
userinit(void)
{
80104146:	55                   	push   %ebp
80104147:	89 e5                	mov    %esp,%ebp
80104149:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    extern char _binary_initcode_start[], _binary_initcode_size[];

    p = allocproc();
8010414c:	e8 f3 fe ff ff       	call   80104044 <allocproc>
80104151:	89 45 f4             	mov    %eax,-0xc(%ebp)
    initproc = p;
80104154:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104157:	a3 68 b6 10 80       	mov    %eax,0x8010b668
    if((p->pgdir = setupkvm()) == 0)
8010415c:	e8 e0 3c 00 00       	call   80107e41 <setupkvm>
80104161:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104164:	89 42 04             	mov    %eax,0x4(%edx)
80104167:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010416a:	8b 40 04             	mov    0x4(%eax),%eax
8010416d:	85 c0                	test   %eax,%eax
8010416f:	75 0c                	jne    8010417d <userinit+0x37>
        panic("userinit: out of memory?");
80104171:	c7 04 24 7f 89 10 80 	movl   $0x8010897f,(%esp)
80104178:	e8 bd c3 ff ff       	call   8010053a <panic>
    inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
8010417d:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104182:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104185:	8b 40 04             	mov    0x4(%eax),%eax
80104188:	89 54 24 08          	mov    %edx,0x8(%esp)
8010418c:	c7 44 24 04 00 b5 10 	movl   $0x8010b500,0x4(%esp)
80104193:	80 
80104194:	89 04 24             	mov    %eax,(%esp)
80104197:	e8 fd 3e 00 00       	call   80108099 <inituvm>
    p->sz = PGSIZE;
8010419c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010419f:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
    memset(p->tf, 0, sizeof(*p->tf));
801041a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041a8:	8b 40 18             	mov    0x18(%eax),%eax
801041ab:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
801041b2:	00 
801041b3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801041ba:	00 
801041bb:	89 04 24             	mov    %eax,(%esp)
801041be:	e8 93 10 00 00       	call   80105256 <memset>
    p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801041c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041c6:	8b 40 18             	mov    0x18(%eax),%eax
801041c9:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
    p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801041cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041d2:	8b 40 18             	mov    0x18(%eax),%eax
801041d5:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
    p->tf->es = p->tf->ds;
801041db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041de:	8b 40 18             	mov    0x18(%eax),%eax
801041e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041e4:	8b 52 18             	mov    0x18(%edx),%edx
801041e7:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801041eb:	66 89 50 28          	mov    %dx,0x28(%eax)
    p->tf->ss = p->tf->ds;
801041ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041f2:	8b 40 18             	mov    0x18(%eax),%eax
801041f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041f8:	8b 52 18             	mov    0x18(%edx),%edx
801041fb:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801041ff:	66 89 50 48          	mov    %dx,0x48(%eax)
    p->tf->eflags = FL_IF;
80104203:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104206:	8b 40 18             	mov    0x18(%eax),%eax
80104209:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
    p->tf->esp = PGSIZE;
80104210:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104213:	8b 40 18             	mov    0x18(%eax),%eax
80104216:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
    p->tf->eip = 0;  // beginning of initcode.S
8010421d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104220:	8b 40 18             	mov    0x18(%eax),%eax
80104223:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

    safestrcpy(p->name, "initcode", sizeof(p->name));
8010422a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010422d:	83 c0 6c             	add    $0x6c,%eax
80104230:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104237:	00 
80104238:	c7 44 24 04 98 89 10 	movl   $0x80108998,0x4(%esp)
8010423f:	80 
80104240:	89 04 24             	mov    %eax,(%esp)
80104243:	e8 2e 12 00 00       	call   80105476 <safestrcpy>
    p->cwd = namei("/");
80104248:	c7 04 24 a1 89 10 80 	movl   $0x801089a1,(%esp)
8010424f:	e8 ad e1 ff ff       	call   80102401 <namei>
80104254:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104257:	89 42 68             	mov    %eax,0x68(%edx)

    p->state = RUNNABLE;
8010425a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010425d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
80104264:	c9                   	leave  
80104265:	c3                   	ret    

80104266 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
    int
growproc(int n)
{
80104266:	55                   	push   %ebp
80104267:	89 e5                	mov    %esp,%ebp
80104269:	83 ec 28             	sub    $0x28,%esp
    uint sz;

    sz = proc->sz;
8010426c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104272:	8b 00                	mov    (%eax),%eax
80104274:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(n > 0){
80104277:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010427b:	7e 34                	jle    801042b1 <growproc+0x4b>
        if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
8010427d:	8b 55 08             	mov    0x8(%ebp),%edx
80104280:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104283:	01 c2                	add    %eax,%edx
80104285:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010428b:	8b 40 04             	mov    0x4(%eax),%eax
8010428e:	89 54 24 08          	mov    %edx,0x8(%esp)
80104292:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104295:	89 54 24 04          	mov    %edx,0x4(%esp)
80104299:	89 04 24             	mov    %eax,(%esp)
8010429c:	e8 6e 3f 00 00       	call   8010820f <allocuvm>
801042a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801042a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801042a8:	75 41                	jne    801042eb <growproc+0x85>
            return -1;
801042aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042af:	eb 58                	jmp    80104309 <growproc+0xa3>
    } else if(n < 0){
801042b1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801042b5:	79 34                	jns    801042eb <growproc+0x85>
        if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
801042b7:	8b 55 08             	mov    0x8(%ebp),%edx
801042ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042bd:	01 c2                	add    %eax,%edx
801042bf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042c5:	8b 40 04             	mov    0x4(%eax),%eax
801042c8:	89 54 24 08          	mov    %edx,0x8(%esp)
801042cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042cf:	89 54 24 04          	mov    %edx,0x4(%esp)
801042d3:	89 04 24             	mov    %eax,(%esp)
801042d6:	e8 0e 40 00 00       	call   801082e9 <deallocuvm>
801042db:	89 45 f4             	mov    %eax,-0xc(%ebp)
801042de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801042e2:	75 07                	jne    801042eb <growproc+0x85>
            return -1;
801042e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042e9:	eb 1e                	jmp    80104309 <growproc+0xa3>
    }
    proc->sz = sz;
801042eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042f4:	89 10                	mov    %edx,(%eax)
    switchuvm(proc);
801042f6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042fc:	89 04 24             	mov    %eax,(%esp)
801042ff:	e8 2e 3c 00 00       	call   80107f32 <switchuvm>
    return 0;
80104304:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104309:	c9                   	leave  
8010430a:	c3                   	ret    

8010430b <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
    int
fork(void)
{
8010430b:	55                   	push   %ebp
8010430c:	89 e5                	mov    %esp,%ebp
8010430e:	57                   	push   %edi
8010430f:	56                   	push   %esi
80104310:	53                   	push   %ebx
80104311:	83 ec 2c             	sub    $0x2c,%esp
    int i, pid;
    struct proc *np;

    // Allocate process.
    if((np = allocproc()) == 0)
80104314:	e8 2b fd ff ff       	call   80104044 <allocproc>
80104319:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010431c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80104320:	75 0a                	jne    8010432c <fork+0x21>
        return -1;
80104322:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104327:	e9 47 01 00 00       	jmp    80104473 <fork+0x168>

    // Copy process state from p.
    if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
8010432c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104332:	8b 10                	mov    (%eax),%edx
80104334:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010433a:	8b 40 04             	mov    0x4(%eax),%eax
8010433d:	89 54 24 04          	mov    %edx,0x4(%esp)
80104341:	89 04 24             	mov    %eax,(%esp)
80104344:	e8 3c 41 00 00       	call   80108485 <copyuvm>
80104349:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010434c:	89 42 04             	mov    %eax,0x4(%edx)
8010434f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104352:	8b 40 04             	mov    0x4(%eax),%eax
80104355:	85 c0                	test   %eax,%eax
80104357:	75 2c                	jne    80104385 <fork+0x7a>
        kfree(np->kstack);
80104359:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010435c:	8b 40 08             	mov    0x8(%eax),%eax
8010435f:	89 04 24             	mov    %eax,(%esp)
80104362:	e8 e3 e6 ff ff       	call   80102a4a <kfree>
        np->kstack = 0;
80104367:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010436a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        np->state = UNUSED;
80104371:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104374:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        return -1;
8010437b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104380:	e9 ee 00 00 00       	jmp    80104473 <fork+0x168>
    }
    np->sz = proc->sz;
80104385:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010438b:	8b 10                	mov    (%eax),%edx
8010438d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104390:	89 10                	mov    %edx,(%eax)
    np->parent = proc;
80104392:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104399:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010439c:	89 50 14             	mov    %edx,0x14(%eax)
    *np->tf = *proc->tf;
8010439f:	8b 45 e0             	mov    -0x20(%ebp),%eax
801043a2:	8b 50 18             	mov    0x18(%eax),%edx
801043a5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043ab:	8b 40 18             	mov    0x18(%eax),%eax
801043ae:	89 c3                	mov    %eax,%ebx
801043b0:	b8 13 00 00 00       	mov    $0x13,%eax
801043b5:	89 d7                	mov    %edx,%edi
801043b7:	89 de                	mov    %ebx,%esi
801043b9:	89 c1                	mov    %eax,%ecx
801043bb:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    np->isthread = 0;
801043bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
801043c0:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801043c7:	00 00 00 

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;
801043ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
801043cd:	8b 40 18             	mov    0x18(%eax),%eax
801043d0:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

    for(i = 0; i < NOFILE; i++)
801043d7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801043de:	eb 3d                	jmp    8010441d <fork+0x112>
        if(proc->ofile[i])
801043e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043e6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801043e9:	83 c2 08             	add    $0x8,%edx
801043ec:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801043f0:	85 c0                	test   %eax,%eax
801043f2:	74 25                	je     80104419 <fork+0x10e>
            np->ofile[i] = filedup(proc->ofile[i]);
801043f4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801043fd:	83 c2 08             	add    $0x8,%edx
80104400:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104404:	89 04 24             	mov    %eax,(%esp)
80104407:	e8 74 cb ff ff       	call   80100f80 <filedup>
8010440c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010440f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104412:	83 c1 08             	add    $0x8,%ecx
80104415:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
    np->isthread = 0;

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;

    for(i = 0; i < NOFILE; i++)
80104419:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010441d:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104421:	7e bd                	jle    801043e0 <fork+0xd5>
        if(proc->ofile[i])
            np->ofile[i] = filedup(proc->ofile[i]);
    np->cwd = idup(proc->cwd);
80104423:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104429:	8b 40 68             	mov    0x68(%eax),%eax
8010442c:	89 04 24             	mov    %eax,(%esp)
8010442f:	e8 f0 d3 ff ff       	call   80101824 <idup>
80104434:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104437:	89 42 68             	mov    %eax,0x68(%edx)

    pid = np->pid;
8010443a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010443d:	8b 40 10             	mov    0x10(%eax),%eax
80104440:	89 45 dc             	mov    %eax,-0x24(%ebp)
    np->state = RUNNABLE;
80104443:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104446:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
    safestrcpy(np->name, proc->name, sizeof(proc->name));
8010444d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104453:	8d 50 6c             	lea    0x6c(%eax),%edx
80104456:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104459:	83 c0 6c             	add    $0x6c,%eax
8010445c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104463:	00 
80104464:	89 54 24 04          	mov    %edx,0x4(%esp)
80104468:	89 04 24             	mov    %eax,(%esp)
8010446b:	e8 06 10 00 00       	call   80105476 <safestrcpy>
    return pid;
80104470:	8b 45 dc             	mov    -0x24(%ebp),%eax

}
80104473:	83 c4 2c             	add    $0x2c,%esp
80104476:	5b                   	pop    %ebx
80104477:	5e                   	pop    %esi
80104478:	5f                   	pop    %edi
80104479:	5d                   	pop    %ebp
8010447a:	c3                   	ret    

8010447b <clone>:

//creat a new process but used parent pgdir. 
int clone(int stack, int size, int routine, int arg){ 
8010447b:	55                   	push   %ebp
8010447c:	89 e5                	mov    %esp,%ebp
8010447e:	57                   	push   %edi
8010447f:	56                   	push   %esi
80104480:	53                   	push   %ebx
80104481:	81 ec bc 00 00 00    	sub    $0xbc,%esp
    int i, pid;
    struct proc *np;

    //cprintf("in clone\n");
    // Allocate process.
    if((np = allocproc()) == 0)
80104487:	e8 b8 fb ff ff       	call   80104044 <allocproc>
8010448c:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010448f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
80104493:	75 0a                	jne    8010449f <clone+0x24>
        return -1;
80104495:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010449a:	e9 f4 01 00 00       	jmp    80104693 <clone+0x218>
    if((stack % PGSIZE) != 0 || stack == 0 || routine == 0)
8010449f:	8b 45 08             	mov    0x8(%ebp),%eax
801044a2:	25 ff 0f 00 00       	and    $0xfff,%eax
801044a7:	85 c0                	test   %eax,%eax
801044a9:	75 0c                	jne    801044b7 <clone+0x3c>
801044ab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801044af:	74 06                	je     801044b7 <clone+0x3c>
801044b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801044b5:	75 0a                	jne    801044c1 <clone+0x46>
        return -1;
801044b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801044bc:	e9 d2 01 00 00       	jmp    80104693 <clone+0x218>

    np->pgdir = proc->pgdir;
801044c1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044c7:	8b 50 04             	mov    0x4(%eax),%edx
801044ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
801044cd:	89 50 04             	mov    %edx,0x4(%eax)
    np->sz = proc->sz;
801044d0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044d6:	8b 10                	mov    (%eax),%edx
801044d8:	8b 45 dc             	mov    -0x24(%ebp),%eax
801044db:	89 10                	mov    %edx,(%eax)
    np->parent = proc;
801044dd:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801044e4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801044e7:	89 50 14             	mov    %edx,0x14(%eax)
    *np->tf = *proc->tf;
801044ea:	8b 45 dc             	mov    -0x24(%ebp),%eax
801044ed:	8b 50 18             	mov    0x18(%eax),%edx
801044f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044f6:	8b 40 18             	mov    0x18(%eax),%eax
801044f9:	89 c3                	mov    %eax,%ebx
801044fb:	b8 13 00 00 00       	mov    $0x13,%eax
80104500:	89 d7                	mov    %edx,%edi
80104502:	89 de                	mov    %ebx,%esi
80104504:	89 c1                	mov    %eax,%ecx
80104506:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    np->isthread = 1;
80104508:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010450b:	c7 80 80 00 00 00 01 	movl   $0x1,0x80(%eax)
80104512:	00 00 00 
    pid = np->pid;
80104515:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104518:	8b 40 10             	mov    0x10(%eax),%eax
8010451b:	89 45 d8             	mov    %eax,-0x28(%ebp)

    struct proc *pp;
    pp = proc;
8010451e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104524:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(pp->isthread == 1){
80104527:	eb 09                	jmp    80104532 <clone+0xb7>
        pp = pp->parent;
80104529:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010452c:	8b 40 14             	mov    0x14(%eax),%eax
8010452f:	89 45 e0             	mov    %eax,-0x20(%ebp)
    np->isthread = 1;
    pid = np->pid;

    struct proc *pp;
    pp = proc;
    while(pp->isthread == 1){
80104532:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104535:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
8010453b:	83 f8 01             	cmp    $0x1,%eax
8010453e:	74 e9                	je     80104529 <clone+0xae>
        pp = pp->parent;
    }
    np->parent = pp;
80104540:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104543:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104546:	89 50 14             	mov    %edx,0x14(%eax)
    //need to be modified as point to the same address
    //*np->ofile = *proc->ofile;
    for(i = 0; i < NOFILE; i++)
80104549:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104550:	eb 3d                	jmp    8010458f <clone+0x114>
        if(proc->ofile[i])
80104552:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104558:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010455b:	83 c2 08             	add    $0x8,%edx
8010455e:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104562:	85 c0                	test   %eax,%eax
80104564:	74 25                	je     8010458b <clone+0x110>
            np->ofile[i] = filedup(proc->ofile[i]);
80104566:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010456c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010456f:	83 c2 08             	add    $0x8,%edx
80104572:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104576:	89 04 24             	mov    %eax,(%esp)
80104579:	e8 02 ca ff ff       	call   80100f80 <filedup>
8010457e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80104581:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104584:	83 c1 08             	add    $0x8,%ecx
80104587:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
        pp = pp->parent;
    }
    np->parent = pp;
    //need to be modified as point to the same address
    //*np->ofile = *proc->ofile;
    for(i = 0; i < NOFILE; i++)
8010458b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010458f:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104593:	7e bd                	jle    80104552 <clone+0xd7>
        if(proc->ofile[i])
            np->ofile[i] = filedup(proc->ofile[i]);

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;
80104595:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104598:	8b 40 18             	mov    0x18(%eax),%eax
8010459b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

   
    uint ustack[MAXARG];
    uint sp = stack + PGSIZE;
801045a2:	8b 45 08             	mov    0x8(%ebp),%eax
801045a5:	05 00 10 00 00       	add    $0x1000,%eax
801045aa:	89 45 d4             	mov    %eax,-0x2c(%ebp)
//


//modify here <<<<<

    np->tf->ebp = sp;
801045ad:	8b 45 dc             	mov    -0x24(%ebp),%eax
801045b0:	8b 40 18             	mov    0x18(%eax),%eax
801045b3:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801045b6:	89 50 08             	mov    %edx,0x8(%eax)
    ustack[0] = 0xffffffff;
801045b9:	c7 85 54 ff ff ff ff 	movl   $0xffffffff,-0xac(%ebp)
801045c0:	ff ff ff 
    ustack[1] = arg;
801045c3:	8b 45 14             	mov    0x14(%ebp),%eax
801045c6:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
    sp -= 8;
801045cc:	83 6d d4 08          	subl   $0x8,-0x2c(%ebp)
    if(copyout(np->pgdir,sp,ustack,8)<0){
801045d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801045d3:	8b 40 04             	mov    0x4(%eax),%eax
801045d6:	c7 44 24 0c 08 00 00 	movl   $0x8,0xc(%esp)
801045dd:	00 
801045de:	8d 95 54 ff ff ff    	lea    -0xac(%ebp),%edx
801045e4:	89 54 24 08          	mov    %edx,0x8(%esp)
801045e8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801045eb:	89 54 24 04          	mov    %edx,0x4(%esp)
801045ef:	89 04 24             	mov    %eax,(%esp)
801045f2:	e8 0d 40 00 00       	call   80108604 <copyout>
801045f7:	85 c0                	test   %eax,%eax
801045f9:	79 16                	jns    80104611 <clone+0x196>
        cprintf("push arg fails\n");
801045fb:	c7 04 24 a3 89 10 80 	movl   $0x801089a3,(%esp)
80104602:	e8 99 bd ff ff       	call   801003a0 <cprintf>
        return -1;
80104607:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010460c:	e9 82 00 00 00       	jmp    80104693 <clone+0x218>
    }

    np->tf->eip = routine;
80104611:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104614:	8b 40 18             	mov    0x18(%eax),%eax
80104617:	8b 55 10             	mov    0x10(%ebp),%edx
8010461a:	89 50 38             	mov    %edx,0x38(%eax)
    np->tf->esp = sp;
8010461d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104620:	8b 40 18             	mov    0x18(%eax),%eax
80104623:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80104626:	89 50 44             	mov    %edx,0x44(%eax)
    np->cwd = idup(proc->cwd);
80104629:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010462f:	8b 40 68             	mov    0x68(%eax),%eax
80104632:	89 04 24             	mov    %eax,(%esp)
80104635:	e8 ea d1 ff ff       	call   80101824 <idup>
8010463a:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010463d:	89 42 68             	mov    %eax,0x68(%edx)

    switchuvm(np);
80104640:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104643:	89 04 24             	mov    %eax,(%esp)
80104646:	e8 e7 38 00 00       	call   80107f32 <switchuvm>

     acquire(&ptable.lock);
8010464b:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104652:	e8 a8 09 00 00       	call   80104fff <acquire>
    np->state = RUNNABLE;
80104657:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010465a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
     release(&ptable.lock);
80104661:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104668:	e8 f4 09 00 00       	call   80105061 <release>
    safestrcpy(np->name, proc->name, sizeof(proc->name));
8010466d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104673:	8d 50 6c             	lea    0x6c(%eax),%edx
80104676:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104679:	83 c0 6c             	add    $0x6c,%eax
8010467c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104683:	00 
80104684:	89 54 24 04          	mov    %edx,0x4(%esp)
80104688:	89 04 24             	mov    %eax,(%esp)
8010468b:	e8 e6 0d 00 00       	call   80105476 <safestrcpy>


    return pid;
80104690:	8b 45 d8             	mov    -0x28(%ebp),%eax

}
80104693:	81 c4 bc 00 00 00    	add    $0xbc,%esp
80104699:	5b                   	pop    %ebx
8010469a:	5e                   	pop    %esi
8010469b:	5f                   	pop    %edi
8010469c:	5d                   	pop    %ebp
8010469d:	c3                   	ret    

8010469e <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
    void
exit(void)
{
8010469e:	55                   	push   %ebp
8010469f:	89 e5                	mov    %esp,%ebp
801046a1:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    int fd;

    if(proc == initproc)
801046a4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801046ab:	a1 68 b6 10 80       	mov    0x8010b668,%eax
801046b0:	39 c2                	cmp    %eax,%edx
801046b2:	75 0c                	jne    801046c0 <exit+0x22>
        panic("init exiting");
801046b4:	c7 04 24 b3 89 10 80 	movl   $0x801089b3,(%esp)
801046bb:	e8 7a be ff ff       	call   8010053a <panic>

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
801046c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801046c7:	eb 44                	jmp    8010470d <exit+0x6f>
        if(proc->ofile[fd]){
801046c9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046cf:	8b 55 f0             	mov    -0x10(%ebp),%edx
801046d2:	83 c2 08             	add    $0x8,%edx
801046d5:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046d9:	85 c0                	test   %eax,%eax
801046db:	74 2c                	je     80104709 <exit+0x6b>
            fileclose(proc->ofile[fd]);
801046dd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046e3:	8b 55 f0             	mov    -0x10(%ebp),%edx
801046e6:	83 c2 08             	add    $0x8,%edx
801046e9:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046ed:	89 04 24             	mov    %eax,(%esp)
801046f0:	e8 d3 c8 ff ff       	call   80100fc8 <fileclose>
            proc->ofile[fd] = 0;
801046f5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046fb:	8b 55 f0             	mov    -0x10(%ebp),%edx
801046fe:	83 c2 08             	add    $0x8,%edx
80104701:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104708:	00 

    if(proc == initproc)
        panic("init exiting");

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
80104709:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010470d:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104711:	7e b6                	jle    801046c9 <exit+0x2b>
            fileclose(proc->ofile[fd]);
            proc->ofile[fd] = 0;
        }
    }

    iput(proc->cwd);
80104713:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104719:	8b 40 68             	mov    0x68(%eax),%eax
8010471c:	89 04 24             	mov    %eax,(%esp)
8010471f:	e8 e5 d2 ff ff       	call   80101a09 <iput>
    proc->cwd = 0;
80104724:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010472a:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

    acquire(&ptable.lock);
80104731:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104738:	e8 c2 08 00 00       	call   80104fff <acquire>

    // Parent might be sleeping in wait().
    wakeup1(proc->parent);
8010473d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104743:	8b 40 14             	mov    0x14(%eax),%eax
80104746:	89 04 24             	mov    %eax,(%esp)
80104749:	e8 d9 05 00 00       	call   80104d27 <wakeup1>

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010474e:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
80104755:	eb 3b                	jmp    80104792 <exit+0xf4>
        if(p->parent == proc){
80104757:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010475a:	8b 50 14             	mov    0x14(%eax),%edx
8010475d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104763:	39 c2                	cmp    %eax,%edx
80104765:	75 24                	jne    8010478b <exit+0xed>
            p->parent = initproc;
80104767:	8b 15 68 b6 10 80    	mov    0x8010b668,%edx
8010476d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104770:	89 50 14             	mov    %edx,0x14(%eax)
            if(p->state == ZOMBIE)
80104773:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104776:	8b 40 0c             	mov    0xc(%eax),%eax
80104779:	83 f8 05             	cmp    $0x5,%eax
8010477c:	75 0d                	jne    8010478b <exit+0xed>
                wakeup1(initproc);
8010477e:	a1 68 b6 10 80       	mov    0x8010b668,%eax
80104783:	89 04 24             	mov    %eax,(%esp)
80104786:	e8 9c 05 00 00       	call   80104d27 <wakeup1>

    // Parent might be sleeping in wait().
    wakeup1(proc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010478b:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
80104792:	81 7d f4 74 21 11 80 	cmpl   $0x80112174,-0xc(%ebp)
80104799:	72 bc                	jb     80104757 <exit+0xb9>
                wakeup1(initproc);
        }
    }

    // Jump into the scheduler, never to return.
    proc->state = ZOMBIE;
8010479b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047a1:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
    sched();
801047a8:	e8 fb 02 00 00       	call   80104aa8 <sched>
    panic("zombie exit");
801047ad:	c7 04 24 c0 89 10 80 	movl   $0x801089c0,(%esp)
801047b4:	e8 81 bd ff ff       	call   8010053a <panic>

801047b9 <texit>:
}
    void
texit(void)
{
801047b9:	55                   	push   %ebp
801047ba:	89 e5                	mov    %esp,%ebp
801047bc:	83 ec 28             	sub    $0x28,%esp
    //  struct proc *p;
    int fd;

    if(proc == initproc)
801047bf:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801047c6:	a1 68 b6 10 80       	mov    0x8010b668,%eax
801047cb:	39 c2                	cmp    %eax,%edx
801047cd:	75 0c                	jne    801047db <texit+0x22>
        panic("init exiting");
801047cf:	c7 04 24 b3 89 10 80 	movl   $0x801089b3,(%esp)
801047d6:	e8 5f bd ff ff       	call   8010053a <panic>

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
801047db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801047e2:	eb 44                	jmp    80104828 <texit+0x6f>
        if(proc->ofile[fd]){
801047e4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
801047ed:	83 c2 08             	add    $0x8,%edx
801047f0:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801047f4:	85 c0                	test   %eax,%eax
801047f6:	74 2c                	je     80104824 <texit+0x6b>
            fileclose(proc->ofile[fd]);
801047f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104801:	83 c2 08             	add    $0x8,%edx
80104804:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104808:	89 04 24             	mov    %eax,(%esp)
8010480b:	e8 b8 c7 ff ff       	call   80100fc8 <fileclose>
            proc->ofile[fd] = 0;
80104810:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104816:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104819:	83 c2 08             	add    $0x8,%edx
8010481c:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104823:	00 

    if(proc == initproc)
        panic("init exiting");

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
80104824:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104828:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010482c:	7e b6                	jle    801047e4 <texit+0x2b>
        if(proc->ofile[fd]){
            fileclose(proc->ofile[fd]);
            proc->ofile[fd] = 0;
        }
    }
    iput(proc->cwd);
8010482e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104834:	8b 40 68             	mov    0x68(%eax),%eax
80104837:	89 04 24             	mov    %eax,(%esp)
8010483a:	e8 ca d1 ff ff       	call   80101a09 <iput>
    proc->cwd = 0;
8010483f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104845:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

    acquire(&ptable.lock);
8010484c:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104853:	e8 a7 07 00 00       	call   80104fff <acquire>
    // Parent might be sleeping in wait().
    wakeup1(proc->parent);
80104858:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010485e:	8b 40 14             	mov    0x14(%eax),%eax
80104861:	89 04 24             	mov    %eax,(%esp)
80104864:	e8 be 04 00 00       	call   80104d27 <wakeup1>
    release(&ptable.lock);
80104869:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104870:	e8 ec 07 00 00       	call   80105061 <release>

    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104875:	c7 45 f0 74 ff 10 80 	movl   $0x8010ff74,-0x10(%ebp)
8010487c:	eb 3c                	jmp    801048ba <texit+0x101>
      if(p->isthread == 1 && p->state == SLEEPING && p->isYielding == 1){
8010487e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104881:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80104887:	83 f8 01             	cmp    $0x1,%eax
8010488a:	75 27                	jne    801048b3 <texit+0xfa>
8010488c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010488f:	8b 40 0c             	mov    0xc(%eax),%eax
80104892:	83 f8 02             	cmp    $0x2,%eax
80104895:	75 1c                	jne    801048b3 <texit+0xfa>
80104897:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010489a:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
801048a0:	83 f8 01             	cmp    $0x1,%eax
801048a3:	75 0e                	jne    801048b3 <texit+0xfa>
        twakeup(p->pid);
801048a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801048a8:	8b 40 10             	mov    0x10(%eax),%eax
801048ab:	89 04 24             	mov    %eax,(%esp)
801048ae:	e8 b5 04 00 00       	call   80104d68 <twakeup>
    // Parent might be sleeping in wait().
    wakeup1(proc->parent);
    release(&ptable.lock);

    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048b3:	81 45 f0 88 00 00 00 	addl   $0x88,-0x10(%ebp)
801048ba:	81 7d f0 74 21 11 80 	cmpl   $0x80112174,-0x10(%ebp)
801048c1:	72 bb                	jb     8010487e <texit+0xc5>
      if(p->isthread == 1 && p->state == SLEEPING && p->isYielding == 1){
        twakeup(p->pid);
      }
    }
    acquire(&ptable.lock);
801048c3:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801048ca:	e8 30 07 00 00       	call   80104fff <acquire>
    //      if(p->state == ZOMBIE)
    //        wakeup1(initproc);
    //    }
    //  }
    // Jump into the scheduler, never to return.
    proc->state = ZOMBIE;
801048cf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048d5:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
    sched();
801048dc:	e8 c7 01 00 00       	call   80104aa8 <sched>
    panic("zombie exit");
801048e1:	c7 04 24 c0 89 10 80 	movl   $0x801089c0,(%esp)
801048e8:	e8 4d bc ff ff       	call   8010053a <panic>

801048ed <wait>:
}
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
    int
wait(void)
{
801048ed:	55                   	push   %ebp
801048ee:	89 e5                	mov    %esp,%ebp
801048f0:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    int havekids, pid;

    acquire(&ptable.lock);
801048f3:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801048fa:	e8 00 07 00 00       	call   80104fff <acquire>
    for(;;){
        // Scan through table looking for zombie children.
        havekids = 0;
801048ff:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104906:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
8010490d:	e9 ab 00 00 00       	jmp    801049bd <wait+0xd0>
        //    if(p->parent != proc && p->isthread ==1)
            if(p->parent != proc) 
80104912:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104915:	8b 50 14             	mov    0x14(%eax),%edx
80104918:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010491e:	39 c2                	cmp    %eax,%edx
80104920:	74 05                	je     80104927 <wait+0x3a>
                continue;
80104922:	e9 8f 00 00 00       	jmp    801049b6 <wait+0xc9>
            havekids = 1;
80104927:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
            if(p->state == ZOMBIE){
8010492e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104931:	8b 40 0c             	mov    0xc(%eax),%eax
80104934:	83 f8 05             	cmp    $0x5,%eax
80104937:	75 7d                	jne    801049b6 <wait+0xc9>
                // Found one.
                pid = p->pid;
80104939:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010493c:	8b 40 10             	mov    0x10(%eax),%eax
8010493f:	89 45 ec             	mov    %eax,-0x14(%ebp)
                kfree(p->kstack);
80104942:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104945:	8b 40 08             	mov    0x8(%eax),%eax
80104948:	89 04 24             	mov    %eax,(%esp)
8010494b:	e8 fa e0 ff ff       	call   80102a4a <kfree>
                p->kstack = 0;
80104950:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104953:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
                if(p->isthread != 1){
8010495a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010495d:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80104963:	83 f8 01             	cmp    $0x1,%eax
80104966:	74 0e                	je     80104976 <wait+0x89>
                    freevm(p->pgdir);
80104968:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010496b:	8b 40 04             	mov    0x4(%eax),%eax
8010496e:	89 04 24             	mov    %eax,(%esp)
80104971:	e8 2f 3a 00 00       	call   801083a5 <freevm>
                }
                p->state = UNUSED;
80104976:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104979:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
                p->pid = 0;
80104980:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104983:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
                p->parent = 0;
8010498a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010498d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
                p->name[0] = 0;
80104994:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104997:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
                p->killed = 0;
8010499b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010499e:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
                release(&ptable.lock);
801049a5:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801049ac:	e8 b0 06 00 00       	call   80105061 <release>
                return pid;
801049b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801049b4:	eb 55                	jmp    80104a0b <wait+0x11e>

    acquire(&ptable.lock);
    for(;;){
        // Scan through table looking for zombie children.
        havekids = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049b6:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
801049bd:	81 7d f4 74 21 11 80 	cmpl   $0x80112174,-0xc(%ebp)
801049c4:	0f 82 48 ff ff ff    	jb     80104912 <wait+0x25>
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || proc->killed){
801049ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801049ce:	74 0d                	je     801049dd <wait+0xf0>
801049d0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049d6:	8b 40 24             	mov    0x24(%eax),%eax
801049d9:	85 c0                	test   %eax,%eax
801049db:	74 13                	je     801049f0 <wait+0x103>
            release(&ptable.lock);
801049dd:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801049e4:	e8 78 06 00 00       	call   80105061 <release>
            return -1;
801049e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049ee:	eb 1b                	jmp    80104a0b <wait+0x11e>
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(proc, &ptable.lock);  //DOC: wait-sleep
801049f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049f6:	c7 44 24 04 40 ff 10 	movl   $0x8010ff40,0x4(%esp)
801049fd:	80 
801049fe:	89 04 24             	mov    %eax,(%esp)
80104a01:	e8 86 02 00 00       	call   80104c8c <sleep>
    }
80104a06:	e9 f4 fe ff ff       	jmp    801048ff <wait+0x12>
}
80104a0b:	c9                   	leave  
80104a0c:	c3                   	ret    

80104a0d <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
    void
scheduler(void)
{
80104a0d:	55                   	push   %ebp
80104a0e:	89 e5                	mov    %esp,%ebp
80104a10:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;

    for(;;){
        // Enable interrupts on this processor.
        sti();
80104a13:	e8 88 f5 ff ff       	call   80103fa0 <sti>

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
80104a18:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104a1f:	e8 db 05 00 00       	call   80104fff <acquire>
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a24:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
80104a2b:	eb 61                	jmp    80104a8e <scheduler+0x81>
            if(p->state != RUNNABLE)
80104a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a30:	8b 40 0c             	mov    0xc(%eax),%eax
80104a33:	83 f8 03             	cmp    $0x3,%eax
80104a36:	74 02                	je     80104a3a <scheduler+0x2d>
                continue;
80104a38:	eb 4d                	jmp    80104a87 <scheduler+0x7a>

            // Switch to chosen process.  It is the process's job
            // to release ptable.lock and then reacquire it
            // before jumping back to us.
            proc = p;
80104a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a3d:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
            switchuvm(p);
80104a43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a46:	89 04 24             	mov    %eax,(%esp)
80104a49:	e8 e4 34 00 00       	call   80107f32 <switchuvm>
            p->state = RUNNING;
80104a4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a51:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
            swtch(&cpu->scheduler, proc->context);
80104a58:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a5e:	8b 40 1c             	mov    0x1c(%eax),%eax
80104a61:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104a68:	83 c2 04             	add    $0x4,%edx
80104a6b:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a6f:	89 14 24             	mov    %edx,(%esp)
80104a72:	e8 71 0a 00 00       	call   801054e8 <swtch>
            switchkvm();
80104a77:	e8 99 34 00 00       	call   80107f15 <switchkvm>

            // Process is done running for now.
            // It should have changed its p->state before coming back.
            proc = 0;
80104a7c:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104a83:	00 00 00 00 
        // Enable interrupts on this processor.
        sti();

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a87:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
80104a8e:	81 7d f4 74 21 11 80 	cmpl   $0x80112174,-0xc(%ebp)
80104a95:	72 96                	jb     80104a2d <scheduler+0x20>

            // Process is done running for now.
            // It should have changed its p->state before coming back.
            proc = 0;
        }
        release(&ptable.lock);
80104a97:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104a9e:	e8 be 05 00 00       	call   80105061 <release>

    }
80104aa3:	e9 6b ff ff ff       	jmp    80104a13 <scheduler+0x6>

80104aa8 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
    void
sched(void)
{
80104aa8:	55                   	push   %ebp
80104aa9:	89 e5                	mov    %esp,%ebp
80104aab:	83 ec 28             	sub    $0x28,%esp
    int intena;

    if(!holding(&ptable.lock))
80104aae:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104ab5:	e8 6f 06 00 00       	call   80105129 <holding>
80104aba:	85 c0                	test   %eax,%eax
80104abc:	75 0c                	jne    80104aca <sched+0x22>
        panic("sched ptable.lock");
80104abe:	c7 04 24 cc 89 10 80 	movl   $0x801089cc,(%esp)
80104ac5:	e8 70 ba ff ff       	call   8010053a <panic>
    if(cpu->ncli != 1){
80104aca:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ad0:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104ad6:	83 f8 01             	cmp    $0x1,%eax
80104ad9:	74 35                	je     80104b10 <sched+0x68>
        cprintf("current proc %d\n cpu->ncli %d\n",proc->pid,cpu->ncli);
80104adb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ae1:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104ae7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aed:	8b 40 10             	mov    0x10(%eax),%eax
80104af0:	89 54 24 08          	mov    %edx,0x8(%esp)
80104af4:	89 44 24 04          	mov    %eax,0x4(%esp)
80104af8:	c7 04 24 e0 89 10 80 	movl   $0x801089e0,(%esp)
80104aff:	e8 9c b8 ff ff       	call   801003a0 <cprintf>
        panic("sched locks");
80104b04:	c7 04 24 ff 89 10 80 	movl   $0x801089ff,(%esp)
80104b0b:	e8 2a ba ff ff       	call   8010053a <panic>
    }
    if(proc->state == RUNNING)
80104b10:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b16:	8b 40 0c             	mov    0xc(%eax),%eax
80104b19:	83 f8 04             	cmp    $0x4,%eax
80104b1c:	75 0c                	jne    80104b2a <sched+0x82>
        panic("sched running");
80104b1e:	c7 04 24 0b 8a 10 80 	movl   $0x80108a0b,(%esp)
80104b25:	e8 10 ba ff ff       	call   8010053a <panic>
    if(readeflags()&FL_IF)
80104b2a:	e8 61 f4 ff ff       	call   80103f90 <readeflags>
80104b2f:	25 00 02 00 00       	and    $0x200,%eax
80104b34:	85 c0                	test   %eax,%eax
80104b36:	74 0c                	je     80104b44 <sched+0x9c>
        panic("sched interruptible");
80104b38:	c7 04 24 19 8a 10 80 	movl   $0x80108a19,(%esp)
80104b3f:	e8 f6 b9 ff ff       	call   8010053a <panic>
    intena = cpu->intena;
80104b44:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b4a:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104b50:	89 45 f4             	mov    %eax,-0xc(%ebp)
    swtch(&proc->context, cpu->scheduler);
80104b53:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b59:	8b 40 04             	mov    0x4(%eax),%eax
80104b5c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104b63:	83 c2 1c             	add    $0x1c,%edx
80104b66:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b6a:	89 14 24             	mov    %edx,(%esp)
80104b6d:	e8 76 09 00 00       	call   801054e8 <swtch>
    cpu->intena = intena;
80104b72:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b78:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b7b:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104b81:	c9                   	leave  
80104b82:	c3                   	ret    

80104b83 <yield>:

// Give up the CPU for one scheduling round.
    void
yield(void)
{
80104b83:	55                   	push   %ebp
80104b84:	89 e5                	mov    %esp,%ebp
80104b86:	83 ec 18             	sub    $0x18,%esp
    acquire(&ptable.lock);  //DOC: yieldlock
80104b89:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104b90:	e8 6a 04 00 00       	call   80104fff <acquire>
    proc->state = RUNNABLE;
80104b95:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b9b:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
    sched();
80104ba2:	e8 01 ff ff ff       	call   80104aa8 <sched>
    release(&ptable.lock);
80104ba7:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104bae:	e8 ae 04 00 00       	call   80105061 <release>
}
80104bb3:	c9                   	leave  
80104bb4:	c3                   	ret    

80104bb5 <thread_yield>:

void thread_yield(void){
80104bb5:	55                   	push   %ebp
80104bb6:	89 e5                	mov    %esp,%ebp
80104bb8:	83 ec 28             	sub    $0x28,%esp
  int i = 0;
80104bbb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bc2:	c7 45 f0 74 ff 10 80 	movl   $0x8010ff74,-0x10(%ebp)
80104bc9:	eb 5f                	jmp    80104c2a <thread_yield+0x75>
    if(p->isthread == 1 && p->state != SLEEPING){
80104bcb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104bce:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80104bd4:	83 f8 01             	cmp    $0x1,%eax
80104bd7:	75 11                	jne    80104bea <thread_yield+0x35>
80104bd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104bdc:	8b 40 0c             	mov    0xc(%eax),%eax
80104bdf:	83 f8 02             	cmp    $0x2,%eax
80104be2:	74 06                	je     80104bea <thread_yield+0x35>
      i++;
80104be4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104be8:	eb 39                	jmp    80104c23 <thread_yield+0x6e>
    }
    else if(p->isthread == 1 && p->state != SLEEPING && p->isYielding == 1){
80104bea:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104bed:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80104bf3:	83 f8 01             	cmp    $0x1,%eax
80104bf6:	75 2b                	jne    80104c23 <thread_yield+0x6e>
80104bf8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104bfb:	8b 40 0c             	mov    0xc(%eax),%eax
80104bfe:	83 f8 02             	cmp    $0x2,%eax
80104c01:	74 20                	je     80104c23 <thread_yield+0x6e>
80104c03:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c06:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80104c0c:	83 f8 01             	cmp    $0x1,%eax
80104c0f:	75 12                	jne    80104c23 <thread_yield+0x6e>
      twakeup(p->pid);
80104c11:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c14:	8b 40 10             	mov    0x10(%eax),%eax
80104c17:	89 04 24             	mov    %eax,(%esp)
80104c1a:	e8 49 01 00 00       	call   80104d68 <twakeup>
      i++;
80104c1f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
}

void thread_yield(void){
  int i = 0;
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c23:	81 45 f0 88 00 00 00 	addl   $0x88,-0x10(%ebp)
80104c2a:	81 7d f0 74 21 11 80 	cmpl   $0x80112174,-0x10(%ebp)
80104c31:	72 98                	jb     80104bcb <thread_yield+0x16>
    else if(p->isthread == 1 && p->state != SLEEPING && p->isYielding == 1){
      twakeup(p->pid);
      i++;
    }
  }
  if(i > 0){
80104c33:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104c37:	7e 25                	jle    80104c5e <thread_yield+0xa9>
    proc->isYielding = 1;
80104c39:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c3f:	c7 80 84 00 00 00 01 	movl   $0x1,0x84(%eax)
80104c46:	00 00 00 
    tsleep();
80104c49:	e8 22 03 00 00       	call   80104f70 <tsleep>
    proc->isYielding = 0;
80104c4e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c54:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%eax)
80104c5b:	00 00 00 
  }
}
80104c5e:	c9                   	leave  
80104c5f:	c3                   	ret    

80104c60 <forkret>:
// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
    void
forkret(void)
{
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp
80104c63:	83 ec 18             	sub    $0x18,%esp
    static int first = 1;
    // Still holding ptable.lock from scheduler.
    release(&ptable.lock);
80104c66:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104c6d:	e8 ef 03 00 00       	call   80105061 <release>

    if (first) {
80104c72:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104c77:	85 c0                	test   %eax,%eax
80104c79:	74 0f                	je     80104c8a <forkret+0x2a>
        // Some initialization functions must be run in the context
        // of a regular process (e.g., they call sleep), and thus cannot 
        // be run from main().
        first = 0;
80104c7b:	c7 05 08 b0 10 80 00 	movl   $0x0,0x8010b008
80104c82:	00 00 00 
        initlog();
80104c85:	e8 4e e3 ff ff       	call   80102fd8 <initlog>
    }

    // Return to "caller", actually trapret (see allocproc).
}
80104c8a:	c9                   	leave  
80104c8b:	c3                   	ret    

80104c8c <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
    void
sleep(void *chan, struct spinlock *lk)
{
80104c8c:	55                   	push   %ebp
80104c8d:	89 e5                	mov    %esp,%ebp
80104c8f:	83 ec 18             	sub    $0x18,%esp
    if(proc == 0)
80104c92:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c98:	85 c0                	test   %eax,%eax
80104c9a:	75 0c                	jne    80104ca8 <sleep+0x1c>
        panic("sleep");
80104c9c:	c7 04 24 2d 8a 10 80 	movl   $0x80108a2d,(%esp)
80104ca3:	e8 92 b8 ff ff       	call   8010053a <panic>

    if(lk == 0)
80104ca8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104cac:	75 0c                	jne    80104cba <sleep+0x2e>
        panic("sleep without lk");
80104cae:	c7 04 24 33 8a 10 80 	movl   $0x80108a33,(%esp)
80104cb5:	e8 80 b8 ff ff       	call   8010053a <panic>
    // change p->state and then call sched.
    // Once we hold ptable.lock, we can be
    // guaranteed that we won't miss any wakeup
    // (wakeup runs with ptable.lock locked),
    // so it's okay to release lk.
    if(lk != &ptable.lock){  //DOC: sleeplock0
80104cba:	81 7d 0c 40 ff 10 80 	cmpl   $0x8010ff40,0xc(%ebp)
80104cc1:	74 17                	je     80104cda <sleep+0x4e>
        acquire(&ptable.lock);  //DOC: sleeplock1
80104cc3:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104cca:	e8 30 03 00 00       	call   80104fff <acquire>
        release(lk);
80104ccf:	8b 45 0c             	mov    0xc(%ebp),%eax
80104cd2:	89 04 24             	mov    %eax,(%esp)
80104cd5:	e8 87 03 00 00       	call   80105061 <release>
    }

    // Go to sleep.
    proc->chan = chan;
80104cda:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ce0:	8b 55 08             	mov    0x8(%ebp),%edx
80104ce3:	89 50 20             	mov    %edx,0x20(%eax)
    proc->state = SLEEPING;
80104ce6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cec:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
    sched();
80104cf3:	e8 b0 fd ff ff       	call   80104aa8 <sched>

    // Tidy up.
    proc->chan = 0;
80104cf8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cfe:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

    // Reacquire original lock.
    if(lk != &ptable.lock){  //DOC: sleeplock2
80104d05:	81 7d 0c 40 ff 10 80 	cmpl   $0x8010ff40,0xc(%ebp)
80104d0c:	74 17                	je     80104d25 <sleep+0x99>
        release(&ptable.lock);
80104d0e:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104d15:	e8 47 03 00 00       	call   80105061 <release>
        acquire(lk);
80104d1a:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d1d:	89 04 24             	mov    %eax,(%esp)
80104d20:	e8 da 02 00 00       	call   80104fff <acquire>
    }
}
80104d25:	c9                   	leave  
80104d26:	c3                   	ret    

80104d27 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
    static void
wakeup1(void *chan)
{
80104d27:	55                   	push   %ebp
80104d28:	89 e5                	mov    %esp,%ebp
80104d2a:	83 ec 10             	sub    $0x10,%esp
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d2d:	c7 45 fc 74 ff 10 80 	movl   $0x8010ff74,-0x4(%ebp)
80104d34:	eb 27                	jmp    80104d5d <wakeup1+0x36>
        if(p->state == SLEEPING && p->chan == chan)
80104d36:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d39:	8b 40 0c             	mov    0xc(%eax),%eax
80104d3c:	83 f8 02             	cmp    $0x2,%eax
80104d3f:	75 15                	jne    80104d56 <wakeup1+0x2f>
80104d41:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d44:	8b 40 20             	mov    0x20(%eax),%eax
80104d47:	3b 45 08             	cmp    0x8(%ebp),%eax
80104d4a:	75 0a                	jne    80104d56 <wakeup1+0x2f>
            p->state = RUNNABLE;
80104d4c:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d4f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
    static void
wakeup1(void *chan)
{
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d56:	81 45 fc 88 00 00 00 	addl   $0x88,-0x4(%ebp)
80104d5d:	81 7d fc 74 21 11 80 	cmpl   $0x80112174,-0x4(%ebp)
80104d64:	72 d0                	jb     80104d36 <wakeup1+0xf>
        if(p->state == SLEEPING && p->chan == chan)
            p->state = RUNNABLE;
}
80104d66:	c9                   	leave  
80104d67:	c3                   	ret    

80104d68 <twakeup>:

void 
twakeup(int tid){
80104d68:	55                   	push   %ebp
80104d69:	89 e5                	mov    %esp,%ebp
80104d6b:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    acquire(&ptable.lock);
80104d6e:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104d75:	e8 85 02 00 00       	call   80104fff <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d7a:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
80104d81:	eb 36                	jmp    80104db9 <twakeup+0x51>
        if(p->state == SLEEPING && p->pid == tid && p->isthread == 1){
80104d83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d86:	8b 40 0c             	mov    0xc(%eax),%eax
80104d89:	83 f8 02             	cmp    $0x2,%eax
80104d8c:	75 24                	jne    80104db2 <twakeup+0x4a>
80104d8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d91:	8b 40 10             	mov    0x10(%eax),%eax
80104d94:	3b 45 08             	cmp    0x8(%ebp),%eax
80104d97:	75 19                	jne    80104db2 <twakeup+0x4a>
80104d99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d9c:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80104da2:	83 f8 01             	cmp    $0x1,%eax
80104da5:	75 0b                	jne    80104db2 <twakeup+0x4a>
            wakeup1(p);
80104da7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104daa:	89 04 24             	mov    %eax,(%esp)
80104dad:	e8 75 ff ff ff       	call   80104d27 <wakeup1>

void 
twakeup(int tid){
    struct proc *p;
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104db2:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
80104db9:	81 7d f4 74 21 11 80 	cmpl   $0x80112174,-0xc(%ebp)
80104dc0:	72 c1                	jb     80104d83 <twakeup+0x1b>
        if(p->state == SLEEPING && p->pid == tid && p->isthread == 1){
            wakeup1(p);
        }
    }
    release(&ptable.lock);
80104dc2:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104dc9:	e8 93 02 00 00       	call   80105061 <release>
}
80104dce:	c9                   	leave  
80104dcf:	c3                   	ret    

80104dd0 <wakeup>:

// Wake up all processes sleeping on chan.
    void
wakeup(void *chan)
{
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	83 ec 18             	sub    $0x18,%esp
    acquire(&ptable.lock);
80104dd6:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104ddd:	e8 1d 02 00 00       	call   80104fff <acquire>
    wakeup1(chan);
80104de2:	8b 45 08             	mov    0x8(%ebp),%eax
80104de5:	89 04 24             	mov    %eax,(%esp)
80104de8:	e8 3a ff ff ff       	call   80104d27 <wakeup1>
    release(&ptable.lock);
80104ded:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104df4:	e8 68 02 00 00       	call   80105061 <release>
}
80104df9:	c9                   	leave  
80104dfa:	c3                   	ret    

80104dfb <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
    int
kill(int pid)
{
80104dfb:	55                   	push   %ebp
80104dfc:	89 e5                	mov    %esp,%ebp
80104dfe:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;

    acquire(&ptable.lock);
80104e01:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104e08:	e8 f2 01 00 00       	call   80104fff <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e0d:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
80104e14:	eb 44                	jmp    80104e5a <kill+0x5f>
        if(p->pid == pid){
80104e16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e19:	8b 40 10             	mov    0x10(%eax),%eax
80104e1c:	3b 45 08             	cmp    0x8(%ebp),%eax
80104e1f:	75 32                	jne    80104e53 <kill+0x58>
            p->killed = 1;
80104e21:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e24:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            // Wake process from sleep if necessary.
            if(p->state == SLEEPING)
80104e2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e2e:	8b 40 0c             	mov    0xc(%eax),%eax
80104e31:	83 f8 02             	cmp    $0x2,%eax
80104e34:	75 0a                	jne    80104e40 <kill+0x45>
                p->state = RUNNABLE;
80104e36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e39:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
            release(&ptable.lock);
80104e40:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104e47:	e8 15 02 00 00       	call   80105061 <release>
            return 0;
80104e4c:	b8 00 00 00 00       	mov    $0x0,%eax
80104e51:	eb 21                	jmp    80104e74 <kill+0x79>
kill(int pid)
{
    struct proc *p;

    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e53:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
80104e5a:	81 7d f4 74 21 11 80 	cmpl   $0x80112174,-0xc(%ebp)
80104e61:	72 b3                	jb     80104e16 <kill+0x1b>
                p->state = RUNNABLE;
            release(&ptable.lock);
            return 0;
        }
    }
    release(&ptable.lock);
80104e63:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104e6a:	e8 f2 01 00 00       	call   80105061 <release>
    return -1;
80104e6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e74:	c9                   	leave  
80104e75:	c3                   	ret    

80104e76 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
    void
procdump(void)
{
80104e76:	55                   	push   %ebp
80104e77:	89 e5                	mov    %esp,%ebp
80104e79:	83 ec 58             	sub    $0x58,%esp
    int i;
    struct proc *p;
    char *state;
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e7c:	c7 45 f0 74 ff 10 80 	movl   $0x8010ff74,-0x10(%ebp)
80104e83:	e9 d9 00 00 00       	jmp    80104f61 <procdump+0xeb>
        if(p->state == UNUSED)
80104e88:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e8b:	8b 40 0c             	mov    0xc(%eax),%eax
80104e8e:	85 c0                	test   %eax,%eax
80104e90:	75 05                	jne    80104e97 <procdump+0x21>
            continue;
80104e92:	e9 c3 00 00 00       	jmp    80104f5a <procdump+0xe4>
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104e97:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e9a:	8b 40 0c             	mov    0xc(%eax),%eax
80104e9d:	83 f8 05             	cmp    $0x5,%eax
80104ea0:	77 23                	ja     80104ec5 <procdump+0x4f>
80104ea2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ea5:	8b 40 0c             	mov    0xc(%eax),%eax
80104ea8:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104eaf:	85 c0                	test   %eax,%eax
80104eb1:	74 12                	je     80104ec5 <procdump+0x4f>
            state = states[p->state];
80104eb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104eb6:	8b 40 0c             	mov    0xc(%eax),%eax
80104eb9:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104ec0:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104ec3:	eb 07                	jmp    80104ecc <procdump+0x56>
        else
            state = "???";
80104ec5:	c7 45 ec 44 8a 10 80 	movl   $0x80108a44,-0x14(%ebp)
        cprintf("%d %s %s", p->pid, state, p->name);
80104ecc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ecf:	8d 50 6c             	lea    0x6c(%eax),%edx
80104ed2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ed5:	8b 40 10             	mov    0x10(%eax),%eax
80104ed8:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104edc:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104edf:	89 54 24 08          	mov    %edx,0x8(%esp)
80104ee3:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ee7:	c7 04 24 48 8a 10 80 	movl   $0x80108a48,(%esp)
80104eee:	e8 ad b4 ff ff       	call   801003a0 <cprintf>
        if(p->state == SLEEPING){
80104ef3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ef6:	8b 40 0c             	mov    0xc(%eax),%eax
80104ef9:	83 f8 02             	cmp    $0x2,%eax
80104efc:	75 50                	jne    80104f4e <procdump+0xd8>
            getcallerpcs((uint*)p->context->ebp+2, pc);
80104efe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f01:	8b 40 1c             	mov    0x1c(%eax),%eax
80104f04:	8b 40 0c             	mov    0xc(%eax),%eax
80104f07:	83 c0 08             	add    $0x8,%eax
80104f0a:	8d 55 c4             	lea    -0x3c(%ebp),%edx
80104f0d:	89 54 24 04          	mov    %edx,0x4(%esp)
80104f11:	89 04 24             	mov    %eax,(%esp)
80104f14:	e8 97 01 00 00       	call   801050b0 <getcallerpcs>
            for(i=0; i<10 && pc[i] != 0; i++)
80104f19:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104f20:	eb 1b                	jmp    80104f3d <procdump+0xc7>
                cprintf(" %p", pc[i]);
80104f22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f25:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104f29:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f2d:	c7 04 24 51 8a 10 80 	movl   $0x80108a51,(%esp)
80104f34:	e8 67 b4 ff ff       	call   801003a0 <cprintf>
        else
            state = "???";
        cprintf("%d %s %s", p->pid, state, p->name);
        if(p->state == SLEEPING){
            getcallerpcs((uint*)p->context->ebp+2, pc);
            for(i=0; i<10 && pc[i] != 0; i++)
80104f39:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104f3d:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104f41:	7f 0b                	jg     80104f4e <procdump+0xd8>
80104f43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f46:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104f4a:	85 c0                	test   %eax,%eax
80104f4c:	75 d4                	jne    80104f22 <procdump+0xac>
                cprintf(" %p", pc[i]);
        }
        cprintf("\n");
80104f4e:	c7 04 24 55 8a 10 80 	movl   $0x80108a55,(%esp)
80104f55:	e8 46 b4 ff ff       	call   801003a0 <cprintf>
    int i;
    struct proc *p;
    char *state;
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f5a:	81 45 f0 88 00 00 00 	addl   $0x88,-0x10(%ebp)
80104f61:	81 7d f0 74 21 11 80 	cmpl   $0x80112174,-0x10(%ebp)
80104f68:	0f 82 1a ff ff ff    	jb     80104e88 <procdump+0x12>
            for(i=0; i<10 && pc[i] != 0; i++)
                cprintf(" %p", pc[i]);
        }
        cprintf("\n");
    }
}
80104f6e:	c9                   	leave  
80104f6f:	c3                   	ret    

80104f70 <tsleep>:

void tsleep(void){
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	83 ec 18             	sub    $0x18,%esp
    
    acquire(&ptable.lock); 
80104f76:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104f7d:	e8 7d 00 00 00       	call   80104fff <acquire>
    sleep(proc, &ptable.lock);
80104f82:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f88:	c7 44 24 04 40 ff 10 	movl   $0x8010ff40,0x4(%esp)
80104f8f:	80 
80104f90:	89 04 24             	mov    %eax,(%esp)
80104f93:	e8 f4 fc ff ff       	call   80104c8c <sleep>
    release(&ptable.lock);
80104f98:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104f9f:	e8 bd 00 00 00       	call   80105061 <release>

}
80104fa4:	c9                   	leave  
80104fa5:	c3                   	ret    
	...

80104fa8 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104fa8:	55                   	push   %ebp
80104fa9:	89 e5                	mov    %esp,%ebp
80104fab:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104fae:	9c                   	pushf  
80104faf:	58                   	pop    %eax
80104fb0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104fb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104fb6:	c9                   	leave  
80104fb7:	c3                   	ret    

80104fb8 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104fb8:	55                   	push   %ebp
80104fb9:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104fbb:	fa                   	cli    
}
80104fbc:	5d                   	pop    %ebp
80104fbd:	c3                   	ret    

80104fbe <sti>:

static inline void
sti(void)
{
80104fbe:	55                   	push   %ebp
80104fbf:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104fc1:	fb                   	sti    
}
80104fc2:	5d                   	pop    %ebp
80104fc3:	c3                   	ret    

80104fc4 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104fc4:	55                   	push   %ebp
80104fc5:	89 e5                	mov    %esp,%ebp
80104fc7:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104fca:	8b 55 08             	mov    0x8(%ebp),%edx
80104fcd:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fd0:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104fd3:	f0 87 02             	lock xchg %eax,(%edx)
80104fd6:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104fd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104fdc:	c9                   	leave  
80104fdd:	c3                   	ret    

80104fde <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104fde:	55                   	push   %ebp
80104fdf:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104fe1:	8b 45 08             	mov    0x8(%ebp),%eax
80104fe4:	8b 55 0c             	mov    0xc(%ebp),%edx
80104fe7:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104fea:	8b 45 08             	mov    0x8(%ebp),%eax
80104fed:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104ff3:	8b 45 08             	mov    0x8(%ebp),%eax
80104ff6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104ffd:	5d                   	pop    %ebp
80104ffe:	c3                   	ret    

80104fff <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104fff:	55                   	push   %ebp
80105000:	89 e5                	mov    %esp,%ebp
80105002:	83 ec 18             	sub    $0x18,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105005:	e8 49 01 00 00       	call   80105153 <pushcli>
  if(holding(lk))
8010500a:	8b 45 08             	mov    0x8(%ebp),%eax
8010500d:	89 04 24             	mov    %eax,(%esp)
80105010:	e8 14 01 00 00       	call   80105129 <holding>
80105015:	85 c0                	test   %eax,%eax
80105017:	74 0c                	je     80105025 <acquire+0x26>
    panic("acquire");
80105019:	c7 04 24 81 8a 10 80 	movl   $0x80108a81,(%esp)
80105020:	e8 15 b5 ff ff       	call   8010053a <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80105025:	90                   	nop
80105026:	8b 45 08             	mov    0x8(%ebp),%eax
80105029:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80105030:	00 
80105031:	89 04 24             	mov    %eax,(%esp)
80105034:	e8 8b ff ff ff       	call   80104fc4 <xchg>
80105039:	85 c0                	test   %eax,%eax
8010503b:	75 e9                	jne    80105026 <acquire+0x27>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
8010503d:	8b 45 08             	mov    0x8(%ebp),%eax
80105040:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105047:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
8010504a:	8b 45 08             	mov    0x8(%ebp),%eax
8010504d:	83 c0 0c             	add    $0xc,%eax
80105050:	89 44 24 04          	mov    %eax,0x4(%esp)
80105054:	8d 45 08             	lea    0x8(%ebp),%eax
80105057:	89 04 24             	mov    %eax,(%esp)
8010505a:	e8 51 00 00 00       	call   801050b0 <getcallerpcs>
}
8010505f:	c9                   	leave  
80105060:	c3                   	ret    

80105061 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80105061:	55                   	push   %ebp
80105062:	89 e5                	mov    %esp,%ebp
80105064:	83 ec 18             	sub    $0x18,%esp
  if(!holding(lk))
80105067:	8b 45 08             	mov    0x8(%ebp),%eax
8010506a:	89 04 24             	mov    %eax,(%esp)
8010506d:	e8 b7 00 00 00       	call   80105129 <holding>
80105072:	85 c0                	test   %eax,%eax
80105074:	75 0c                	jne    80105082 <release+0x21>
    panic("release");
80105076:	c7 04 24 89 8a 10 80 	movl   $0x80108a89,(%esp)
8010507d:	e8 b8 b4 ff ff       	call   8010053a <panic>

  lk->pcs[0] = 0;
80105082:	8b 45 08             	mov    0x8(%ebp),%eax
80105085:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
8010508c:	8b 45 08             	mov    0x8(%ebp),%eax
8010508f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80105096:	8b 45 08             	mov    0x8(%ebp),%eax
80105099:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801050a0:	00 
801050a1:	89 04 24             	mov    %eax,(%esp)
801050a4:	e8 1b ff ff ff       	call   80104fc4 <xchg>

  popcli();
801050a9:	e8 e9 00 00 00       	call   80105197 <popcli>
}
801050ae:	c9                   	leave  
801050af:	c3                   	ret    

801050b0 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
801050b6:	8b 45 08             	mov    0x8(%ebp),%eax
801050b9:	83 e8 08             	sub    $0x8,%eax
801050bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
801050bf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
801050c6:	eb 38                	jmp    80105100 <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801050c8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
801050cc:	74 38                	je     80105106 <getcallerpcs+0x56>
801050ce:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
801050d5:	76 2f                	jbe    80105106 <getcallerpcs+0x56>
801050d7:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
801050db:	74 29                	je     80105106 <getcallerpcs+0x56>
      break;
    pcs[i] = ebp[1];     // saved %eip
801050dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
801050e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801050e7:	8b 45 0c             	mov    0xc(%ebp),%eax
801050ea:	01 c2                	add    %eax,%edx
801050ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
801050ef:	8b 40 04             	mov    0x4(%eax),%eax
801050f2:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
801050f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
801050f7:	8b 00                	mov    (%eax),%eax
801050f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801050fc:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105100:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105104:	7e c2                	jle    801050c8 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105106:	eb 19                	jmp    80105121 <getcallerpcs+0x71>
    pcs[i] = 0;
80105108:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010510b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105112:	8b 45 0c             	mov    0xc(%ebp),%eax
80105115:	01 d0                	add    %edx,%eax
80105117:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010511d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105121:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105125:	7e e1                	jle    80105108 <getcallerpcs+0x58>
    pcs[i] = 0;
}
80105127:	c9                   	leave  
80105128:	c3                   	ret    

80105129 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105129:	55                   	push   %ebp
8010512a:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
8010512c:	8b 45 08             	mov    0x8(%ebp),%eax
8010512f:	8b 00                	mov    (%eax),%eax
80105131:	85 c0                	test   %eax,%eax
80105133:	74 17                	je     8010514c <holding+0x23>
80105135:	8b 45 08             	mov    0x8(%ebp),%eax
80105138:	8b 50 08             	mov    0x8(%eax),%edx
8010513b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105141:	39 c2                	cmp    %eax,%edx
80105143:	75 07                	jne    8010514c <holding+0x23>
80105145:	b8 01 00 00 00       	mov    $0x1,%eax
8010514a:	eb 05                	jmp    80105151 <holding+0x28>
8010514c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105151:	5d                   	pop    %ebp
80105152:	c3                   	ret    

80105153 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105153:	55                   	push   %ebp
80105154:	89 e5                	mov    %esp,%ebp
80105156:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80105159:	e8 4a fe ff ff       	call   80104fa8 <readeflags>
8010515e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80105161:	e8 52 fe ff ff       	call   80104fb8 <cli>
  if(cpu->ncli++ == 0)
80105166:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010516d:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80105173:	8d 48 01             	lea    0x1(%eax),%ecx
80105176:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
8010517c:	85 c0                	test   %eax,%eax
8010517e:	75 15                	jne    80105195 <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
80105180:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105186:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105189:	81 e2 00 02 00 00    	and    $0x200,%edx
8010518f:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80105195:	c9                   	leave  
80105196:	c3                   	ret    

80105197 <popcli>:

void
popcli(void)
{
80105197:	55                   	push   %ebp
80105198:	89 e5                	mov    %esp,%ebp
8010519a:	83 ec 18             	sub    $0x18,%esp
  if(readeflags()&FL_IF)
8010519d:	e8 06 fe ff ff       	call   80104fa8 <readeflags>
801051a2:	25 00 02 00 00       	and    $0x200,%eax
801051a7:	85 c0                	test   %eax,%eax
801051a9:	74 0c                	je     801051b7 <popcli+0x20>
    panic("popcli - interruptible");
801051ab:	c7 04 24 91 8a 10 80 	movl   $0x80108a91,(%esp)
801051b2:	e8 83 b3 ff ff       	call   8010053a <panic>
  if(--cpu->ncli < 0)
801051b7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801051bd:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801051c3:	83 ea 01             	sub    $0x1,%edx
801051c6:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
801051cc:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801051d2:	85 c0                	test   %eax,%eax
801051d4:	79 0c                	jns    801051e2 <popcli+0x4b>
    panic("popcli");
801051d6:	c7 04 24 a8 8a 10 80 	movl   $0x80108aa8,(%esp)
801051dd:	e8 58 b3 ff ff       	call   8010053a <panic>
  if(cpu->ncli == 0 && cpu->intena)
801051e2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801051e8:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801051ee:	85 c0                	test   %eax,%eax
801051f0:	75 15                	jne    80105207 <popcli+0x70>
801051f2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801051f8:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
801051fe:	85 c0                	test   %eax,%eax
80105200:	74 05                	je     80105207 <popcli+0x70>
    sti();
80105202:	e8 b7 fd ff ff       	call   80104fbe <sti>
}
80105207:	c9                   	leave  
80105208:	c3                   	ret    
80105209:	00 00                	add    %al,(%eax)
	...

8010520c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
8010520c:	55                   	push   %ebp
8010520d:	89 e5                	mov    %esp,%ebp
8010520f:	57                   	push   %edi
80105210:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80105211:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105214:	8b 55 10             	mov    0x10(%ebp),%edx
80105217:	8b 45 0c             	mov    0xc(%ebp),%eax
8010521a:	89 cb                	mov    %ecx,%ebx
8010521c:	89 df                	mov    %ebx,%edi
8010521e:	89 d1                	mov    %edx,%ecx
80105220:	fc                   	cld    
80105221:	f3 aa                	rep stos %al,%es:(%edi)
80105223:	89 ca                	mov    %ecx,%edx
80105225:	89 fb                	mov    %edi,%ebx
80105227:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010522a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
8010522d:	5b                   	pop    %ebx
8010522e:	5f                   	pop    %edi
8010522f:	5d                   	pop    %ebp
80105230:	c3                   	ret    

80105231 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
80105231:	55                   	push   %ebp
80105232:	89 e5                	mov    %esp,%ebp
80105234:	57                   	push   %edi
80105235:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80105236:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105239:	8b 55 10             	mov    0x10(%ebp),%edx
8010523c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010523f:	89 cb                	mov    %ecx,%ebx
80105241:	89 df                	mov    %ebx,%edi
80105243:	89 d1                	mov    %edx,%ecx
80105245:	fc                   	cld    
80105246:	f3 ab                	rep stos %eax,%es:(%edi)
80105248:	89 ca                	mov    %ecx,%edx
8010524a:	89 fb                	mov    %edi,%ebx
8010524c:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010524f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105252:	5b                   	pop    %ebx
80105253:	5f                   	pop    %edi
80105254:	5d                   	pop    %ebp
80105255:	c3                   	ret    

80105256 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105256:	55                   	push   %ebp
80105257:	89 e5                	mov    %esp,%ebp
80105259:	83 ec 0c             	sub    $0xc,%esp
  if ((int)dst%4 == 0 && n%4 == 0){
8010525c:	8b 45 08             	mov    0x8(%ebp),%eax
8010525f:	83 e0 03             	and    $0x3,%eax
80105262:	85 c0                	test   %eax,%eax
80105264:	75 49                	jne    801052af <memset+0x59>
80105266:	8b 45 10             	mov    0x10(%ebp),%eax
80105269:	83 e0 03             	and    $0x3,%eax
8010526c:	85 c0                	test   %eax,%eax
8010526e:	75 3f                	jne    801052af <memset+0x59>
    c &= 0xFF;
80105270:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105277:	8b 45 10             	mov    0x10(%ebp),%eax
8010527a:	c1 e8 02             	shr    $0x2,%eax
8010527d:	89 c2                	mov    %eax,%edx
8010527f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105282:	c1 e0 18             	shl    $0x18,%eax
80105285:	89 c1                	mov    %eax,%ecx
80105287:	8b 45 0c             	mov    0xc(%ebp),%eax
8010528a:	c1 e0 10             	shl    $0x10,%eax
8010528d:	09 c1                	or     %eax,%ecx
8010528f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105292:	c1 e0 08             	shl    $0x8,%eax
80105295:	09 c8                	or     %ecx,%eax
80105297:	0b 45 0c             	or     0xc(%ebp),%eax
8010529a:	89 54 24 08          	mov    %edx,0x8(%esp)
8010529e:	89 44 24 04          	mov    %eax,0x4(%esp)
801052a2:	8b 45 08             	mov    0x8(%ebp),%eax
801052a5:	89 04 24             	mov    %eax,(%esp)
801052a8:	e8 84 ff ff ff       	call   80105231 <stosl>
801052ad:	eb 19                	jmp    801052c8 <memset+0x72>
  } else
    stosb(dst, c, n);
801052af:	8b 45 10             	mov    0x10(%ebp),%eax
801052b2:	89 44 24 08          	mov    %eax,0x8(%esp)
801052b6:	8b 45 0c             	mov    0xc(%ebp),%eax
801052b9:	89 44 24 04          	mov    %eax,0x4(%esp)
801052bd:	8b 45 08             	mov    0x8(%ebp),%eax
801052c0:	89 04 24             	mov    %eax,(%esp)
801052c3:	e8 44 ff ff ff       	call   8010520c <stosb>
  return dst;
801052c8:	8b 45 08             	mov    0x8(%ebp),%eax
}
801052cb:	c9                   	leave  
801052cc:	c3                   	ret    

801052cd <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801052cd:	55                   	push   %ebp
801052ce:	89 e5                	mov    %esp,%ebp
801052d0:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
801052d3:	8b 45 08             	mov    0x8(%ebp),%eax
801052d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
801052d9:	8b 45 0c             	mov    0xc(%ebp),%eax
801052dc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
801052df:	eb 30                	jmp    80105311 <memcmp+0x44>
    if(*s1 != *s2)
801052e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052e4:	0f b6 10             	movzbl (%eax),%edx
801052e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
801052ea:	0f b6 00             	movzbl (%eax),%eax
801052ed:	38 c2                	cmp    %al,%dl
801052ef:	74 18                	je     80105309 <memcmp+0x3c>
      return *s1 - *s2;
801052f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052f4:	0f b6 00             	movzbl (%eax),%eax
801052f7:	0f b6 d0             	movzbl %al,%edx
801052fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
801052fd:	0f b6 00             	movzbl (%eax),%eax
80105300:	0f b6 c0             	movzbl %al,%eax
80105303:	29 c2                	sub    %eax,%edx
80105305:	89 d0                	mov    %edx,%eax
80105307:	eb 1a                	jmp    80105323 <memcmp+0x56>
    s1++, s2++;
80105309:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010530d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105311:	8b 45 10             	mov    0x10(%ebp),%eax
80105314:	8d 50 ff             	lea    -0x1(%eax),%edx
80105317:	89 55 10             	mov    %edx,0x10(%ebp)
8010531a:	85 c0                	test   %eax,%eax
8010531c:	75 c3                	jne    801052e1 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010531e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105323:	c9                   	leave  
80105324:	c3                   	ret    

80105325 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105325:	55                   	push   %ebp
80105326:	89 e5                	mov    %esp,%ebp
80105328:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
8010532b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010532e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80105331:	8b 45 08             	mov    0x8(%ebp),%eax
80105334:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80105337:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010533a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010533d:	73 3d                	jae    8010537c <memmove+0x57>
8010533f:	8b 45 10             	mov    0x10(%ebp),%eax
80105342:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105345:	01 d0                	add    %edx,%eax
80105347:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010534a:	76 30                	jbe    8010537c <memmove+0x57>
    s += n;
8010534c:	8b 45 10             	mov    0x10(%ebp),%eax
8010534f:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80105352:	8b 45 10             	mov    0x10(%ebp),%eax
80105355:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
80105358:	eb 13                	jmp    8010536d <memmove+0x48>
      *--d = *--s;
8010535a:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
8010535e:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80105362:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105365:	0f b6 10             	movzbl (%eax),%edx
80105368:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010536b:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010536d:	8b 45 10             	mov    0x10(%ebp),%eax
80105370:	8d 50 ff             	lea    -0x1(%eax),%edx
80105373:	89 55 10             	mov    %edx,0x10(%ebp)
80105376:	85 c0                	test   %eax,%eax
80105378:	75 e0                	jne    8010535a <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010537a:	eb 26                	jmp    801053a2 <memmove+0x7d>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010537c:	eb 17                	jmp    80105395 <memmove+0x70>
      *d++ = *s++;
8010537e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105381:	8d 50 01             	lea    0x1(%eax),%edx
80105384:	89 55 f8             	mov    %edx,-0x8(%ebp)
80105387:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010538a:	8d 4a 01             	lea    0x1(%edx),%ecx
8010538d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
80105390:	0f b6 12             	movzbl (%edx),%edx
80105393:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105395:	8b 45 10             	mov    0x10(%ebp),%eax
80105398:	8d 50 ff             	lea    -0x1(%eax),%edx
8010539b:	89 55 10             	mov    %edx,0x10(%ebp)
8010539e:	85 c0                	test   %eax,%eax
801053a0:	75 dc                	jne    8010537e <memmove+0x59>
      *d++ = *s++;

  return dst;
801053a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
801053a5:	c9                   	leave  
801053a6:	c3                   	ret    

801053a7 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801053a7:	55                   	push   %ebp
801053a8:	89 e5                	mov    %esp,%ebp
801053aa:	83 ec 0c             	sub    $0xc,%esp
  return memmove(dst, src, n);
801053ad:	8b 45 10             	mov    0x10(%ebp),%eax
801053b0:	89 44 24 08          	mov    %eax,0x8(%esp)
801053b4:	8b 45 0c             	mov    0xc(%ebp),%eax
801053b7:	89 44 24 04          	mov    %eax,0x4(%esp)
801053bb:	8b 45 08             	mov    0x8(%ebp),%eax
801053be:	89 04 24             	mov    %eax,(%esp)
801053c1:	e8 5f ff ff ff       	call   80105325 <memmove>
}
801053c6:	c9                   	leave  
801053c7:	c3                   	ret    

801053c8 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801053c8:	55                   	push   %ebp
801053c9:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
801053cb:	eb 0c                	jmp    801053d9 <strncmp+0x11>
    n--, p++, q++;
801053cd:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801053d1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
801053d5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801053d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801053dd:	74 1a                	je     801053f9 <strncmp+0x31>
801053df:	8b 45 08             	mov    0x8(%ebp),%eax
801053e2:	0f b6 00             	movzbl (%eax),%eax
801053e5:	84 c0                	test   %al,%al
801053e7:	74 10                	je     801053f9 <strncmp+0x31>
801053e9:	8b 45 08             	mov    0x8(%ebp),%eax
801053ec:	0f b6 10             	movzbl (%eax),%edx
801053ef:	8b 45 0c             	mov    0xc(%ebp),%eax
801053f2:	0f b6 00             	movzbl (%eax),%eax
801053f5:	38 c2                	cmp    %al,%dl
801053f7:	74 d4                	je     801053cd <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
801053f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801053fd:	75 07                	jne    80105406 <strncmp+0x3e>
    return 0;
801053ff:	b8 00 00 00 00       	mov    $0x0,%eax
80105404:	eb 16                	jmp    8010541c <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
80105406:	8b 45 08             	mov    0x8(%ebp),%eax
80105409:	0f b6 00             	movzbl (%eax),%eax
8010540c:	0f b6 d0             	movzbl %al,%edx
8010540f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105412:	0f b6 00             	movzbl (%eax),%eax
80105415:	0f b6 c0             	movzbl %al,%eax
80105418:	29 c2                	sub    %eax,%edx
8010541a:	89 d0                	mov    %edx,%eax
}
8010541c:	5d                   	pop    %ebp
8010541d:	c3                   	ret    

8010541e <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
8010541e:	55                   	push   %ebp
8010541f:	89 e5                	mov    %esp,%ebp
80105421:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105424:	8b 45 08             	mov    0x8(%ebp),%eax
80105427:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
8010542a:	90                   	nop
8010542b:	8b 45 10             	mov    0x10(%ebp),%eax
8010542e:	8d 50 ff             	lea    -0x1(%eax),%edx
80105431:	89 55 10             	mov    %edx,0x10(%ebp)
80105434:	85 c0                	test   %eax,%eax
80105436:	7e 1e                	jle    80105456 <strncpy+0x38>
80105438:	8b 45 08             	mov    0x8(%ebp),%eax
8010543b:	8d 50 01             	lea    0x1(%eax),%edx
8010543e:	89 55 08             	mov    %edx,0x8(%ebp)
80105441:	8b 55 0c             	mov    0xc(%ebp),%edx
80105444:	8d 4a 01             	lea    0x1(%edx),%ecx
80105447:	89 4d 0c             	mov    %ecx,0xc(%ebp)
8010544a:	0f b6 12             	movzbl (%edx),%edx
8010544d:	88 10                	mov    %dl,(%eax)
8010544f:	0f b6 00             	movzbl (%eax),%eax
80105452:	84 c0                	test   %al,%al
80105454:	75 d5                	jne    8010542b <strncpy+0xd>
    ;
  while(n-- > 0)
80105456:	eb 0c                	jmp    80105464 <strncpy+0x46>
    *s++ = 0;
80105458:	8b 45 08             	mov    0x8(%ebp),%eax
8010545b:	8d 50 01             	lea    0x1(%eax),%edx
8010545e:	89 55 08             	mov    %edx,0x8(%ebp)
80105461:	c6 00 00             	movb   $0x0,(%eax)
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80105464:	8b 45 10             	mov    0x10(%ebp),%eax
80105467:	8d 50 ff             	lea    -0x1(%eax),%edx
8010546a:	89 55 10             	mov    %edx,0x10(%ebp)
8010546d:	85 c0                	test   %eax,%eax
8010546f:	7f e7                	jg     80105458 <strncpy+0x3a>
    *s++ = 0;
  return os;
80105471:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105474:	c9                   	leave  
80105475:	c3                   	ret    

80105476 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105476:	55                   	push   %ebp
80105477:	89 e5                	mov    %esp,%ebp
80105479:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
8010547c:	8b 45 08             	mov    0x8(%ebp),%eax
8010547f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80105482:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105486:	7f 05                	jg     8010548d <safestrcpy+0x17>
    return os;
80105488:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010548b:	eb 31                	jmp    801054be <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
8010548d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105491:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105495:	7e 1e                	jle    801054b5 <safestrcpy+0x3f>
80105497:	8b 45 08             	mov    0x8(%ebp),%eax
8010549a:	8d 50 01             	lea    0x1(%eax),%edx
8010549d:	89 55 08             	mov    %edx,0x8(%ebp)
801054a0:	8b 55 0c             	mov    0xc(%ebp),%edx
801054a3:	8d 4a 01             	lea    0x1(%edx),%ecx
801054a6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801054a9:	0f b6 12             	movzbl (%edx),%edx
801054ac:	88 10                	mov    %dl,(%eax)
801054ae:	0f b6 00             	movzbl (%eax),%eax
801054b1:	84 c0                	test   %al,%al
801054b3:	75 d8                	jne    8010548d <safestrcpy+0x17>
    ;
  *s = 0;
801054b5:	8b 45 08             	mov    0x8(%ebp),%eax
801054b8:	c6 00 00             	movb   $0x0,(%eax)
  return os;
801054bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801054be:	c9                   	leave  
801054bf:	c3                   	ret    

801054c0 <strlen>:

int
strlen(const char *s)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
801054c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801054cd:	eb 04                	jmp    801054d3 <strlen+0x13>
801054cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801054d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
801054d6:	8b 45 08             	mov    0x8(%ebp),%eax
801054d9:	01 d0                	add    %edx,%eax
801054db:	0f b6 00             	movzbl (%eax),%eax
801054de:	84 c0                	test   %al,%al
801054e0:	75 ed                	jne    801054cf <strlen+0xf>
    ;
  return n;
801054e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801054e5:	c9                   	leave  
801054e6:	c3                   	ret    
	...

801054e8 <swtch>:
801054e8:	8b 44 24 04          	mov    0x4(%esp),%eax
801054ec:	8b 54 24 08          	mov    0x8(%esp),%edx
801054f0:	55                   	push   %ebp
801054f1:	53                   	push   %ebx
801054f2:	56                   	push   %esi
801054f3:	57                   	push   %edi
801054f4:	89 20                	mov    %esp,(%eax)
801054f6:	89 d4                	mov    %edx,%esp
801054f8:	5f                   	pop    %edi
801054f9:	5e                   	pop    %esi
801054fa:	5b                   	pop    %ebx
801054fb:	5d                   	pop    %ebp
801054fc:	c3                   	ret    
801054fd:	00 00                	add    %al,(%eax)
	...

80105500 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80105503:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105509:	8b 00                	mov    (%eax),%eax
8010550b:	3b 45 08             	cmp    0x8(%ebp),%eax
8010550e:	76 12                	jbe    80105522 <fetchint+0x22>
80105510:	8b 45 08             	mov    0x8(%ebp),%eax
80105513:	8d 50 04             	lea    0x4(%eax),%edx
80105516:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010551c:	8b 00                	mov    (%eax),%eax
8010551e:	39 c2                	cmp    %eax,%edx
80105520:	76 07                	jbe    80105529 <fetchint+0x29>
    return -1;
80105522:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105527:	eb 0f                	jmp    80105538 <fetchint+0x38>
  *ip = *(int*)(addr);
80105529:	8b 45 08             	mov    0x8(%ebp),%eax
8010552c:	8b 10                	mov    (%eax),%edx
8010552e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105531:	89 10                	mov    %edx,(%eax)
  return 0;
80105533:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105538:	5d                   	pop    %ebp
80105539:	c3                   	ret    

8010553a <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
8010553a:	55                   	push   %ebp
8010553b:	89 e5                	mov    %esp,%ebp
8010553d:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80105540:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105546:	8b 00                	mov    (%eax),%eax
80105548:	3b 45 08             	cmp    0x8(%ebp),%eax
8010554b:	77 07                	ja     80105554 <fetchstr+0x1a>
    return -1;
8010554d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105552:	eb 48                	jmp    8010559c <fetchstr+0x62>
  *pp = (char*)addr;
80105554:	8b 55 08             	mov    0x8(%ebp),%edx
80105557:	8b 45 0c             	mov    0xc(%ebp),%eax
8010555a:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
8010555c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105562:	8b 00                	mov    (%eax),%eax
80105564:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(s = *pp; s < ep; s++)
80105567:	8b 45 0c             	mov    0xc(%ebp),%eax
8010556a:	8b 00                	mov    (%eax),%eax
8010556c:	89 45 f8             	mov    %eax,-0x8(%ebp)
8010556f:	eb 1e                	jmp    8010558f <fetchstr+0x55>
    if(*s == 0)
80105571:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105574:	0f b6 00             	movzbl (%eax),%eax
80105577:	84 c0                	test   %al,%al
80105579:	75 10                	jne    8010558b <fetchstr+0x51>
      return s - *pp;
8010557b:	8b 55 f8             	mov    -0x8(%ebp),%edx
8010557e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105581:	8b 00                	mov    (%eax),%eax
80105583:	89 d1                	mov    %edx,%ecx
80105585:	29 c1                	sub    %eax,%ecx
80105587:	89 c8                	mov    %ecx,%eax
80105589:	eb 11                	jmp    8010559c <fetchstr+0x62>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
8010558b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
8010558f:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105592:	3b 45 fc             	cmp    -0x4(%ebp),%eax
80105595:	72 da                	jb     80105571 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
80105597:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010559c:	c9                   	leave  
8010559d:	c3                   	ret    

8010559e <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
8010559e:	55                   	push   %ebp
8010559f:	89 e5                	mov    %esp,%ebp
801055a1:	83 ec 08             	sub    $0x8,%esp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801055a4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055aa:	8b 40 18             	mov    0x18(%eax),%eax
801055ad:	8b 50 44             	mov    0x44(%eax),%edx
801055b0:	8b 45 08             	mov    0x8(%ebp),%eax
801055b3:	c1 e0 02             	shl    $0x2,%eax
801055b6:	8d 04 02             	lea    (%edx,%eax,1),%eax
801055b9:	8d 50 04             	lea    0x4(%eax),%edx
801055bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801055bf:	89 44 24 04          	mov    %eax,0x4(%esp)
801055c3:	89 14 24             	mov    %edx,(%esp)
801055c6:	e8 35 ff ff ff       	call   80105500 <fetchint>
}
801055cb:	c9                   	leave  
801055cc:	c3                   	ret    

801055cd <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801055cd:	55                   	push   %ebp
801055ce:	89 e5                	mov    %esp,%ebp
801055d0:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  if(argint(n, &i) < 0)
801055d3:	8d 45 fc             	lea    -0x4(%ebp),%eax
801055d6:	89 44 24 04          	mov    %eax,0x4(%esp)
801055da:	8b 45 08             	mov    0x8(%ebp),%eax
801055dd:	89 04 24             	mov    %eax,(%esp)
801055e0:	e8 b9 ff ff ff       	call   8010559e <argint>
801055e5:	85 c0                	test   %eax,%eax
801055e7:	79 07                	jns    801055f0 <argptr+0x23>
    return -1;
801055e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055ee:	eb 3d                	jmp    8010562d <argptr+0x60>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
801055f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055f3:	89 c2                	mov    %eax,%edx
801055f5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055fb:	8b 00                	mov    (%eax),%eax
801055fd:	39 c2                	cmp    %eax,%edx
801055ff:	73 16                	jae    80105617 <argptr+0x4a>
80105601:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105604:	89 c2                	mov    %eax,%edx
80105606:	8b 45 10             	mov    0x10(%ebp),%eax
80105609:	01 c2                	add    %eax,%edx
8010560b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105611:	8b 00                	mov    (%eax),%eax
80105613:	39 c2                	cmp    %eax,%edx
80105615:	76 07                	jbe    8010561e <argptr+0x51>
    return -1;
80105617:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010561c:	eb 0f                	jmp    8010562d <argptr+0x60>
  *pp = (char*)i;
8010561e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105621:	89 c2                	mov    %eax,%edx
80105623:	8b 45 0c             	mov    0xc(%ebp),%eax
80105626:	89 10                	mov    %edx,(%eax)
  return 0;
80105628:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010562d:	c9                   	leave  
8010562e:	c3                   	ret    

8010562f <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
8010562f:	55                   	push   %ebp
80105630:	89 e5                	mov    %esp,%ebp
80105632:	83 ec 18             	sub    $0x18,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105635:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105638:	89 44 24 04          	mov    %eax,0x4(%esp)
8010563c:	8b 45 08             	mov    0x8(%ebp),%eax
8010563f:	89 04 24             	mov    %eax,(%esp)
80105642:	e8 57 ff ff ff       	call   8010559e <argint>
80105647:	85 c0                	test   %eax,%eax
80105649:	79 07                	jns    80105652 <argstr+0x23>
    return -1;
8010564b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105650:	eb 12                	jmp    80105664 <argstr+0x35>
  return fetchstr(addr, pp);
80105652:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105655:	8b 55 0c             	mov    0xc(%ebp),%edx
80105658:	89 54 24 04          	mov    %edx,0x4(%esp)
8010565c:	89 04 24             	mov    %eax,(%esp)
8010565f:	e8 d6 fe ff ff       	call   8010553a <fetchstr>
}
80105664:	c9                   	leave  
80105665:	c3                   	ret    

80105666 <syscall>:
[SYS_thread_yield]   sys_thread_yield,
};

void
syscall(void)
{
80105666:	55                   	push   %ebp
80105667:	89 e5                	mov    %esp,%ebp
80105669:	53                   	push   %ebx
8010566a:	83 ec 24             	sub    $0x24,%esp
  int num;

  num = proc->tf->eax;
8010566d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105673:	8b 40 18             	mov    0x18(%eax),%eax
80105676:	8b 40 1c             	mov    0x1c(%eax),%eax
80105679:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010567c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105680:	7e 30                	jle    801056b2 <syscall+0x4c>
80105682:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105685:	83 f8 1a             	cmp    $0x1a,%eax
80105688:	77 28                	ja     801056b2 <syscall+0x4c>
8010568a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010568d:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105694:	85 c0                	test   %eax,%eax
80105696:	74 1a                	je     801056b2 <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
80105698:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010569e:	8b 58 18             	mov    0x18(%eax),%ebx
801056a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056a4:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
801056ab:	ff d0                	call   *%eax
801056ad:	89 43 1c             	mov    %eax,0x1c(%ebx)
syscall(void)
{
  int num;

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801056b0:	eb 3d                	jmp    801056ef <syscall+0x89>
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
801056b2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801056b8:	8d 48 6c             	lea    0x6c(%eax),%ecx
            proc->pid, proc->name, num);
801056bb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801056c1:	8b 40 10             	mov    0x10(%eax),%eax
801056c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056c7:	89 54 24 0c          	mov    %edx,0xc(%esp)
801056cb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801056cf:	89 44 24 04          	mov    %eax,0x4(%esp)
801056d3:	c7 04 24 af 8a 10 80 	movl   $0x80108aaf,(%esp)
801056da:	e8 c1 ac ff ff       	call   801003a0 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801056df:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056e5:	8b 40 18             	mov    0x18(%eax),%eax
801056e8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801056ef:	83 c4 24             	add    $0x24,%esp
801056f2:	5b                   	pop    %ebx
801056f3:	5d                   	pop    %ebp
801056f4:	c3                   	ret    
801056f5:	00 00                	add    %al,(%eax)
	...

801056f8 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
801056f8:	55                   	push   %ebp
801056f9:	89 e5                	mov    %esp,%ebp
801056fb:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801056fe:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105701:	89 44 24 04          	mov    %eax,0x4(%esp)
80105705:	8b 45 08             	mov    0x8(%ebp),%eax
80105708:	89 04 24             	mov    %eax,(%esp)
8010570b:	e8 8e fe ff ff       	call   8010559e <argint>
80105710:	85 c0                	test   %eax,%eax
80105712:	79 07                	jns    8010571b <argfd+0x23>
    return -1;
80105714:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105719:	eb 50                	jmp    8010576b <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
8010571b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010571e:	85 c0                	test   %eax,%eax
80105720:	78 21                	js     80105743 <argfd+0x4b>
80105722:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105725:	83 f8 0f             	cmp    $0xf,%eax
80105728:	7f 19                	jg     80105743 <argfd+0x4b>
8010572a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105730:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105733:	83 c2 08             	add    $0x8,%edx
80105736:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010573a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010573d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105741:	75 07                	jne    8010574a <argfd+0x52>
    return -1;
80105743:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105748:	eb 21                	jmp    8010576b <argfd+0x73>
  if(pfd)
8010574a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010574e:	74 08                	je     80105758 <argfd+0x60>
    *pfd = fd;
80105750:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105753:	8b 45 0c             	mov    0xc(%ebp),%eax
80105756:	89 10                	mov    %edx,(%eax)
  if(pf)
80105758:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010575c:	74 08                	je     80105766 <argfd+0x6e>
    *pf = f;
8010575e:	8b 45 10             	mov    0x10(%ebp),%eax
80105761:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105764:	89 10                	mov    %edx,(%eax)
  return 0;
80105766:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010576b:	c9                   	leave  
8010576c:	c3                   	ret    

8010576d <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
8010576d:	55                   	push   %ebp
8010576e:	89 e5                	mov    %esp,%ebp
80105770:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105773:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010577a:	eb 30                	jmp    801057ac <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
8010577c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105782:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105785:	83 c2 08             	add    $0x8,%edx
80105788:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010578c:	85 c0                	test   %eax,%eax
8010578e:	75 18                	jne    801057a8 <fdalloc+0x3b>
      proc->ofile[fd] = f;
80105790:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105796:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105799:	8d 4a 08             	lea    0x8(%edx),%ecx
8010579c:	8b 55 08             	mov    0x8(%ebp),%edx
8010579f:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
801057a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801057a6:	eb 0f                	jmp    801057b7 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801057a8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801057ac:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
801057b0:	7e ca                	jle    8010577c <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
801057b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057b7:	c9                   	leave  
801057b8:	c3                   	ret    

801057b9 <sys_dup>:

int
sys_dup(void)
{
801057b9:	55                   	push   %ebp
801057ba:	89 e5                	mov    %esp,%ebp
801057bc:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
801057bf:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057c2:	89 44 24 08          	mov    %eax,0x8(%esp)
801057c6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801057cd:	00 
801057ce:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801057d5:	e8 1e ff ff ff       	call   801056f8 <argfd>
801057da:	85 c0                	test   %eax,%eax
801057dc:	79 07                	jns    801057e5 <sys_dup+0x2c>
    return -1;
801057de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057e3:	eb 29                	jmp    8010580e <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
801057e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057e8:	89 04 24             	mov    %eax,(%esp)
801057eb:	e8 7d ff ff ff       	call   8010576d <fdalloc>
801057f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801057f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801057f7:	79 07                	jns    80105800 <sys_dup+0x47>
    return -1;
801057f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057fe:	eb 0e                	jmp    8010580e <sys_dup+0x55>
  filedup(f);
80105800:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105803:	89 04 24             	mov    %eax,(%esp)
80105806:	e8 75 b7 ff ff       	call   80100f80 <filedup>
  return fd;
8010580b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010580e:	c9                   	leave  
8010580f:	c3                   	ret    

80105810 <sys_read>:

int
sys_read(void)
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105816:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105819:	89 44 24 08          	mov    %eax,0x8(%esp)
8010581d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105824:	00 
80105825:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010582c:	e8 c7 fe ff ff       	call   801056f8 <argfd>
80105831:	85 c0                	test   %eax,%eax
80105833:	78 35                	js     8010586a <sys_read+0x5a>
80105835:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105838:	89 44 24 04          	mov    %eax,0x4(%esp)
8010583c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105843:	e8 56 fd ff ff       	call   8010559e <argint>
80105848:	85 c0                	test   %eax,%eax
8010584a:	78 1e                	js     8010586a <sys_read+0x5a>
8010584c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010584f:	89 44 24 08          	mov    %eax,0x8(%esp)
80105853:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105856:	89 44 24 04          	mov    %eax,0x4(%esp)
8010585a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105861:	e8 67 fd ff ff       	call   801055cd <argptr>
80105866:	85 c0                	test   %eax,%eax
80105868:	79 07                	jns    80105871 <sys_read+0x61>
    return -1;
8010586a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010586f:	eb 19                	jmp    8010588a <sys_read+0x7a>
  return fileread(f, p, n);
80105871:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105874:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105877:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010587a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010587e:	89 54 24 04          	mov    %edx,0x4(%esp)
80105882:	89 04 24             	mov    %eax,(%esp)
80105885:	e8 63 b8 ff ff       	call   801010ed <fileread>
}
8010588a:	c9                   	leave  
8010588b:	c3                   	ret    

8010588c <sys_write>:

int
sys_write(void)
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
801058a8:	e8 4b fe ff ff       	call   801056f8 <argfd>
801058ad:	85 c0                	test   %eax,%eax
801058af:	78 35                	js     801058e6 <sys_write+0x5a>
801058b1:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058b4:	89 44 24 04          	mov    %eax,0x4(%esp)
801058b8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801058bf:	e8 da fc ff ff       	call   8010559e <argint>
801058c4:	85 c0                	test   %eax,%eax
801058c6:	78 1e                	js     801058e6 <sys_write+0x5a>
801058c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058cb:	89 44 24 08          	mov    %eax,0x8(%esp)
801058cf:	8d 45 ec             	lea    -0x14(%ebp),%eax
801058d2:	89 44 24 04          	mov    %eax,0x4(%esp)
801058d6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801058dd:	e8 eb fc ff ff       	call   801055cd <argptr>
801058e2:	85 c0                	test   %eax,%eax
801058e4:	79 07                	jns    801058ed <sys_write+0x61>
    return -1;
801058e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058eb:	eb 19                	jmp    80105906 <sys_write+0x7a>
  return filewrite(f, p, n);
801058ed:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801058f0:	8b 55 ec             	mov    -0x14(%ebp),%edx
801058f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058f6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801058fa:	89 54 24 04          	mov    %edx,0x4(%esp)
801058fe:	89 04 24             	mov    %eax,(%esp)
80105901:	e8 a3 b8 ff ff       	call   801011a9 <filewrite>
}
80105906:	c9                   	leave  
80105907:	c3                   	ret    

80105908 <sys_close>:

int
sys_close(void)
{
80105908:	55                   	push   %ebp
80105909:	89 e5                	mov    %esp,%ebp
8010590b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
8010590e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105911:	89 44 24 08          	mov    %eax,0x8(%esp)
80105915:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105918:	89 44 24 04          	mov    %eax,0x4(%esp)
8010591c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105923:	e8 d0 fd ff ff       	call   801056f8 <argfd>
80105928:	85 c0                	test   %eax,%eax
8010592a:	79 07                	jns    80105933 <sys_close+0x2b>
    return -1;
8010592c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105931:	eb 24                	jmp    80105957 <sys_close+0x4f>
  proc->ofile[fd] = 0;
80105933:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105939:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010593c:	83 c2 08             	add    $0x8,%edx
8010593f:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105946:	00 
  fileclose(f);
80105947:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010594a:	89 04 24             	mov    %eax,(%esp)
8010594d:	e8 76 b6 ff ff       	call   80100fc8 <fileclose>
  return 0;
80105952:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105957:	c9                   	leave  
80105958:	c3                   	ret    

80105959 <sys_fstat>:

int
sys_fstat(void)
{
80105959:	55                   	push   %ebp
8010595a:	89 e5                	mov    %esp,%ebp
8010595c:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010595f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105962:	89 44 24 08          	mov    %eax,0x8(%esp)
80105966:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010596d:	00 
8010596e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105975:	e8 7e fd ff ff       	call   801056f8 <argfd>
8010597a:	85 c0                	test   %eax,%eax
8010597c:	78 1f                	js     8010599d <sys_fstat+0x44>
8010597e:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80105985:	00 
80105986:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105989:	89 44 24 04          	mov    %eax,0x4(%esp)
8010598d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105994:	e8 34 fc ff ff       	call   801055cd <argptr>
80105999:	85 c0                	test   %eax,%eax
8010599b:	79 07                	jns    801059a4 <sys_fstat+0x4b>
    return -1;
8010599d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059a2:	eb 12                	jmp    801059b6 <sys_fstat+0x5d>
  return filestat(f, st);
801059a4:	8b 55 f0             	mov    -0x10(%ebp),%edx
801059a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059aa:	89 54 24 04          	mov    %edx,0x4(%esp)
801059ae:	89 04 24             	mov    %eax,(%esp)
801059b1:	e8 e8 b6 ff ff       	call   8010109e <filestat>
}
801059b6:	c9                   	leave  
801059b7:	c3                   	ret    

801059b8 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
801059b8:	55                   	push   %ebp
801059b9:	89 e5                	mov    %esp,%ebp
801059bb:	83 ec 38             	sub    $0x38,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801059be:	8d 45 d8             	lea    -0x28(%ebp),%eax
801059c1:	89 44 24 04          	mov    %eax,0x4(%esp)
801059c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801059cc:	e8 5e fc ff ff       	call   8010562f <argstr>
801059d1:	85 c0                	test   %eax,%eax
801059d3:	78 17                	js     801059ec <sys_link+0x34>
801059d5:	8d 45 dc             	lea    -0x24(%ebp),%eax
801059d8:	89 44 24 04          	mov    %eax,0x4(%esp)
801059dc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801059e3:	e8 47 fc ff ff       	call   8010562f <argstr>
801059e8:	85 c0                	test   %eax,%eax
801059ea:	79 0a                	jns    801059f6 <sys_link+0x3e>
    return -1;
801059ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059f1:	e9 3d 01 00 00       	jmp    80105b33 <sys_link+0x17b>
  if((ip = namei(old)) == 0)
801059f6:	8b 45 d8             	mov    -0x28(%ebp),%eax
801059f9:	89 04 24             	mov    %eax,(%esp)
801059fc:	e8 00 ca ff ff       	call   80102401 <namei>
80105a01:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105a04:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105a08:	75 0a                	jne    80105a14 <sys_link+0x5c>
    return -1;
80105a0a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a0f:	e9 1f 01 00 00       	jmp    80105b33 <sys_link+0x17b>

  begin_trans();
80105a14:	e8 cd d7 ff ff       	call   801031e6 <begin_trans>

  ilock(ip);
80105a19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a1c:	89 04 24             	mov    %eax,(%esp)
80105a1f:	e8 32 be ff ff       	call   80101856 <ilock>
  if(ip->type == T_DIR){
80105a24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a27:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105a2b:	66 83 f8 01          	cmp    $0x1,%ax
80105a2f:	75 1a                	jne    80105a4b <sys_link+0x93>
    iunlockput(ip);
80105a31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a34:	89 04 24             	mov    %eax,(%esp)
80105a37:	e8 9e c0 ff ff       	call   80101ada <iunlockput>
    commit_trans();
80105a3c:	e8 ee d7 ff ff       	call   8010322f <commit_trans>
    return -1;
80105a41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a46:	e9 e8 00 00 00       	jmp    80105b33 <sys_link+0x17b>
  }

  ip->nlink++;
80105a4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a4e:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105a52:	8d 50 01             	lea    0x1(%eax),%edx
80105a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a58:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105a5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a5f:	89 04 24             	mov    %eax,(%esp)
80105a62:	e8 33 bc ff ff       	call   8010169a <iupdate>
  iunlock(ip);
80105a67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a6a:	89 04 24             	mov    %eax,(%esp)
80105a6d:	e8 32 bf ff ff       	call   801019a4 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80105a72:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105a75:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105a78:	89 54 24 04          	mov    %edx,0x4(%esp)
80105a7c:	89 04 24             	mov    %eax,(%esp)
80105a7f:	e8 9f c9 ff ff       	call   80102423 <nameiparent>
80105a84:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105a87:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105a8b:	75 02                	jne    80105a8f <sys_link+0xd7>
    goto bad;
80105a8d:	eb 68                	jmp    80105af7 <sys_link+0x13f>
  ilock(dp);
80105a8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a92:	89 04 24             	mov    %eax,(%esp)
80105a95:	e8 bc bd ff ff       	call   80101856 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105a9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a9d:	8b 10                	mov    (%eax),%edx
80105a9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105aa2:	8b 00                	mov    (%eax),%eax
80105aa4:	39 c2                	cmp    %eax,%edx
80105aa6:	75 20                	jne    80105ac8 <sys_link+0x110>
80105aa8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105aab:	8b 40 04             	mov    0x4(%eax),%eax
80105aae:	89 44 24 08          	mov    %eax,0x8(%esp)
80105ab2:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105ab5:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ab9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105abc:	89 04 24             	mov    %eax,(%esp)
80105abf:	e8 7d c6 ff ff       	call   80102141 <dirlink>
80105ac4:	85 c0                	test   %eax,%eax
80105ac6:	79 0d                	jns    80105ad5 <sys_link+0x11d>
    iunlockput(dp);
80105ac8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105acb:	89 04 24             	mov    %eax,(%esp)
80105ace:	e8 07 c0 ff ff       	call   80101ada <iunlockput>
    goto bad;
80105ad3:	eb 22                	jmp    80105af7 <sys_link+0x13f>
  }
  iunlockput(dp);
80105ad5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ad8:	89 04 24             	mov    %eax,(%esp)
80105adb:	e8 fa bf ff ff       	call   80101ada <iunlockput>
  iput(ip);
80105ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ae3:	89 04 24             	mov    %eax,(%esp)
80105ae6:	e8 1e bf ff ff       	call   80101a09 <iput>

  commit_trans();
80105aeb:	e8 3f d7 ff ff       	call   8010322f <commit_trans>

  return 0;
80105af0:	b8 00 00 00 00       	mov    $0x0,%eax
80105af5:	eb 3c                	jmp    80105b33 <sys_link+0x17b>

bad:
  ilock(ip);
80105af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105afa:	89 04 24             	mov    %eax,(%esp)
80105afd:	e8 54 bd ff ff       	call   80101856 <ilock>
  ip->nlink--;
80105b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b05:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105b09:	8d 50 ff             	lea    -0x1(%eax),%edx
80105b0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b0f:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105b13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b16:	89 04 24             	mov    %eax,(%esp)
80105b19:	e8 7c bb ff ff       	call   8010169a <iupdate>
  iunlockput(ip);
80105b1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b21:	89 04 24             	mov    %eax,(%esp)
80105b24:	e8 b1 bf ff ff       	call   80101ada <iunlockput>
  commit_trans();
80105b29:	e8 01 d7 ff ff       	call   8010322f <commit_trans>
  return -1;
80105b2e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b33:	c9                   	leave  
80105b34:	c3                   	ret    

80105b35 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105b35:	55                   	push   %ebp
80105b36:	89 e5                	mov    %esp,%ebp
80105b38:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105b3b:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105b42:	eb 4b                	jmp    80105b8f <isdirempty+0x5a>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105b44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b47:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105b4e:	00 
80105b4f:	89 44 24 08          	mov    %eax,0x8(%esp)
80105b53:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105b56:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b5a:	8b 45 08             	mov    0x8(%ebp),%eax
80105b5d:	89 04 24             	mov    %eax,(%esp)
80105b60:	e8 fe c1 ff ff       	call   80101d63 <readi>
80105b65:	83 f8 10             	cmp    $0x10,%eax
80105b68:	74 0c                	je     80105b76 <isdirempty+0x41>
      panic("isdirempty: readi");
80105b6a:	c7 04 24 cb 8a 10 80 	movl   $0x80108acb,(%esp)
80105b71:	e8 c4 a9 ff ff       	call   8010053a <panic>
    if(de.inum != 0)
80105b76:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105b7a:	66 85 c0             	test   %ax,%ax
80105b7d:	74 07                	je     80105b86 <isdirempty+0x51>
      return 0;
80105b7f:	b8 00 00 00 00       	mov    $0x0,%eax
80105b84:	eb 1b                	jmp    80105ba1 <isdirempty+0x6c>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b89:	83 c0 10             	add    $0x10,%eax
80105b8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b8f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b92:	8b 45 08             	mov    0x8(%ebp),%eax
80105b95:	8b 40 18             	mov    0x18(%eax),%eax
80105b98:	39 c2                	cmp    %eax,%edx
80105b9a:	72 a8                	jb     80105b44 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80105b9c:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105ba1:	c9                   	leave  
80105ba2:	c3                   	ret    

80105ba3 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105ba3:	55                   	push   %ebp
80105ba4:	89 e5                	mov    %esp,%ebp
80105ba6:	83 ec 48             	sub    $0x48,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105ba9:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105bac:	89 44 24 04          	mov    %eax,0x4(%esp)
80105bb0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105bb7:	e8 73 fa ff ff       	call   8010562f <argstr>
80105bbc:	85 c0                	test   %eax,%eax
80105bbe:	79 0a                	jns    80105bca <sys_unlink+0x27>
    return -1;
80105bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bc5:	e9 aa 01 00 00       	jmp    80105d74 <sys_unlink+0x1d1>
  if((dp = nameiparent(path, name)) == 0)
80105bca:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105bcd:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105bd0:	89 54 24 04          	mov    %edx,0x4(%esp)
80105bd4:	89 04 24             	mov    %eax,(%esp)
80105bd7:	e8 47 c8 ff ff       	call   80102423 <nameiparent>
80105bdc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105bdf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105be3:	75 0a                	jne    80105bef <sys_unlink+0x4c>
    return -1;
80105be5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bea:	e9 85 01 00 00       	jmp    80105d74 <sys_unlink+0x1d1>

  begin_trans();
80105bef:	e8 f2 d5 ff ff       	call   801031e6 <begin_trans>

  ilock(dp);
80105bf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bf7:	89 04 24             	mov    %eax,(%esp)
80105bfa:	e8 57 bc ff ff       	call   80101856 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105bff:	c7 44 24 04 dd 8a 10 	movl   $0x80108add,0x4(%esp)
80105c06:	80 
80105c07:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105c0a:	89 04 24             	mov    %eax,(%esp)
80105c0d:	e8 44 c4 ff ff       	call   80102056 <namecmp>
80105c12:	85 c0                	test   %eax,%eax
80105c14:	0f 84 45 01 00 00    	je     80105d5f <sys_unlink+0x1bc>
80105c1a:	c7 44 24 04 df 8a 10 	movl   $0x80108adf,0x4(%esp)
80105c21:	80 
80105c22:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105c25:	89 04 24             	mov    %eax,(%esp)
80105c28:	e8 29 c4 ff ff       	call   80102056 <namecmp>
80105c2d:	85 c0                	test   %eax,%eax
80105c2f:	0f 84 2a 01 00 00    	je     80105d5f <sys_unlink+0x1bc>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105c35:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105c38:	89 44 24 08          	mov    %eax,0x8(%esp)
80105c3c:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105c3f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c46:	89 04 24             	mov    %eax,(%esp)
80105c49:	e8 2a c4 ff ff       	call   80102078 <dirlookup>
80105c4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105c51:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105c55:	75 05                	jne    80105c5c <sys_unlink+0xb9>
    goto bad;
80105c57:	e9 03 01 00 00       	jmp    80105d5f <sys_unlink+0x1bc>
  ilock(ip);
80105c5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c5f:	89 04 24             	mov    %eax,(%esp)
80105c62:	e8 ef bb ff ff       	call   80101856 <ilock>

  if(ip->nlink < 1)
80105c67:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c6a:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105c6e:	66 85 c0             	test   %ax,%ax
80105c71:	7f 0c                	jg     80105c7f <sys_unlink+0xdc>
    panic("unlink: nlink < 1");
80105c73:	c7 04 24 e2 8a 10 80 	movl   $0x80108ae2,(%esp)
80105c7a:	e8 bb a8 ff ff       	call   8010053a <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105c7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c82:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105c86:	66 83 f8 01          	cmp    $0x1,%ax
80105c8a:	75 1f                	jne    80105cab <sys_unlink+0x108>
80105c8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c8f:	89 04 24             	mov    %eax,(%esp)
80105c92:	e8 9e fe ff ff       	call   80105b35 <isdirempty>
80105c97:	85 c0                	test   %eax,%eax
80105c99:	75 10                	jne    80105cab <sys_unlink+0x108>
    iunlockput(ip);
80105c9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c9e:	89 04 24             	mov    %eax,(%esp)
80105ca1:	e8 34 be ff ff       	call   80101ada <iunlockput>
    goto bad;
80105ca6:	e9 b4 00 00 00       	jmp    80105d5f <sys_unlink+0x1bc>
  }

  memset(&de, 0, sizeof(de));
80105cab:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80105cb2:	00 
80105cb3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105cba:	00 
80105cbb:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105cbe:	89 04 24             	mov    %eax,(%esp)
80105cc1:	e8 90 f5 ff ff       	call   80105256 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105cc6:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105cc9:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105cd0:	00 
80105cd1:	89 44 24 08          	mov    %eax,0x8(%esp)
80105cd5:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105cd8:	89 44 24 04          	mov    %eax,0x4(%esp)
80105cdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cdf:	89 04 24             	mov    %eax,(%esp)
80105ce2:	e8 e0 c1 ff ff       	call   80101ec7 <writei>
80105ce7:	83 f8 10             	cmp    $0x10,%eax
80105cea:	74 0c                	je     80105cf8 <sys_unlink+0x155>
    panic("unlink: writei");
80105cec:	c7 04 24 f4 8a 10 80 	movl   $0x80108af4,(%esp)
80105cf3:	e8 42 a8 ff ff       	call   8010053a <panic>
  if(ip->type == T_DIR){
80105cf8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cfb:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105cff:	66 83 f8 01          	cmp    $0x1,%ax
80105d03:	75 1c                	jne    80105d21 <sys_unlink+0x17e>
    dp->nlink--;
80105d05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d08:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105d0c:	8d 50 ff             	lea    -0x1(%eax),%edx
80105d0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d12:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105d16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d19:	89 04 24             	mov    %eax,(%esp)
80105d1c:	e8 79 b9 ff ff       	call   8010169a <iupdate>
  }
  iunlockput(dp);
80105d21:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d24:	89 04 24             	mov    %eax,(%esp)
80105d27:	e8 ae bd ff ff       	call   80101ada <iunlockput>

  ip->nlink--;
80105d2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d2f:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105d33:	8d 50 ff             	lea    -0x1(%eax),%edx
80105d36:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d39:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105d3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d40:	89 04 24             	mov    %eax,(%esp)
80105d43:	e8 52 b9 ff ff       	call   8010169a <iupdate>
  iunlockput(ip);
80105d48:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d4b:	89 04 24             	mov    %eax,(%esp)
80105d4e:	e8 87 bd ff ff       	call   80101ada <iunlockput>

  commit_trans();
80105d53:	e8 d7 d4 ff ff       	call   8010322f <commit_trans>

  return 0;
80105d58:	b8 00 00 00 00       	mov    $0x0,%eax
80105d5d:	eb 15                	jmp    80105d74 <sys_unlink+0x1d1>

bad:
  iunlockput(dp);
80105d5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d62:	89 04 24             	mov    %eax,(%esp)
80105d65:	e8 70 bd ff ff       	call   80101ada <iunlockput>
  commit_trans();
80105d6a:	e8 c0 d4 ff ff       	call   8010322f <commit_trans>
  return -1;
80105d6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d74:	c9                   	leave  
80105d75:	c3                   	ret    

80105d76 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105d76:	55                   	push   %ebp
80105d77:	89 e5                	mov    %esp,%ebp
80105d79:	83 ec 48             	sub    $0x48,%esp
80105d7c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105d7f:	8b 55 10             	mov    0x10(%ebp),%edx
80105d82:	8b 45 14             	mov    0x14(%ebp),%eax
80105d85:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105d89:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105d8d:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105d91:	8d 45 de             	lea    -0x22(%ebp),%eax
80105d94:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d98:	8b 45 08             	mov    0x8(%ebp),%eax
80105d9b:	89 04 24             	mov    %eax,(%esp)
80105d9e:	e8 80 c6 ff ff       	call   80102423 <nameiparent>
80105da3:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105da6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105daa:	75 0a                	jne    80105db6 <create+0x40>
    return 0;
80105dac:	b8 00 00 00 00       	mov    $0x0,%eax
80105db1:	e9 7e 01 00 00       	jmp    80105f34 <create+0x1be>
  ilock(dp);
80105db6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105db9:	89 04 24             	mov    %eax,(%esp)
80105dbc:	e8 95 ba ff ff       	call   80101856 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105dc1:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105dc4:	89 44 24 08          	mov    %eax,0x8(%esp)
80105dc8:	8d 45 de             	lea    -0x22(%ebp),%eax
80105dcb:	89 44 24 04          	mov    %eax,0x4(%esp)
80105dcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dd2:	89 04 24             	mov    %eax,(%esp)
80105dd5:	e8 9e c2 ff ff       	call   80102078 <dirlookup>
80105dda:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105ddd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105de1:	74 47                	je     80105e2a <create+0xb4>
    iunlockput(dp);
80105de3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105de6:	89 04 24             	mov    %eax,(%esp)
80105de9:	e8 ec bc ff ff       	call   80101ada <iunlockput>
    ilock(ip);
80105dee:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105df1:	89 04 24             	mov    %eax,(%esp)
80105df4:	e8 5d ba ff ff       	call   80101856 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105df9:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105dfe:	75 15                	jne    80105e15 <create+0x9f>
80105e00:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e03:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105e07:	66 83 f8 02          	cmp    $0x2,%ax
80105e0b:	75 08                	jne    80105e15 <create+0x9f>
      return ip;
80105e0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e10:	e9 1f 01 00 00       	jmp    80105f34 <create+0x1be>
    iunlockput(ip);
80105e15:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e18:	89 04 24             	mov    %eax,(%esp)
80105e1b:	e8 ba bc ff ff       	call   80101ada <iunlockput>
    return 0;
80105e20:	b8 00 00 00 00       	mov    $0x0,%eax
80105e25:	e9 0a 01 00 00       	jmp    80105f34 <create+0x1be>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105e2a:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105e2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e31:	8b 00                	mov    (%eax),%eax
80105e33:	89 54 24 04          	mov    %edx,0x4(%esp)
80105e37:	89 04 24             	mov    %eax,(%esp)
80105e3a:	e8 7c b7 ff ff       	call   801015bb <ialloc>
80105e3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105e42:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e46:	75 0c                	jne    80105e54 <create+0xde>
    panic("create: ialloc");
80105e48:	c7 04 24 03 8b 10 80 	movl   $0x80108b03,(%esp)
80105e4f:	e8 e6 a6 ff ff       	call   8010053a <panic>

  ilock(ip);
80105e54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e57:	89 04 24             	mov    %eax,(%esp)
80105e5a:	e8 f7 b9 ff ff       	call   80101856 <ilock>
  ip->major = major;
80105e5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e62:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105e66:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105e6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e6d:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105e71:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105e75:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e78:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105e7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e81:	89 04 24             	mov    %eax,(%esp)
80105e84:	e8 11 b8 ff ff       	call   8010169a <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80105e89:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105e8e:	75 6a                	jne    80105efa <create+0x184>
    dp->nlink++;  // for ".."
80105e90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e93:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105e97:	8d 50 01             	lea    0x1(%eax),%edx
80105e9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e9d:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105ea1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ea4:	89 04 24             	mov    %eax,(%esp)
80105ea7:	e8 ee b7 ff ff       	call   8010169a <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105eac:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105eaf:	8b 40 04             	mov    0x4(%eax),%eax
80105eb2:	89 44 24 08          	mov    %eax,0x8(%esp)
80105eb6:	c7 44 24 04 dd 8a 10 	movl   $0x80108add,0x4(%esp)
80105ebd:	80 
80105ebe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ec1:	89 04 24             	mov    %eax,(%esp)
80105ec4:	e8 78 c2 ff ff       	call   80102141 <dirlink>
80105ec9:	85 c0                	test   %eax,%eax
80105ecb:	78 21                	js     80105eee <create+0x178>
80105ecd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ed0:	8b 40 04             	mov    0x4(%eax),%eax
80105ed3:	89 44 24 08          	mov    %eax,0x8(%esp)
80105ed7:	c7 44 24 04 df 8a 10 	movl   $0x80108adf,0x4(%esp)
80105ede:	80 
80105edf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ee2:	89 04 24             	mov    %eax,(%esp)
80105ee5:	e8 57 c2 ff ff       	call   80102141 <dirlink>
80105eea:	85 c0                	test   %eax,%eax
80105eec:	79 0c                	jns    80105efa <create+0x184>
      panic("create dots");
80105eee:	c7 04 24 12 8b 10 80 	movl   $0x80108b12,(%esp)
80105ef5:	e8 40 a6 ff ff       	call   8010053a <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105efa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105efd:	8b 40 04             	mov    0x4(%eax),%eax
80105f00:	89 44 24 08          	mov    %eax,0x8(%esp)
80105f04:	8d 45 de             	lea    -0x22(%ebp),%eax
80105f07:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f0e:	89 04 24             	mov    %eax,(%esp)
80105f11:	e8 2b c2 ff ff       	call   80102141 <dirlink>
80105f16:	85 c0                	test   %eax,%eax
80105f18:	79 0c                	jns    80105f26 <create+0x1b0>
    panic("create: dirlink");
80105f1a:	c7 04 24 1e 8b 10 80 	movl   $0x80108b1e,(%esp)
80105f21:	e8 14 a6 ff ff       	call   8010053a <panic>

  iunlockput(dp);
80105f26:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f29:	89 04 24             	mov    %eax,(%esp)
80105f2c:	e8 a9 bb ff ff       	call   80101ada <iunlockput>

  return ip;
80105f31:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105f34:	c9                   	leave  
80105f35:	c3                   	ret    

80105f36 <sys_open>:

int
sys_open(void)
{
80105f36:	55                   	push   %ebp
80105f37:	89 e5                	mov    %esp,%ebp
80105f39:	83 ec 38             	sub    $0x38,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105f3c:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105f3f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f43:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105f4a:	e8 e0 f6 ff ff       	call   8010562f <argstr>
80105f4f:	85 c0                	test   %eax,%eax
80105f51:	78 17                	js     80105f6a <sys_open+0x34>
80105f53:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f56:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f5a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105f61:	e8 38 f6 ff ff       	call   8010559e <argint>
80105f66:	85 c0                	test   %eax,%eax
80105f68:	79 0a                	jns    80105f74 <sys_open+0x3e>
    return -1;
80105f6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f6f:	e9 48 01 00 00       	jmp    801060bc <sys_open+0x186>
  if(omode & O_CREATE){
80105f74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f77:	25 00 02 00 00       	and    $0x200,%eax
80105f7c:	85 c0                	test   %eax,%eax
80105f7e:	74 40                	je     80105fc0 <sys_open+0x8a>
    begin_trans();
80105f80:	e8 61 d2 ff ff       	call   801031e6 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80105f85:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105f88:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
80105f8f:	00 
80105f90:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80105f97:	00 
80105f98:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
80105f9f:	00 
80105fa0:	89 04 24             	mov    %eax,(%esp)
80105fa3:	e8 ce fd ff ff       	call   80105d76 <create>
80105fa8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80105fab:	e8 7f d2 ff ff       	call   8010322f <commit_trans>
    if(ip == 0)
80105fb0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105fb4:	75 5c                	jne    80106012 <sys_open+0xdc>
      return -1;
80105fb6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fbb:	e9 fc 00 00 00       	jmp    801060bc <sys_open+0x186>
  } else {
    if((ip = namei(path)) == 0)
80105fc0:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105fc3:	89 04 24             	mov    %eax,(%esp)
80105fc6:	e8 36 c4 ff ff       	call   80102401 <namei>
80105fcb:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105fce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105fd2:	75 0a                	jne    80105fde <sys_open+0xa8>
      return -1;
80105fd4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fd9:	e9 de 00 00 00       	jmp    801060bc <sys_open+0x186>
    ilock(ip);
80105fde:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fe1:	89 04 24             	mov    %eax,(%esp)
80105fe4:	e8 6d b8 ff ff       	call   80101856 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105fe9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fec:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105ff0:	66 83 f8 01          	cmp    $0x1,%ax
80105ff4:	75 1c                	jne    80106012 <sys_open+0xdc>
80105ff6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ff9:	85 c0                	test   %eax,%eax
80105ffb:	74 15                	je     80106012 <sys_open+0xdc>
      iunlockput(ip);
80105ffd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106000:	89 04 24             	mov    %eax,(%esp)
80106003:	e8 d2 ba ff ff       	call   80101ada <iunlockput>
      return -1;
80106008:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010600d:	e9 aa 00 00 00       	jmp    801060bc <sys_open+0x186>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106012:	e8 09 af ff ff       	call   80100f20 <filealloc>
80106017:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010601a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010601e:	74 14                	je     80106034 <sys_open+0xfe>
80106020:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106023:	89 04 24             	mov    %eax,(%esp)
80106026:	e8 42 f7 ff ff       	call   8010576d <fdalloc>
8010602b:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010602e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80106032:	79 23                	jns    80106057 <sys_open+0x121>
    if(f)
80106034:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106038:	74 0b                	je     80106045 <sys_open+0x10f>
      fileclose(f);
8010603a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010603d:	89 04 24             	mov    %eax,(%esp)
80106040:	e8 83 af ff ff       	call   80100fc8 <fileclose>
    iunlockput(ip);
80106045:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106048:	89 04 24             	mov    %eax,(%esp)
8010604b:	e8 8a ba ff ff       	call   80101ada <iunlockput>
    return -1;
80106050:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106055:	eb 65                	jmp    801060bc <sys_open+0x186>
  }
  iunlock(ip);
80106057:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010605a:	89 04 24             	mov    %eax,(%esp)
8010605d:	e8 42 b9 ff ff       	call   801019a4 <iunlock>

  f->type = FD_INODE;
80106062:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106065:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
8010606b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010606e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106071:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80106074:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106077:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
8010607e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106081:	83 e0 01             	and    $0x1,%eax
80106084:	85 c0                	test   %eax,%eax
80106086:	0f 94 c0             	sete   %al
80106089:	89 c2                	mov    %eax,%edx
8010608b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010608e:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106091:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106094:	83 e0 01             	and    $0x1,%eax
80106097:	85 c0                	test   %eax,%eax
80106099:	75 0a                	jne    801060a5 <sys_open+0x16f>
8010609b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010609e:	83 e0 02             	and    $0x2,%eax
801060a1:	85 c0                	test   %eax,%eax
801060a3:	74 07                	je     801060ac <sys_open+0x176>
801060a5:	b8 01 00 00 00       	mov    $0x1,%eax
801060aa:	eb 05                	jmp    801060b1 <sys_open+0x17b>
801060ac:	b8 00 00 00 00       	mov    $0x0,%eax
801060b1:	89 c2                	mov    %eax,%edx
801060b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060b6:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
801060b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
801060bc:	c9                   	leave  
801060bd:	c3                   	ret    

801060be <sys_mkdir>:

int
sys_mkdir(void)
{
801060be:	55                   	push   %ebp
801060bf:	89 e5                	mov    %esp,%ebp
801060c1:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_trans();
801060c4:	e8 1d d1 ff ff       	call   801031e6 <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801060c9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060cc:	89 44 24 04          	mov    %eax,0x4(%esp)
801060d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801060d7:	e8 53 f5 ff ff       	call   8010562f <argstr>
801060dc:	85 c0                	test   %eax,%eax
801060de:	78 2c                	js     8010610c <sys_mkdir+0x4e>
801060e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060e3:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
801060ea:	00 
801060eb:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801060f2:	00 
801060f3:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801060fa:	00 
801060fb:	89 04 24             	mov    %eax,(%esp)
801060fe:	e8 73 fc ff ff       	call   80105d76 <create>
80106103:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106106:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010610a:	75 0c                	jne    80106118 <sys_mkdir+0x5a>
    commit_trans();
8010610c:	e8 1e d1 ff ff       	call   8010322f <commit_trans>
    return -1;
80106111:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106116:	eb 15                	jmp    8010612d <sys_mkdir+0x6f>
  }
  iunlockput(ip);
80106118:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010611b:	89 04 24             	mov    %eax,(%esp)
8010611e:	e8 b7 b9 ff ff       	call   80101ada <iunlockput>
  commit_trans();
80106123:	e8 07 d1 ff ff       	call   8010322f <commit_trans>
  return 0;
80106128:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010612d:	c9                   	leave  
8010612e:	c3                   	ret    

8010612f <sys_mknod>:

int
sys_mknod(void)
{
8010612f:	55                   	push   %ebp
80106130:	89 e5                	mov    %esp,%ebp
80106132:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
80106135:	e8 ac d0 ff ff       	call   801031e6 <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
8010613a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010613d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106141:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106148:	e8 e2 f4 ff ff       	call   8010562f <argstr>
8010614d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106150:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106154:	78 5e                	js     801061b4 <sys_mknod+0x85>
     argint(1, &major) < 0 ||
80106156:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106159:	89 44 24 04          	mov    %eax,0x4(%esp)
8010615d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106164:	e8 35 f4 ff ff       	call   8010559e <argint>
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80106169:	85 c0                	test   %eax,%eax
8010616b:	78 47                	js     801061b4 <sys_mknod+0x85>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
8010616d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106170:	89 44 24 04          	mov    %eax,0x4(%esp)
80106174:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010617b:	e8 1e f4 ff ff       	call   8010559e <argint>
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80106180:	85 c0                	test   %eax,%eax
80106182:	78 30                	js     801061b4 <sys_mknod+0x85>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80106184:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106187:	0f bf c8             	movswl %ax,%ecx
8010618a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010618d:	0f bf d0             	movswl %ax,%edx
80106190:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106193:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106197:	89 54 24 08          	mov    %edx,0x8(%esp)
8010619b:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
801061a2:	00 
801061a3:	89 04 24             	mov    %eax,(%esp)
801061a6:	e8 cb fb ff ff       	call   80105d76 <create>
801061ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
801061ae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801061b2:	75 0c                	jne    801061c0 <sys_mknod+0x91>
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
801061b4:	e8 76 d0 ff ff       	call   8010322f <commit_trans>
    return -1;
801061b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061be:	eb 15                	jmp    801061d5 <sys_mknod+0xa6>
  }
  iunlockput(ip);
801061c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061c3:	89 04 24             	mov    %eax,(%esp)
801061c6:	e8 0f b9 ff ff       	call   80101ada <iunlockput>
  commit_trans();
801061cb:	e8 5f d0 ff ff       	call   8010322f <commit_trans>
  return 0;
801061d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801061d5:	c9                   	leave  
801061d6:	c3                   	ret    

801061d7 <sys_chdir>:

int
sys_chdir(void)
{
801061d7:	55                   	push   %ebp
801061d8:	89 e5                	mov    %esp,%ebp
801061da:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
801061dd:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061e0:	89 44 24 04          	mov    %eax,0x4(%esp)
801061e4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801061eb:	e8 3f f4 ff ff       	call   8010562f <argstr>
801061f0:	85 c0                	test   %eax,%eax
801061f2:	78 14                	js     80106208 <sys_chdir+0x31>
801061f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061f7:	89 04 24             	mov    %eax,(%esp)
801061fa:	e8 02 c2 ff ff       	call   80102401 <namei>
801061ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106202:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106206:	75 07                	jne    8010620f <sys_chdir+0x38>
    return -1;
80106208:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010620d:	eb 57                	jmp    80106266 <sys_chdir+0x8f>
  ilock(ip);
8010620f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106212:	89 04 24             	mov    %eax,(%esp)
80106215:	e8 3c b6 ff ff       	call   80101856 <ilock>
  if(ip->type != T_DIR){
8010621a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010621d:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106221:	66 83 f8 01          	cmp    $0x1,%ax
80106225:	74 12                	je     80106239 <sys_chdir+0x62>
    iunlockput(ip);
80106227:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010622a:	89 04 24             	mov    %eax,(%esp)
8010622d:	e8 a8 b8 ff ff       	call   80101ada <iunlockput>
    return -1;
80106232:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106237:	eb 2d                	jmp    80106266 <sys_chdir+0x8f>
  }
  iunlock(ip);
80106239:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010623c:	89 04 24             	mov    %eax,(%esp)
8010623f:	e8 60 b7 ff ff       	call   801019a4 <iunlock>
  iput(proc->cwd);
80106244:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010624a:	8b 40 68             	mov    0x68(%eax),%eax
8010624d:	89 04 24             	mov    %eax,(%esp)
80106250:	e8 b4 b7 ff ff       	call   80101a09 <iput>
  proc->cwd = ip;
80106255:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010625b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010625e:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80106261:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106266:	c9                   	leave  
80106267:	c3                   	ret    

80106268 <sys_exec>:

int
sys_exec(void)
{
80106268:	55                   	push   %ebp
80106269:	89 e5                	mov    %esp,%ebp
8010626b:	81 ec a8 00 00 00    	sub    $0xa8,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106271:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106274:	89 44 24 04          	mov    %eax,0x4(%esp)
80106278:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010627f:	e8 ab f3 ff ff       	call   8010562f <argstr>
80106284:	85 c0                	test   %eax,%eax
80106286:	78 1a                	js     801062a2 <sys_exec+0x3a>
80106288:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
8010628e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106292:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106299:	e8 00 f3 ff ff       	call   8010559e <argint>
8010629e:	85 c0                	test   %eax,%eax
801062a0:	79 0a                	jns    801062ac <sys_exec+0x44>
    return -1;
801062a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062a7:	e9 c8 00 00 00       	jmp    80106374 <sys_exec+0x10c>
  }
  memset(argv, 0, sizeof(argv));
801062ac:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
801062b3:	00 
801062b4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801062bb:	00 
801062bc:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801062c2:	89 04 24             	mov    %eax,(%esp)
801062c5:	e8 8c ef ff ff       	call   80105256 <memset>
  for(i=0;; i++){
801062ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
801062d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062d4:	83 f8 1f             	cmp    $0x1f,%eax
801062d7:	76 0a                	jbe    801062e3 <sys_exec+0x7b>
      return -1;
801062d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062de:	e9 91 00 00 00       	jmp    80106374 <sys_exec+0x10c>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801062e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062e6:	c1 e0 02             	shl    $0x2,%eax
801062e9:	89 c2                	mov    %eax,%edx
801062eb:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801062f1:	01 c2                	add    %eax,%edx
801062f3:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801062f9:	89 44 24 04          	mov    %eax,0x4(%esp)
801062fd:	89 14 24             	mov    %edx,(%esp)
80106300:	e8 fb f1 ff ff       	call   80105500 <fetchint>
80106305:	85 c0                	test   %eax,%eax
80106307:	79 07                	jns    80106310 <sys_exec+0xa8>
      return -1;
80106309:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010630e:	eb 64                	jmp    80106374 <sys_exec+0x10c>
    if(uarg == 0){
80106310:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106316:	85 c0                	test   %eax,%eax
80106318:	75 26                	jne    80106340 <sys_exec+0xd8>
      argv[i] = 0;
8010631a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010631d:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80106324:	00 00 00 00 
      break;
80106328:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106329:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010632c:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80106332:	89 54 24 04          	mov    %edx,0x4(%esp)
80106336:	89 04 24             	mov    %eax,(%esp)
80106339:	e8 b2 a7 ff ff       	call   80100af0 <exec>
8010633e:	eb 34                	jmp    80106374 <sys_exec+0x10c>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106340:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106346:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106349:	c1 e2 02             	shl    $0x2,%edx
8010634c:	01 c2                	add    %eax,%edx
8010634e:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106354:	89 54 24 04          	mov    %edx,0x4(%esp)
80106358:	89 04 24             	mov    %eax,(%esp)
8010635b:	e8 da f1 ff ff       	call   8010553a <fetchstr>
80106360:	85 c0                	test   %eax,%eax
80106362:	79 07                	jns    8010636b <sys_exec+0x103>
      return -1;
80106364:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106369:	eb 09                	jmp    80106374 <sys_exec+0x10c>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
8010636b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
8010636f:	e9 5d ff ff ff       	jmp    801062d1 <sys_exec+0x69>
  return exec(path, argv);
}
80106374:	c9                   	leave  
80106375:	c3                   	ret    

80106376 <sys_pipe>:

int
sys_pipe(void)
{
80106376:	55                   	push   %ebp
80106377:	89 e5                	mov    %esp,%ebp
80106379:	83 ec 38             	sub    $0x38,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010637c:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80106383:	00 
80106384:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106387:	89 44 24 04          	mov    %eax,0x4(%esp)
8010638b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106392:	e8 36 f2 ff ff       	call   801055cd <argptr>
80106397:	85 c0                	test   %eax,%eax
80106399:	79 0a                	jns    801063a5 <sys_pipe+0x2f>
    return -1;
8010639b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063a0:	e9 9b 00 00 00       	jmp    80106440 <sys_pipe+0xca>
  if(pipealloc(&rf, &wf) < 0)
801063a5:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801063a8:	89 44 24 04          	mov    %eax,0x4(%esp)
801063ac:	8d 45 e8             	lea    -0x18(%ebp),%eax
801063af:	89 04 24             	mov    %eax,(%esp)
801063b2:	e8 21 d8 ff ff       	call   80103bd8 <pipealloc>
801063b7:	85 c0                	test   %eax,%eax
801063b9:	79 07                	jns    801063c2 <sys_pipe+0x4c>
    return -1;
801063bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063c0:	eb 7e                	jmp    80106440 <sys_pipe+0xca>
  fd0 = -1;
801063c2:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801063c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
801063cc:	89 04 24             	mov    %eax,(%esp)
801063cf:	e8 99 f3 ff ff       	call   8010576d <fdalloc>
801063d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801063d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801063db:	78 14                	js     801063f1 <sys_pipe+0x7b>
801063dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801063e0:	89 04 24             	mov    %eax,(%esp)
801063e3:	e8 85 f3 ff ff       	call   8010576d <fdalloc>
801063e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
801063eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801063ef:	79 37                	jns    80106428 <sys_pipe+0xb2>
    if(fd0 >= 0)
801063f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801063f5:	78 14                	js     8010640b <sys_pipe+0x95>
      proc->ofile[fd0] = 0;
801063f7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801063fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106400:	83 c2 08             	add    $0x8,%edx
80106403:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010640a:	00 
    fileclose(rf);
8010640b:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010640e:	89 04 24             	mov    %eax,(%esp)
80106411:	e8 b2 ab ff ff       	call   80100fc8 <fileclose>
    fileclose(wf);
80106416:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106419:	89 04 24             	mov    %eax,(%esp)
8010641c:	e8 a7 ab ff ff       	call   80100fc8 <fileclose>
    return -1;
80106421:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106426:	eb 18                	jmp    80106440 <sys_pipe+0xca>
  }
  fd[0] = fd0;
80106428:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010642b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010642e:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80106430:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106433:	8d 50 04             	lea    0x4(%eax),%edx
80106436:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106439:	89 02                	mov    %eax,(%edx)
  return 0;
8010643b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106440:	c9                   	leave  
80106441:	c3                   	ret    

80106442 <sys_thread_yield>:

void sys_thread_yield(void){
80106442:	55                   	push   %ebp
80106443:	89 e5                	mov    %esp,%ebp
80106445:	83 ec 08             	sub    $0x8,%esp
  thread_yield();
80106448:	e8 68 e7 ff ff       	call   80104bb5 <thread_yield>
}
8010644d:	c9                   	leave  
8010644e:	c3                   	ret    
	...

80106450 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106450:	55                   	push   %ebp
80106451:	89 e5                	mov    %esp,%ebp
80106453:	83 ec 08             	sub    $0x8,%esp
  return fork();
80106456:	e8 b0 de ff ff       	call   8010430b <fork>
}
8010645b:	c9                   	leave  
8010645c:	c3                   	ret    

8010645d <sys_clone>:

int
sys_clone(){
8010645d:	55                   	push   %ebp
8010645e:	89 e5                	mov    %esp,%ebp
80106460:	53                   	push   %ebx
80106461:	83 ec 24             	sub    $0x24,%esp
    int stack;
    int size;
    int routine;
    int arg;

    if(argint(1,&size) < 0 || size <=0 || argint(0,&stack) <0 ||
80106464:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106467:	89 44 24 04          	mov    %eax,0x4(%esp)
8010646b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106472:	e8 27 f1 ff ff       	call   8010559e <argint>
80106477:	85 c0                	test   %eax,%eax
80106479:	78 4c                	js     801064c7 <sys_clone+0x6a>
8010647b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010647e:	85 c0                	test   %eax,%eax
80106480:	7e 45                	jle    801064c7 <sys_clone+0x6a>
80106482:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106485:	89 44 24 04          	mov    %eax,0x4(%esp)
80106489:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106490:	e8 09 f1 ff ff       	call   8010559e <argint>
80106495:	85 c0                	test   %eax,%eax
80106497:	78 2e                	js     801064c7 <sys_clone+0x6a>
            argint(2,&routine) < 0 || argint(3,&arg)<0){
80106499:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010649c:	89 44 24 04          	mov    %eax,0x4(%esp)
801064a0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801064a7:	e8 f2 f0 ff ff       	call   8010559e <argint>
    int stack;
    int size;
    int routine;
    int arg;

    if(argint(1,&size) < 0 || size <=0 || argint(0,&stack) <0 ||
801064ac:	85 c0                	test   %eax,%eax
801064ae:	78 17                	js     801064c7 <sys_clone+0x6a>
            argint(2,&routine) < 0 || argint(3,&arg)<0){
801064b0:	8d 45 e8             	lea    -0x18(%ebp),%eax
801064b3:	89 44 24 04          	mov    %eax,0x4(%esp)
801064b7:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
801064be:	e8 db f0 ff ff       	call   8010559e <argint>
801064c3:	85 c0                	test   %eax,%eax
801064c5:	79 07                	jns    801064ce <sys_clone+0x71>
        return -1;
801064c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064cc:	eb 20                	jmp    801064ee <sys_clone+0x91>
    }
    return clone(stack,size,routine,arg);
801064ce:	8b 5d e8             	mov    -0x18(%ebp),%ebx
801064d1:	8b 4d ec             	mov    -0x14(%ebp),%ecx
801064d4:	8b 55 f0             	mov    -0x10(%ebp),%edx
801064d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064da:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
801064de:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801064e2:	89 54 24 04          	mov    %edx,0x4(%esp)
801064e6:	89 04 24             	mov    %eax,(%esp)
801064e9:	e8 8d df ff ff       	call   8010447b <clone>
}
801064ee:	83 c4 24             	add    $0x24,%esp
801064f1:	5b                   	pop    %ebx
801064f2:	5d                   	pop    %ebp
801064f3:	c3                   	ret    

801064f4 <sys_exit>:

int
sys_exit(void)
{
801064f4:	55                   	push   %ebp
801064f5:	89 e5                	mov    %esp,%ebp
801064f7:	83 ec 08             	sub    $0x8,%esp
  exit();
801064fa:	e8 9f e1 ff ff       	call   8010469e <exit>
  return 0;  // not reached
801064ff:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106504:	c9                   	leave  
80106505:	c3                   	ret    

80106506 <sys_texit>:

int
sys_texit(void)
{
80106506:	55                   	push   %ebp
80106507:	89 e5                	mov    %esp,%ebp
80106509:	83 ec 08             	sub    $0x8,%esp
    texit();
8010650c:	e8 a8 e2 ff ff       	call   801047b9 <texit>
    return 0;
80106511:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106516:	c9                   	leave  
80106517:	c3                   	ret    

80106518 <sys_wait>:

int
sys_wait(void)
{
80106518:	55                   	push   %ebp
80106519:	89 e5                	mov    %esp,%ebp
8010651b:	83 ec 08             	sub    $0x8,%esp
  return wait();
8010651e:	e8 ca e3 ff ff       	call   801048ed <wait>
}
80106523:	c9                   	leave  
80106524:	c3                   	ret    

80106525 <sys_kill>:

int
sys_kill(void)
{
80106525:	55                   	push   %ebp
80106526:	89 e5                	mov    %esp,%ebp
80106528:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
8010652b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010652e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106532:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106539:	e8 60 f0 ff ff       	call   8010559e <argint>
8010653e:	85 c0                	test   %eax,%eax
80106540:	79 07                	jns    80106549 <sys_kill+0x24>
    return -1;
80106542:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106547:	eb 0b                	jmp    80106554 <sys_kill+0x2f>
  return kill(pid);
80106549:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010654c:	89 04 24             	mov    %eax,(%esp)
8010654f:	e8 a7 e8 ff ff       	call   80104dfb <kill>
}
80106554:	c9                   	leave  
80106555:	c3                   	ret    

80106556 <sys_getpid>:

int
sys_getpid(void)
{
80106556:	55                   	push   %ebp
80106557:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80106559:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010655f:	8b 40 10             	mov    0x10(%eax),%eax
}
80106562:	5d                   	pop    %ebp
80106563:	c3                   	ret    

80106564 <sys_sbrk>:

int
sys_sbrk(void)
{
80106564:	55                   	push   %ebp
80106565:	89 e5                	mov    %esp,%ebp
80106567:	83 ec 28             	sub    $0x28,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010656a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010656d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106571:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106578:	e8 21 f0 ff ff       	call   8010559e <argint>
8010657d:	85 c0                	test   %eax,%eax
8010657f:	79 07                	jns    80106588 <sys_sbrk+0x24>
    return -1;
80106581:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106586:	eb 24                	jmp    801065ac <sys_sbrk+0x48>
  addr = proc->sz;
80106588:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010658e:	8b 00                	mov    (%eax),%eax
80106590:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80106593:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106596:	89 04 24             	mov    %eax,(%esp)
80106599:	e8 c8 dc ff ff       	call   80104266 <growproc>
8010659e:	85 c0                	test   %eax,%eax
801065a0:	79 07                	jns    801065a9 <sys_sbrk+0x45>
    return -1;
801065a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065a7:	eb 03                	jmp    801065ac <sys_sbrk+0x48>
  return addr;
801065a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801065ac:	c9                   	leave  
801065ad:	c3                   	ret    

801065ae <sys_sleep>:

int
sys_sleep(void)
{
801065ae:	55                   	push   %ebp
801065af:	89 e5                	mov    %esp,%ebp
801065b1:	83 ec 28             	sub    $0x28,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
801065b4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801065b7:	89 44 24 04          	mov    %eax,0x4(%esp)
801065bb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801065c2:	e8 d7 ef ff ff       	call   8010559e <argint>
801065c7:	85 c0                	test   %eax,%eax
801065c9:	79 07                	jns    801065d2 <sys_sleep+0x24>
    return -1;
801065cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065d0:	eb 6c                	jmp    8010663e <sys_sleep+0x90>
  acquire(&tickslock);
801065d2:	c7 04 24 80 21 11 80 	movl   $0x80112180,(%esp)
801065d9:	e8 21 ea ff ff       	call   80104fff <acquire>
  ticks0 = ticks;
801065de:	a1 c0 29 11 80       	mov    0x801129c0,%eax
801065e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
801065e6:	eb 34                	jmp    8010661c <sys_sleep+0x6e>
    if(proc->killed){
801065e8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065ee:	8b 40 24             	mov    0x24(%eax),%eax
801065f1:	85 c0                	test   %eax,%eax
801065f3:	74 13                	je     80106608 <sys_sleep+0x5a>
      release(&tickslock);
801065f5:	c7 04 24 80 21 11 80 	movl   $0x80112180,(%esp)
801065fc:	e8 60 ea ff ff       	call   80105061 <release>
      return -1;
80106601:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106606:	eb 36                	jmp    8010663e <sys_sleep+0x90>
    }
    sleep(&ticks, &tickslock);
80106608:	c7 44 24 04 80 21 11 	movl   $0x80112180,0x4(%esp)
8010660f:	80 
80106610:	c7 04 24 c0 29 11 80 	movl   $0x801129c0,(%esp)
80106617:	e8 70 e6 ff ff       	call   80104c8c <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010661c:	a1 c0 29 11 80       	mov    0x801129c0,%eax
80106621:	2b 45 f4             	sub    -0xc(%ebp),%eax
80106624:	89 c2                	mov    %eax,%edx
80106626:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106629:	39 c2                	cmp    %eax,%edx
8010662b:	72 bb                	jb     801065e8 <sys_sleep+0x3a>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
8010662d:	c7 04 24 80 21 11 80 	movl   $0x80112180,(%esp)
80106634:	e8 28 ea ff ff       	call   80105061 <release>
  return 0;
80106639:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010663e:	c9                   	leave  
8010663f:	c3                   	ret    

80106640 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106640:	55                   	push   %ebp
80106641:	89 e5                	mov    %esp,%ebp
80106643:	83 ec 28             	sub    $0x28,%esp
  uint xticks;
  
  acquire(&tickslock);
80106646:	c7 04 24 80 21 11 80 	movl   $0x80112180,(%esp)
8010664d:	e8 ad e9 ff ff       	call   80104fff <acquire>
  xticks = ticks;
80106652:	a1 c0 29 11 80       	mov    0x801129c0,%eax
80106657:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
8010665a:	c7 04 24 80 21 11 80 	movl   $0x80112180,(%esp)
80106661:	e8 fb e9 ff ff       	call   80105061 <release>
  return xticks;
80106666:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106669:	c9                   	leave  
8010666a:	c3                   	ret    

8010666b <sys_tsleep>:

int
sys_tsleep(void)
{
8010666b:	55                   	push   %ebp
8010666c:	89 e5                	mov    %esp,%ebp
8010666e:	83 ec 08             	sub    $0x8,%esp
    tsleep();
80106671:	e8 fa e8 ff ff       	call   80104f70 <tsleep>
    return 0;
80106676:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010667b:	c9                   	leave  
8010667c:	c3                   	ret    

8010667d <sys_twakeup>:

int 
sys_twakeup(void)
{
8010667d:	55                   	push   %ebp
8010667e:	89 e5                	mov    %esp,%ebp
80106680:	83 ec 28             	sub    $0x28,%esp
    int tid;
    if(argint(0,&tid) < 0){
80106683:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106686:	89 44 24 04          	mov    %eax,0x4(%esp)
8010668a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106691:	e8 08 ef ff ff       	call   8010559e <argint>
80106696:	85 c0                	test   %eax,%eax
80106698:	79 07                	jns    801066a1 <sys_twakeup+0x24>
        return -1;
8010669a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010669f:	eb 10                	jmp    801066b1 <sys_twakeup+0x34>
    }
        twakeup(tid);
801066a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066a4:	89 04 24             	mov    %eax,(%esp)
801066a7:	e8 bc e6 ff ff       	call   80104d68 <twakeup>
        return 0;
801066ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
801066b1:	c9                   	leave  
801066b2:	c3                   	ret    
	...

801066b4 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801066b4:	55                   	push   %ebp
801066b5:	89 e5                	mov    %esp,%ebp
801066b7:	83 ec 08             	sub    $0x8,%esp
801066ba:	8b 55 08             	mov    0x8(%ebp),%edx
801066bd:	8b 45 0c             	mov    0xc(%ebp),%eax
801066c0:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801066c4:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801066c7:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801066cb:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801066cf:	ee                   	out    %al,(%dx)
}
801066d0:	c9                   	leave  
801066d1:	c3                   	ret    

801066d2 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
801066d2:	55                   	push   %ebp
801066d3:	89 e5                	mov    %esp,%ebp
801066d5:	83 ec 18             	sub    $0x18,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
801066d8:	c7 44 24 04 34 00 00 	movl   $0x34,0x4(%esp)
801066df:	00 
801066e0:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
801066e7:	e8 c8 ff ff ff       	call   801066b4 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
801066ec:	c7 44 24 04 9c 00 00 	movl   $0x9c,0x4(%esp)
801066f3:	00 
801066f4:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
801066fb:	e8 b4 ff ff ff       	call   801066b4 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80106700:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
80106707:	00 
80106708:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
8010670f:	e8 a0 ff ff ff       	call   801066b4 <outb>
  picenable(IRQ_TIMER);
80106714:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010671b:	e8 49 d3 ff ff       	call   80103a69 <picenable>
}
80106720:	c9                   	leave  
80106721:	c3                   	ret    
	...

80106724 <alltraps>:
80106724:	1e                   	push   %ds
80106725:	06                   	push   %es
80106726:	0f a0                	push   %fs
80106728:	0f a8                	push   %gs
8010672a:	60                   	pusha  
8010672b:	66 b8 10 00          	mov    $0x10,%ax
8010672f:	8e d8                	mov    %eax,%ds
80106731:	8e c0                	mov    %eax,%es
80106733:	66 b8 18 00          	mov    $0x18,%ax
80106737:	8e e0                	mov    %eax,%fs
80106739:	8e e8                	mov    %eax,%gs
8010673b:	54                   	push   %esp
8010673c:	e8 d9 01 00 00       	call   8010691a <trap>
80106741:	83 c4 04             	add    $0x4,%esp

80106744 <trapret>:
80106744:	61                   	popa   
80106745:	0f a9                	pop    %gs
80106747:	0f a1                	pop    %fs
80106749:	07                   	pop    %es
8010674a:	1f                   	pop    %ds
8010674b:	83 c4 08             	add    $0x8,%esp
8010674e:	cf                   	iret   
	...

80106750 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80106750:	55                   	push   %ebp
80106751:	89 e5                	mov    %esp,%ebp
80106753:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80106756:	8b 45 0c             	mov    0xc(%ebp),%eax
80106759:	83 e8 01             	sub    $0x1,%eax
8010675c:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106760:	8b 45 08             	mov    0x8(%ebp),%eax
80106763:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106767:	8b 45 08             	mov    0x8(%ebp),%eax
8010676a:	c1 e8 10             	shr    $0x10,%eax
8010676d:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106771:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106774:	0f 01 18             	lidtl  (%eax)
}
80106777:	c9                   	leave  
80106778:	c3                   	ret    

80106779 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
80106779:	55                   	push   %ebp
8010677a:	89 e5                	mov    %esp,%ebp
8010677c:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010677f:	0f 20 d0             	mov    %cr2,%eax
80106782:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80106785:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106788:	c9                   	leave  
80106789:	c3                   	ret    

8010678a <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010678a:	55                   	push   %ebp
8010678b:	89 e5                	mov    %esp,%ebp
8010678d:	83 ec 28             	sub    $0x28,%esp
  int i;

  for(i = 0; i < 256; i++)
80106790:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106797:	e9 c3 00 00 00       	jmp    8010685f <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
8010679c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010679f:	8b 04 85 ac b0 10 80 	mov    -0x7fef4f54(,%eax,4),%eax
801067a6:	89 c2                	mov    %eax,%edx
801067a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067ab:	66 89 14 c5 c0 21 11 	mov    %dx,-0x7feede40(,%eax,8)
801067b2:	80 
801067b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067b6:	66 c7 04 c5 c2 21 11 	movw   $0x8,-0x7feede3e(,%eax,8)
801067bd:	80 08 00 
801067c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067c3:	0f b6 14 c5 c4 21 11 	movzbl -0x7feede3c(,%eax,8),%edx
801067ca:	80 
801067cb:	83 e2 e0             	and    $0xffffffe0,%edx
801067ce:	88 14 c5 c4 21 11 80 	mov    %dl,-0x7feede3c(,%eax,8)
801067d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067d8:	0f b6 14 c5 c4 21 11 	movzbl -0x7feede3c(,%eax,8),%edx
801067df:	80 
801067e0:	83 e2 1f             	and    $0x1f,%edx
801067e3:	88 14 c5 c4 21 11 80 	mov    %dl,-0x7feede3c(,%eax,8)
801067ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067ed:	0f b6 14 c5 c5 21 11 	movzbl -0x7feede3b(,%eax,8),%edx
801067f4:	80 
801067f5:	83 e2 f0             	and    $0xfffffff0,%edx
801067f8:	83 ca 0e             	or     $0xe,%edx
801067fb:	88 14 c5 c5 21 11 80 	mov    %dl,-0x7feede3b(,%eax,8)
80106802:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106805:	0f b6 14 c5 c5 21 11 	movzbl -0x7feede3b(,%eax,8),%edx
8010680c:	80 
8010680d:	83 e2 ef             	and    $0xffffffef,%edx
80106810:	88 14 c5 c5 21 11 80 	mov    %dl,-0x7feede3b(,%eax,8)
80106817:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010681a:	0f b6 14 c5 c5 21 11 	movzbl -0x7feede3b(,%eax,8),%edx
80106821:	80 
80106822:	83 e2 9f             	and    $0xffffff9f,%edx
80106825:	88 14 c5 c5 21 11 80 	mov    %dl,-0x7feede3b(,%eax,8)
8010682c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010682f:	0f b6 14 c5 c5 21 11 	movzbl -0x7feede3b(,%eax,8),%edx
80106836:	80 
80106837:	83 ca 80             	or     $0xffffff80,%edx
8010683a:	88 14 c5 c5 21 11 80 	mov    %dl,-0x7feede3b(,%eax,8)
80106841:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106844:	8b 04 85 ac b0 10 80 	mov    -0x7fef4f54(,%eax,4),%eax
8010684b:	c1 e8 10             	shr    $0x10,%eax
8010684e:	89 c2                	mov    %eax,%edx
80106850:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106853:	66 89 14 c5 c6 21 11 	mov    %dx,-0x7feede3a(,%eax,8)
8010685a:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010685b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010685f:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80106866:	0f 8e 30 ff ff ff    	jle    8010679c <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010686c:	a1 ac b1 10 80       	mov    0x8010b1ac,%eax
80106871:	66 a3 c0 23 11 80    	mov    %ax,0x801123c0
80106877:	66 c7 05 c2 23 11 80 	movw   $0x8,0x801123c2
8010687e:	08 00 
80106880:	0f b6 05 c4 23 11 80 	movzbl 0x801123c4,%eax
80106887:	83 e0 e0             	and    $0xffffffe0,%eax
8010688a:	a2 c4 23 11 80       	mov    %al,0x801123c4
8010688f:	0f b6 05 c4 23 11 80 	movzbl 0x801123c4,%eax
80106896:	83 e0 1f             	and    $0x1f,%eax
80106899:	a2 c4 23 11 80       	mov    %al,0x801123c4
8010689e:	0f b6 05 c5 23 11 80 	movzbl 0x801123c5,%eax
801068a5:	83 c8 0f             	or     $0xf,%eax
801068a8:	a2 c5 23 11 80       	mov    %al,0x801123c5
801068ad:	0f b6 05 c5 23 11 80 	movzbl 0x801123c5,%eax
801068b4:	83 e0 ef             	and    $0xffffffef,%eax
801068b7:	a2 c5 23 11 80       	mov    %al,0x801123c5
801068bc:	0f b6 05 c5 23 11 80 	movzbl 0x801123c5,%eax
801068c3:	83 c8 60             	or     $0x60,%eax
801068c6:	a2 c5 23 11 80       	mov    %al,0x801123c5
801068cb:	0f b6 05 c5 23 11 80 	movzbl 0x801123c5,%eax
801068d2:	83 c8 80             	or     $0xffffff80,%eax
801068d5:	a2 c5 23 11 80       	mov    %al,0x801123c5
801068da:	a1 ac b1 10 80       	mov    0x8010b1ac,%eax
801068df:	c1 e8 10             	shr    $0x10,%eax
801068e2:	66 a3 c6 23 11 80    	mov    %ax,0x801123c6
  
  initlock(&tickslock, "time");
801068e8:	c7 44 24 04 30 8b 10 	movl   $0x80108b30,0x4(%esp)
801068ef:	80 
801068f0:	c7 04 24 80 21 11 80 	movl   $0x80112180,(%esp)
801068f7:	e8 e2 e6 ff ff       	call   80104fde <initlock>
}
801068fc:	c9                   	leave  
801068fd:	c3                   	ret    

801068fe <idtinit>:

void
idtinit(void)
{
801068fe:	55                   	push   %ebp
801068ff:	89 e5                	mov    %esp,%ebp
80106901:	83 ec 08             	sub    $0x8,%esp
  lidt(idt, sizeof(idt));
80106904:	c7 44 24 04 00 08 00 	movl   $0x800,0x4(%esp)
8010690b:	00 
8010690c:	c7 04 24 c0 21 11 80 	movl   $0x801121c0,(%esp)
80106913:	e8 38 fe ff ff       	call   80106750 <lidt>
}
80106918:	c9                   	leave  
80106919:	c3                   	ret    

8010691a <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
8010691a:	55                   	push   %ebp
8010691b:	89 e5                	mov    %esp,%ebp
8010691d:	57                   	push   %edi
8010691e:	56                   	push   %esi
8010691f:	53                   	push   %ebx
80106920:	83 ec 3c             	sub    $0x3c,%esp
  if(tf->trapno == T_SYSCALL){
80106923:	8b 45 08             	mov    0x8(%ebp),%eax
80106926:	8b 40 30             	mov    0x30(%eax),%eax
80106929:	83 f8 40             	cmp    $0x40,%eax
8010692c:	75 3f                	jne    8010696d <trap+0x53>
    if(proc->killed)
8010692e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106934:	8b 40 24             	mov    0x24(%eax),%eax
80106937:	85 c0                	test   %eax,%eax
80106939:	74 05                	je     80106940 <trap+0x26>
      exit();
8010693b:	e8 5e dd ff ff       	call   8010469e <exit>
    proc->tf = tf;
80106940:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106946:	8b 55 08             	mov    0x8(%ebp),%edx
80106949:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
8010694c:	e8 15 ed ff ff       	call   80105666 <syscall>
    if(proc->killed)
80106951:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106957:	8b 40 24             	mov    0x24(%eax),%eax
8010695a:	85 c0                	test   %eax,%eax
8010695c:	74 0a                	je     80106968 <trap+0x4e>
      exit();
8010695e:	e8 3b dd ff ff       	call   8010469e <exit>
    return;
80106963:	e9 2d 02 00 00       	jmp    80106b95 <trap+0x27b>
80106968:	e9 28 02 00 00       	jmp    80106b95 <trap+0x27b>
  }

  switch(tf->trapno){
8010696d:	8b 45 08             	mov    0x8(%ebp),%eax
80106970:	8b 40 30             	mov    0x30(%eax),%eax
80106973:	83 e8 20             	sub    $0x20,%eax
80106976:	83 f8 1f             	cmp    $0x1f,%eax
80106979:	0f 87 bc 00 00 00    	ja     80106a3b <trap+0x121>
8010697f:	8b 04 85 d8 8b 10 80 	mov    -0x7fef7428(,%eax,4),%eax
80106986:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80106988:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010698e:	0f b6 00             	movzbl (%eax),%eax
80106991:	84 c0                	test   %al,%al
80106993:	75 31                	jne    801069c6 <trap+0xac>
      acquire(&tickslock);
80106995:	c7 04 24 80 21 11 80 	movl   $0x80112180,(%esp)
8010699c:	e8 5e e6 ff ff       	call   80104fff <acquire>
      ticks++;
801069a1:	a1 c0 29 11 80       	mov    0x801129c0,%eax
801069a6:	83 c0 01             	add    $0x1,%eax
801069a9:	a3 c0 29 11 80       	mov    %eax,0x801129c0
      wakeup(&ticks);
801069ae:	c7 04 24 c0 29 11 80 	movl   $0x801129c0,(%esp)
801069b5:	e8 16 e4 ff ff       	call   80104dd0 <wakeup>
      release(&tickslock);
801069ba:	c7 04 24 80 21 11 80 	movl   $0x80112180,(%esp)
801069c1:	e8 9b e6 ff ff       	call   80105061 <release>
    }
    lapiceoi();
801069c6:	e8 e9 c4 ff ff       	call   80102eb4 <lapiceoi>
    break;
801069cb:	e9 41 01 00 00       	jmp    80106b11 <trap+0x1f7>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801069d0:	e8 07 bd ff ff       	call   801026dc <ideintr>
    lapiceoi();
801069d5:	e8 da c4 ff ff       	call   80102eb4 <lapiceoi>
    break;
801069da:	e9 32 01 00 00       	jmp    80106b11 <trap+0x1f7>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801069df:	e8 bc c2 ff ff       	call   80102ca0 <kbdintr>
    lapiceoi();
801069e4:	e8 cb c4 ff ff       	call   80102eb4 <lapiceoi>
    break;
801069e9:	e9 23 01 00 00       	jmp    80106b11 <trap+0x1f7>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801069ee:	e8 9a 03 00 00       	call   80106d8d <uartintr>
    lapiceoi();
801069f3:	e8 bc c4 ff ff       	call   80102eb4 <lapiceoi>
    break;
801069f8:	e9 14 01 00 00       	jmp    80106b11 <trap+0x1f7>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801069fd:	8b 45 08             	mov    0x8(%ebp),%eax
80106a00:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106a03:	8b 45 08             	mov    0x8(%ebp),%eax
80106a06:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106a0a:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106a0d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106a13:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106a16:	0f b6 c0             	movzbl %al,%eax
80106a19:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106a1d:	89 54 24 08          	mov    %edx,0x8(%esp)
80106a21:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a25:	c7 04 24 38 8b 10 80 	movl   $0x80108b38,(%esp)
80106a2c:	e8 6f 99 ff ff       	call   801003a0 <cprintf>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80106a31:	e8 7e c4 ff ff       	call   80102eb4 <lapiceoi>
    break;
80106a36:	e9 d6 00 00 00       	jmp    80106b11 <trap+0x1f7>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106a3b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a41:	85 c0                	test   %eax,%eax
80106a43:	74 11                	je     80106a56 <trap+0x13c>
80106a45:	8b 45 08             	mov    0x8(%ebp),%eax
80106a48:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106a4c:	0f b7 c0             	movzwl %ax,%eax
80106a4f:	83 e0 03             	and    $0x3,%eax
80106a52:	85 c0                	test   %eax,%eax
80106a54:	75 46                	jne    80106a9c <trap+0x182>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106a56:	e8 1e fd ff ff       	call   80106779 <rcr2>
80106a5b:	8b 55 08             	mov    0x8(%ebp),%edx
80106a5e:	8b 5a 38             	mov    0x38(%edx),%ebx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106a61:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80106a68:	0f b6 12             	movzbl (%edx),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106a6b:	0f b6 ca             	movzbl %dl,%ecx
80106a6e:	8b 55 08             	mov    0x8(%ebp),%edx
80106a71:	8b 52 30             	mov    0x30(%edx),%edx
80106a74:	89 44 24 10          	mov    %eax,0x10(%esp)
80106a78:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80106a7c:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106a80:	89 54 24 04          	mov    %edx,0x4(%esp)
80106a84:	c7 04 24 5c 8b 10 80 	movl   $0x80108b5c,(%esp)
80106a8b:	e8 10 99 ff ff       	call   801003a0 <cprintf>
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
80106a90:	c7 04 24 8e 8b 10 80 	movl   $0x80108b8e,(%esp)
80106a97:	e8 9e 9a ff ff       	call   8010053a <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106a9c:	e8 d8 fc ff ff       	call   80106779 <rcr2>
80106aa1:	89 c2                	mov    %eax,%edx
80106aa3:	8b 45 08             	mov    0x8(%ebp),%eax
80106aa6:	8b 78 38             	mov    0x38(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106aa9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106aaf:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106ab2:	0f b6 f0             	movzbl %al,%esi
80106ab5:	8b 45 08             	mov    0x8(%ebp),%eax
80106ab8:	8b 58 34             	mov    0x34(%eax),%ebx
80106abb:	8b 45 08             	mov    0x8(%ebp),%eax
80106abe:	8b 48 30             	mov    0x30(%eax),%ecx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106ac1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ac7:	83 c0 6c             	add    $0x6c,%eax
80106aca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106acd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106ad3:	8b 40 10             	mov    0x10(%eax),%eax
80106ad6:	89 54 24 1c          	mov    %edx,0x1c(%esp)
80106ada:	89 7c 24 18          	mov    %edi,0x18(%esp)
80106ade:	89 74 24 14          	mov    %esi,0x14(%esp)
80106ae2:	89 5c 24 10          	mov    %ebx,0x10(%esp)
80106ae6:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106aea:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80106aed:	89 74 24 08          	mov    %esi,0x8(%esp)
80106af1:	89 44 24 04          	mov    %eax,0x4(%esp)
80106af5:	c7 04 24 94 8b 10 80 	movl   $0x80108b94,(%esp)
80106afc:	e8 9f 98 ff ff       	call   801003a0 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
80106b01:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b07:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106b0e:	eb 01                	jmp    80106b11 <trap+0x1f7>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106b10:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106b11:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b17:	85 c0                	test   %eax,%eax
80106b19:	74 24                	je     80106b3f <trap+0x225>
80106b1b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b21:	8b 40 24             	mov    0x24(%eax),%eax
80106b24:	85 c0                	test   %eax,%eax
80106b26:	74 17                	je     80106b3f <trap+0x225>
80106b28:	8b 45 08             	mov    0x8(%ebp),%eax
80106b2b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106b2f:	0f b7 c0             	movzwl %ax,%eax
80106b32:	83 e0 03             	and    $0x3,%eax
80106b35:	83 f8 03             	cmp    $0x3,%eax
80106b38:	75 05                	jne    80106b3f <trap+0x225>
    exit();
80106b3a:	e8 5f db ff ff       	call   8010469e <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106b3f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b45:	85 c0                	test   %eax,%eax
80106b47:	74 1e                	je     80106b67 <trap+0x24d>
80106b49:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b4f:	8b 40 0c             	mov    0xc(%eax),%eax
80106b52:	83 f8 04             	cmp    $0x4,%eax
80106b55:	75 10                	jne    80106b67 <trap+0x24d>
80106b57:	8b 45 08             	mov    0x8(%ebp),%eax
80106b5a:	8b 40 30             	mov    0x30(%eax),%eax
80106b5d:	83 f8 20             	cmp    $0x20,%eax
80106b60:	75 05                	jne    80106b67 <trap+0x24d>
    yield();
80106b62:	e8 1c e0 ff ff       	call   80104b83 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106b67:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b6d:	85 c0                	test   %eax,%eax
80106b6f:	74 24                	je     80106b95 <trap+0x27b>
80106b71:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b77:	8b 40 24             	mov    0x24(%eax),%eax
80106b7a:	85 c0                	test   %eax,%eax
80106b7c:	74 17                	je     80106b95 <trap+0x27b>
80106b7e:	8b 45 08             	mov    0x8(%ebp),%eax
80106b81:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106b85:	0f b7 c0             	movzwl %ax,%eax
80106b88:	83 e0 03             	and    $0x3,%eax
80106b8b:	83 f8 03             	cmp    $0x3,%eax
80106b8e:	75 05                	jne    80106b95 <trap+0x27b>
    exit();
80106b90:	e8 09 db ff ff       	call   8010469e <exit>
}
80106b95:	83 c4 3c             	add    $0x3c,%esp
80106b98:	5b                   	pop    %ebx
80106b99:	5e                   	pop    %esi
80106b9a:	5f                   	pop    %edi
80106b9b:	5d                   	pop    %ebp
80106b9c:	c3                   	ret    
80106b9d:	00 00                	add    %al,(%eax)
	...

80106ba0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80106ba0:	55                   	push   %ebp
80106ba1:	89 e5                	mov    %esp,%ebp
80106ba3:	83 ec 14             	sub    $0x14,%esp
80106ba6:	8b 45 08             	mov    0x8(%ebp),%eax
80106ba9:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106bad:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106bb1:	89 c2                	mov    %eax,%edx
80106bb3:	ec                   	in     (%dx),%al
80106bb4:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106bb7:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106bbb:	c9                   	leave  
80106bbc:	c3                   	ret    

80106bbd <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106bbd:	55                   	push   %ebp
80106bbe:	89 e5                	mov    %esp,%ebp
80106bc0:	83 ec 08             	sub    $0x8,%esp
80106bc3:	8b 55 08             	mov    0x8(%ebp),%edx
80106bc6:	8b 45 0c             	mov    0xc(%ebp),%eax
80106bc9:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106bcd:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106bd0:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106bd4:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106bd8:	ee                   	out    %al,(%dx)
}
80106bd9:	c9                   	leave  
80106bda:	c3                   	ret    

80106bdb <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106bdb:	55                   	push   %ebp
80106bdc:	89 e5                	mov    %esp,%ebp
80106bde:	83 ec 28             	sub    $0x28,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106be1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106be8:	00 
80106be9:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
80106bf0:	e8 c8 ff ff ff       	call   80106bbd <outb>
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106bf5:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
80106bfc:	00 
80106bfd:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80106c04:	e8 b4 ff ff ff       	call   80106bbd <outb>
  outb(COM1+0, 115200/9600);
80106c09:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
80106c10:	00 
80106c11:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106c18:	e8 a0 ff ff ff       	call   80106bbd <outb>
  outb(COM1+1, 0);
80106c1d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106c24:	00 
80106c25:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80106c2c:	e8 8c ff ff ff       	call   80106bbd <outb>
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106c31:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80106c38:	00 
80106c39:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80106c40:	e8 78 ff ff ff       	call   80106bbd <outb>
  outb(COM1+4, 0);
80106c45:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106c4c:	00 
80106c4d:	c7 04 24 fc 03 00 00 	movl   $0x3fc,(%esp)
80106c54:	e8 64 ff ff ff       	call   80106bbd <outb>
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106c59:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80106c60:	00 
80106c61:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80106c68:	e8 50 ff ff ff       	call   80106bbd <outb>

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106c6d:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106c74:	e8 27 ff ff ff       	call   80106ba0 <inb>
80106c79:	3c ff                	cmp    $0xff,%al
80106c7b:	75 02                	jne    80106c7f <uartinit+0xa4>
    return;
80106c7d:	eb 6a                	jmp    80106ce9 <uartinit+0x10e>
  uart = 1;
80106c7f:	c7 05 6c b6 10 80 01 	movl   $0x1,0x8010b66c
80106c86:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106c89:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
80106c90:	e8 0b ff ff ff       	call   80106ba0 <inb>
  inb(COM1+0);
80106c95:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106c9c:	e8 ff fe ff ff       	call   80106ba0 <inb>
  picenable(IRQ_COM1);
80106ca1:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106ca8:	e8 bc cd ff ff       	call   80103a69 <picenable>
  ioapicenable(IRQ_COM1, 0);
80106cad:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106cb4:	00 
80106cb5:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106cbc:	e8 9b bc ff ff       	call   8010295c <ioapicenable>
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106cc1:	c7 45 f4 58 8c 10 80 	movl   $0x80108c58,-0xc(%ebp)
80106cc8:	eb 15                	jmp    80106cdf <uartinit+0x104>
    uartputc(*p);
80106cca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ccd:	0f b6 00             	movzbl (%eax),%eax
80106cd0:	0f be c0             	movsbl %al,%eax
80106cd3:	89 04 24             	mov    %eax,(%esp)
80106cd6:	e8 10 00 00 00       	call   80106ceb <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106cdb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106cdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ce2:	0f b6 00             	movzbl (%eax),%eax
80106ce5:	84 c0                	test   %al,%al
80106ce7:	75 e1                	jne    80106cca <uartinit+0xef>
    uartputc(*p);
}
80106ce9:	c9                   	leave  
80106cea:	c3                   	ret    

80106ceb <uartputc>:

void
uartputc(int c)
{
80106ceb:	55                   	push   %ebp
80106cec:	89 e5                	mov    %esp,%ebp
80106cee:	83 ec 28             	sub    $0x28,%esp
  int i;

  if(!uart)
80106cf1:	a1 6c b6 10 80       	mov    0x8010b66c,%eax
80106cf6:	85 c0                	test   %eax,%eax
80106cf8:	75 02                	jne    80106cfc <uartputc+0x11>
    return;
80106cfa:	eb 4b                	jmp    80106d47 <uartputc+0x5c>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106cfc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106d03:	eb 10                	jmp    80106d15 <uartputc+0x2a>
    microdelay(10);
80106d05:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80106d0c:	e8 c8 c1 ff ff       	call   80102ed9 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106d11:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106d15:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106d19:	7f 16                	jg     80106d31 <uartputc+0x46>
80106d1b:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106d22:	e8 79 fe ff ff       	call   80106ba0 <inb>
80106d27:	0f b6 c0             	movzbl %al,%eax
80106d2a:	83 e0 20             	and    $0x20,%eax
80106d2d:	85 c0                	test   %eax,%eax
80106d2f:	74 d4                	je     80106d05 <uartputc+0x1a>
    microdelay(10);
  outb(COM1+0, c);
80106d31:	8b 45 08             	mov    0x8(%ebp),%eax
80106d34:	0f b6 c0             	movzbl %al,%eax
80106d37:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d3b:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106d42:	e8 76 fe ff ff       	call   80106bbd <outb>
}
80106d47:	c9                   	leave  
80106d48:	c3                   	ret    

80106d49 <uartgetc>:

static int
uartgetc(void)
{
80106d49:	55                   	push   %ebp
80106d4a:	89 e5                	mov    %esp,%ebp
80106d4c:	83 ec 04             	sub    $0x4,%esp
  if(!uart)
80106d4f:	a1 6c b6 10 80       	mov    0x8010b66c,%eax
80106d54:	85 c0                	test   %eax,%eax
80106d56:	75 07                	jne    80106d5f <uartgetc+0x16>
    return -1;
80106d58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d5d:	eb 2c                	jmp    80106d8b <uartgetc+0x42>
  if(!(inb(COM1+5) & 0x01))
80106d5f:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106d66:	e8 35 fe ff ff       	call   80106ba0 <inb>
80106d6b:	0f b6 c0             	movzbl %al,%eax
80106d6e:	83 e0 01             	and    $0x1,%eax
80106d71:	85 c0                	test   %eax,%eax
80106d73:	75 07                	jne    80106d7c <uartgetc+0x33>
    return -1;
80106d75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d7a:	eb 0f                	jmp    80106d8b <uartgetc+0x42>
  return inb(COM1+0);
80106d7c:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106d83:	e8 18 fe ff ff       	call   80106ba0 <inb>
80106d88:	0f b6 c0             	movzbl %al,%eax
}
80106d8b:	c9                   	leave  
80106d8c:	c3                   	ret    

80106d8d <uartintr>:

void
uartintr(void)
{
80106d8d:	55                   	push   %ebp
80106d8e:	89 e5                	mov    %esp,%ebp
80106d90:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80106d93:	c7 04 24 49 6d 10 80 	movl   $0x80106d49,(%esp)
80106d9a:	e8 0e 9a ff ff       	call   801007ad <consoleintr>
}
80106d9f:	c9                   	leave  
80106da0:	c3                   	ret    
80106da1:	00 00                	add    %al,(%eax)
	...

80106da4 <vector0>:
80106da4:	6a 00                	push   $0x0
80106da6:	6a 00                	push   $0x0
80106da8:	e9 77 f9 ff ff       	jmp    80106724 <alltraps>

80106dad <vector1>:
80106dad:	6a 00                	push   $0x0
80106daf:	6a 01                	push   $0x1
80106db1:	e9 6e f9 ff ff       	jmp    80106724 <alltraps>

80106db6 <vector2>:
80106db6:	6a 00                	push   $0x0
80106db8:	6a 02                	push   $0x2
80106dba:	e9 65 f9 ff ff       	jmp    80106724 <alltraps>

80106dbf <vector3>:
80106dbf:	6a 00                	push   $0x0
80106dc1:	6a 03                	push   $0x3
80106dc3:	e9 5c f9 ff ff       	jmp    80106724 <alltraps>

80106dc8 <vector4>:
80106dc8:	6a 00                	push   $0x0
80106dca:	6a 04                	push   $0x4
80106dcc:	e9 53 f9 ff ff       	jmp    80106724 <alltraps>

80106dd1 <vector5>:
80106dd1:	6a 00                	push   $0x0
80106dd3:	6a 05                	push   $0x5
80106dd5:	e9 4a f9 ff ff       	jmp    80106724 <alltraps>

80106dda <vector6>:
80106dda:	6a 00                	push   $0x0
80106ddc:	6a 06                	push   $0x6
80106dde:	e9 41 f9 ff ff       	jmp    80106724 <alltraps>

80106de3 <vector7>:
80106de3:	6a 00                	push   $0x0
80106de5:	6a 07                	push   $0x7
80106de7:	e9 38 f9 ff ff       	jmp    80106724 <alltraps>

80106dec <vector8>:
80106dec:	6a 08                	push   $0x8
80106dee:	e9 31 f9 ff ff       	jmp    80106724 <alltraps>

80106df3 <vector9>:
80106df3:	6a 00                	push   $0x0
80106df5:	6a 09                	push   $0x9
80106df7:	e9 28 f9 ff ff       	jmp    80106724 <alltraps>

80106dfc <vector10>:
80106dfc:	6a 0a                	push   $0xa
80106dfe:	e9 21 f9 ff ff       	jmp    80106724 <alltraps>

80106e03 <vector11>:
80106e03:	6a 0b                	push   $0xb
80106e05:	e9 1a f9 ff ff       	jmp    80106724 <alltraps>

80106e0a <vector12>:
80106e0a:	6a 0c                	push   $0xc
80106e0c:	e9 13 f9 ff ff       	jmp    80106724 <alltraps>

80106e11 <vector13>:
80106e11:	6a 0d                	push   $0xd
80106e13:	e9 0c f9 ff ff       	jmp    80106724 <alltraps>

80106e18 <vector14>:
80106e18:	6a 0e                	push   $0xe
80106e1a:	e9 05 f9 ff ff       	jmp    80106724 <alltraps>

80106e1f <vector15>:
80106e1f:	6a 00                	push   $0x0
80106e21:	6a 0f                	push   $0xf
80106e23:	e9 fc f8 ff ff       	jmp    80106724 <alltraps>

80106e28 <vector16>:
80106e28:	6a 00                	push   $0x0
80106e2a:	6a 10                	push   $0x10
80106e2c:	e9 f3 f8 ff ff       	jmp    80106724 <alltraps>

80106e31 <vector17>:
80106e31:	6a 11                	push   $0x11
80106e33:	e9 ec f8 ff ff       	jmp    80106724 <alltraps>

80106e38 <vector18>:
80106e38:	6a 00                	push   $0x0
80106e3a:	6a 12                	push   $0x12
80106e3c:	e9 e3 f8 ff ff       	jmp    80106724 <alltraps>

80106e41 <vector19>:
80106e41:	6a 00                	push   $0x0
80106e43:	6a 13                	push   $0x13
80106e45:	e9 da f8 ff ff       	jmp    80106724 <alltraps>

80106e4a <vector20>:
80106e4a:	6a 00                	push   $0x0
80106e4c:	6a 14                	push   $0x14
80106e4e:	e9 d1 f8 ff ff       	jmp    80106724 <alltraps>

80106e53 <vector21>:
80106e53:	6a 00                	push   $0x0
80106e55:	6a 15                	push   $0x15
80106e57:	e9 c8 f8 ff ff       	jmp    80106724 <alltraps>

80106e5c <vector22>:
80106e5c:	6a 00                	push   $0x0
80106e5e:	6a 16                	push   $0x16
80106e60:	e9 bf f8 ff ff       	jmp    80106724 <alltraps>

80106e65 <vector23>:
80106e65:	6a 00                	push   $0x0
80106e67:	6a 17                	push   $0x17
80106e69:	e9 b6 f8 ff ff       	jmp    80106724 <alltraps>

80106e6e <vector24>:
80106e6e:	6a 00                	push   $0x0
80106e70:	6a 18                	push   $0x18
80106e72:	e9 ad f8 ff ff       	jmp    80106724 <alltraps>

80106e77 <vector25>:
80106e77:	6a 00                	push   $0x0
80106e79:	6a 19                	push   $0x19
80106e7b:	e9 a4 f8 ff ff       	jmp    80106724 <alltraps>

80106e80 <vector26>:
80106e80:	6a 00                	push   $0x0
80106e82:	6a 1a                	push   $0x1a
80106e84:	e9 9b f8 ff ff       	jmp    80106724 <alltraps>

80106e89 <vector27>:
80106e89:	6a 00                	push   $0x0
80106e8b:	6a 1b                	push   $0x1b
80106e8d:	e9 92 f8 ff ff       	jmp    80106724 <alltraps>

80106e92 <vector28>:
80106e92:	6a 00                	push   $0x0
80106e94:	6a 1c                	push   $0x1c
80106e96:	e9 89 f8 ff ff       	jmp    80106724 <alltraps>

80106e9b <vector29>:
80106e9b:	6a 00                	push   $0x0
80106e9d:	6a 1d                	push   $0x1d
80106e9f:	e9 80 f8 ff ff       	jmp    80106724 <alltraps>

80106ea4 <vector30>:
80106ea4:	6a 00                	push   $0x0
80106ea6:	6a 1e                	push   $0x1e
80106ea8:	e9 77 f8 ff ff       	jmp    80106724 <alltraps>

80106ead <vector31>:
80106ead:	6a 00                	push   $0x0
80106eaf:	6a 1f                	push   $0x1f
80106eb1:	e9 6e f8 ff ff       	jmp    80106724 <alltraps>

80106eb6 <vector32>:
80106eb6:	6a 00                	push   $0x0
80106eb8:	6a 20                	push   $0x20
80106eba:	e9 65 f8 ff ff       	jmp    80106724 <alltraps>

80106ebf <vector33>:
80106ebf:	6a 00                	push   $0x0
80106ec1:	6a 21                	push   $0x21
80106ec3:	e9 5c f8 ff ff       	jmp    80106724 <alltraps>

80106ec8 <vector34>:
80106ec8:	6a 00                	push   $0x0
80106eca:	6a 22                	push   $0x22
80106ecc:	e9 53 f8 ff ff       	jmp    80106724 <alltraps>

80106ed1 <vector35>:
80106ed1:	6a 00                	push   $0x0
80106ed3:	6a 23                	push   $0x23
80106ed5:	e9 4a f8 ff ff       	jmp    80106724 <alltraps>

80106eda <vector36>:
80106eda:	6a 00                	push   $0x0
80106edc:	6a 24                	push   $0x24
80106ede:	e9 41 f8 ff ff       	jmp    80106724 <alltraps>

80106ee3 <vector37>:
80106ee3:	6a 00                	push   $0x0
80106ee5:	6a 25                	push   $0x25
80106ee7:	e9 38 f8 ff ff       	jmp    80106724 <alltraps>

80106eec <vector38>:
80106eec:	6a 00                	push   $0x0
80106eee:	6a 26                	push   $0x26
80106ef0:	e9 2f f8 ff ff       	jmp    80106724 <alltraps>

80106ef5 <vector39>:
80106ef5:	6a 00                	push   $0x0
80106ef7:	6a 27                	push   $0x27
80106ef9:	e9 26 f8 ff ff       	jmp    80106724 <alltraps>

80106efe <vector40>:
80106efe:	6a 00                	push   $0x0
80106f00:	6a 28                	push   $0x28
80106f02:	e9 1d f8 ff ff       	jmp    80106724 <alltraps>

80106f07 <vector41>:
80106f07:	6a 00                	push   $0x0
80106f09:	6a 29                	push   $0x29
80106f0b:	e9 14 f8 ff ff       	jmp    80106724 <alltraps>

80106f10 <vector42>:
80106f10:	6a 00                	push   $0x0
80106f12:	6a 2a                	push   $0x2a
80106f14:	e9 0b f8 ff ff       	jmp    80106724 <alltraps>

80106f19 <vector43>:
80106f19:	6a 00                	push   $0x0
80106f1b:	6a 2b                	push   $0x2b
80106f1d:	e9 02 f8 ff ff       	jmp    80106724 <alltraps>

80106f22 <vector44>:
80106f22:	6a 00                	push   $0x0
80106f24:	6a 2c                	push   $0x2c
80106f26:	e9 f9 f7 ff ff       	jmp    80106724 <alltraps>

80106f2b <vector45>:
80106f2b:	6a 00                	push   $0x0
80106f2d:	6a 2d                	push   $0x2d
80106f2f:	e9 f0 f7 ff ff       	jmp    80106724 <alltraps>

80106f34 <vector46>:
80106f34:	6a 00                	push   $0x0
80106f36:	6a 2e                	push   $0x2e
80106f38:	e9 e7 f7 ff ff       	jmp    80106724 <alltraps>

80106f3d <vector47>:
80106f3d:	6a 00                	push   $0x0
80106f3f:	6a 2f                	push   $0x2f
80106f41:	e9 de f7 ff ff       	jmp    80106724 <alltraps>

80106f46 <vector48>:
80106f46:	6a 00                	push   $0x0
80106f48:	6a 30                	push   $0x30
80106f4a:	e9 d5 f7 ff ff       	jmp    80106724 <alltraps>

80106f4f <vector49>:
80106f4f:	6a 00                	push   $0x0
80106f51:	6a 31                	push   $0x31
80106f53:	e9 cc f7 ff ff       	jmp    80106724 <alltraps>

80106f58 <vector50>:
80106f58:	6a 00                	push   $0x0
80106f5a:	6a 32                	push   $0x32
80106f5c:	e9 c3 f7 ff ff       	jmp    80106724 <alltraps>

80106f61 <vector51>:
80106f61:	6a 00                	push   $0x0
80106f63:	6a 33                	push   $0x33
80106f65:	e9 ba f7 ff ff       	jmp    80106724 <alltraps>

80106f6a <vector52>:
80106f6a:	6a 00                	push   $0x0
80106f6c:	6a 34                	push   $0x34
80106f6e:	e9 b1 f7 ff ff       	jmp    80106724 <alltraps>

80106f73 <vector53>:
80106f73:	6a 00                	push   $0x0
80106f75:	6a 35                	push   $0x35
80106f77:	e9 a8 f7 ff ff       	jmp    80106724 <alltraps>

80106f7c <vector54>:
80106f7c:	6a 00                	push   $0x0
80106f7e:	6a 36                	push   $0x36
80106f80:	e9 9f f7 ff ff       	jmp    80106724 <alltraps>

80106f85 <vector55>:
80106f85:	6a 00                	push   $0x0
80106f87:	6a 37                	push   $0x37
80106f89:	e9 96 f7 ff ff       	jmp    80106724 <alltraps>

80106f8e <vector56>:
80106f8e:	6a 00                	push   $0x0
80106f90:	6a 38                	push   $0x38
80106f92:	e9 8d f7 ff ff       	jmp    80106724 <alltraps>

80106f97 <vector57>:
80106f97:	6a 00                	push   $0x0
80106f99:	6a 39                	push   $0x39
80106f9b:	e9 84 f7 ff ff       	jmp    80106724 <alltraps>

80106fa0 <vector58>:
80106fa0:	6a 00                	push   $0x0
80106fa2:	6a 3a                	push   $0x3a
80106fa4:	e9 7b f7 ff ff       	jmp    80106724 <alltraps>

80106fa9 <vector59>:
80106fa9:	6a 00                	push   $0x0
80106fab:	6a 3b                	push   $0x3b
80106fad:	e9 72 f7 ff ff       	jmp    80106724 <alltraps>

80106fb2 <vector60>:
80106fb2:	6a 00                	push   $0x0
80106fb4:	6a 3c                	push   $0x3c
80106fb6:	e9 69 f7 ff ff       	jmp    80106724 <alltraps>

80106fbb <vector61>:
80106fbb:	6a 00                	push   $0x0
80106fbd:	6a 3d                	push   $0x3d
80106fbf:	e9 60 f7 ff ff       	jmp    80106724 <alltraps>

80106fc4 <vector62>:
80106fc4:	6a 00                	push   $0x0
80106fc6:	6a 3e                	push   $0x3e
80106fc8:	e9 57 f7 ff ff       	jmp    80106724 <alltraps>

80106fcd <vector63>:
80106fcd:	6a 00                	push   $0x0
80106fcf:	6a 3f                	push   $0x3f
80106fd1:	e9 4e f7 ff ff       	jmp    80106724 <alltraps>

80106fd6 <vector64>:
80106fd6:	6a 00                	push   $0x0
80106fd8:	6a 40                	push   $0x40
80106fda:	e9 45 f7 ff ff       	jmp    80106724 <alltraps>

80106fdf <vector65>:
80106fdf:	6a 00                	push   $0x0
80106fe1:	6a 41                	push   $0x41
80106fe3:	e9 3c f7 ff ff       	jmp    80106724 <alltraps>

80106fe8 <vector66>:
80106fe8:	6a 00                	push   $0x0
80106fea:	6a 42                	push   $0x42
80106fec:	e9 33 f7 ff ff       	jmp    80106724 <alltraps>

80106ff1 <vector67>:
80106ff1:	6a 00                	push   $0x0
80106ff3:	6a 43                	push   $0x43
80106ff5:	e9 2a f7 ff ff       	jmp    80106724 <alltraps>

80106ffa <vector68>:
80106ffa:	6a 00                	push   $0x0
80106ffc:	6a 44                	push   $0x44
80106ffe:	e9 21 f7 ff ff       	jmp    80106724 <alltraps>

80107003 <vector69>:
80107003:	6a 00                	push   $0x0
80107005:	6a 45                	push   $0x45
80107007:	e9 18 f7 ff ff       	jmp    80106724 <alltraps>

8010700c <vector70>:
8010700c:	6a 00                	push   $0x0
8010700e:	6a 46                	push   $0x46
80107010:	e9 0f f7 ff ff       	jmp    80106724 <alltraps>

80107015 <vector71>:
80107015:	6a 00                	push   $0x0
80107017:	6a 47                	push   $0x47
80107019:	e9 06 f7 ff ff       	jmp    80106724 <alltraps>

8010701e <vector72>:
8010701e:	6a 00                	push   $0x0
80107020:	6a 48                	push   $0x48
80107022:	e9 fd f6 ff ff       	jmp    80106724 <alltraps>

80107027 <vector73>:
80107027:	6a 00                	push   $0x0
80107029:	6a 49                	push   $0x49
8010702b:	e9 f4 f6 ff ff       	jmp    80106724 <alltraps>

80107030 <vector74>:
80107030:	6a 00                	push   $0x0
80107032:	6a 4a                	push   $0x4a
80107034:	e9 eb f6 ff ff       	jmp    80106724 <alltraps>

80107039 <vector75>:
80107039:	6a 00                	push   $0x0
8010703b:	6a 4b                	push   $0x4b
8010703d:	e9 e2 f6 ff ff       	jmp    80106724 <alltraps>

80107042 <vector76>:
80107042:	6a 00                	push   $0x0
80107044:	6a 4c                	push   $0x4c
80107046:	e9 d9 f6 ff ff       	jmp    80106724 <alltraps>

8010704b <vector77>:
8010704b:	6a 00                	push   $0x0
8010704d:	6a 4d                	push   $0x4d
8010704f:	e9 d0 f6 ff ff       	jmp    80106724 <alltraps>

80107054 <vector78>:
80107054:	6a 00                	push   $0x0
80107056:	6a 4e                	push   $0x4e
80107058:	e9 c7 f6 ff ff       	jmp    80106724 <alltraps>

8010705d <vector79>:
8010705d:	6a 00                	push   $0x0
8010705f:	6a 4f                	push   $0x4f
80107061:	e9 be f6 ff ff       	jmp    80106724 <alltraps>

80107066 <vector80>:
80107066:	6a 00                	push   $0x0
80107068:	6a 50                	push   $0x50
8010706a:	e9 b5 f6 ff ff       	jmp    80106724 <alltraps>

8010706f <vector81>:
8010706f:	6a 00                	push   $0x0
80107071:	6a 51                	push   $0x51
80107073:	e9 ac f6 ff ff       	jmp    80106724 <alltraps>

80107078 <vector82>:
80107078:	6a 00                	push   $0x0
8010707a:	6a 52                	push   $0x52
8010707c:	e9 a3 f6 ff ff       	jmp    80106724 <alltraps>

80107081 <vector83>:
80107081:	6a 00                	push   $0x0
80107083:	6a 53                	push   $0x53
80107085:	e9 9a f6 ff ff       	jmp    80106724 <alltraps>

8010708a <vector84>:
8010708a:	6a 00                	push   $0x0
8010708c:	6a 54                	push   $0x54
8010708e:	e9 91 f6 ff ff       	jmp    80106724 <alltraps>

80107093 <vector85>:
80107093:	6a 00                	push   $0x0
80107095:	6a 55                	push   $0x55
80107097:	e9 88 f6 ff ff       	jmp    80106724 <alltraps>

8010709c <vector86>:
8010709c:	6a 00                	push   $0x0
8010709e:	6a 56                	push   $0x56
801070a0:	e9 7f f6 ff ff       	jmp    80106724 <alltraps>

801070a5 <vector87>:
801070a5:	6a 00                	push   $0x0
801070a7:	6a 57                	push   $0x57
801070a9:	e9 76 f6 ff ff       	jmp    80106724 <alltraps>

801070ae <vector88>:
801070ae:	6a 00                	push   $0x0
801070b0:	6a 58                	push   $0x58
801070b2:	e9 6d f6 ff ff       	jmp    80106724 <alltraps>

801070b7 <vector89>:
801070b7:	6a 00                	push   $0x0
801070b9:	6a 59                	push   $0x59
801070bb:	e9 64 f6 ff ff       	jmp    80106724 <alltraps>

801070c0 <vector90>:
801070c0:	6a 00                	push   $0x0
801070c2:	6a 5a                	push   $0x5a
801070c4:	e9 5b f6 ff ff       	jmp    80106724 <alltraps>

801070c9 <vector91>:
801070c9:	6a 00                	push   $0x0
801070cb:	6a 5b                	push   $0x5b
801070cd:	e9 52 f6 ff ff       	jmp    80106724 <alltraps>

801070d2 <vector92>:
801070d2:	6a 00                	push   $0x0
801070d4:	6a 5c                	push   $0x5c
801070d6:	e9 49 f6 ff ff       	jmp    80106724 <alltraps>

801070db <vector93>:
801070db:	6a 00                	push   $0x0
801070dd:	6a 5d                	push   $0x5d
801070df:	e9 40 f6 ff ff       	jmp    80106724 <alltraps>

801070e4 <vector94>:
801070e4:	6a 00                	push   $0x0
801070e6:	6a 5e                	push   $0x5e
801070e8:	e9 37 f6 ff ff       	jmp    80106724 <alltraps>

801070ed <vector95>:
801070ed:	6a 00                	push   $0x0
801070ef:	6a 5f                	push   $0x5f
801070f1:	e9 2e f6 ff ff       	jmp    80106724 <alltraps>

801070f6 <vector96>:
801070f6:	6a 00                	push   $0x0
801070f8:	6a 60                	push   $0x60
801070fa:	e9 25 f6 ff ff       	jmp    80106724 <alltraps>

801070ff <vector97>:
801070ff:	6a 00                	push   $0x0
80107101:	6a 61                	push   $0x61
80107103:	e9 1c f6 ff ff       	jmp    80106724 <alltraps>

80107108 <vector98>:
80107108:	6a 00                	push   $0x0
8010710a:	6a 62                	push   $0x62
8010710c:	e9 13 f6 ff ff       	jmp    80106724 <alltraps>

80107111 <vector99>:
80107111:	6a 00                	push   $0x0
80107113:	6a 63                	push   $0x63
80107115:	e9 0a f6 ff ff       	jmp    80106724 <alltraps>

8010711a <vector100>:
8010711a:	6a 00                	push   $0x0
8010711c:	6a 64                	push   $0x64
8010711e:	e9 01 f6 ff ff       	jmp    80106724 <alltraps>

80107123 <vector101>:
80107123:	6a 00                	push   $0x0
80107125:	6a 65                	push   $0x65
80107127:	e9 f8 f5 ff ff       	jmp    80106724 <alltraps>

8010712c <vector102>:
8010712c:	6a 00                	push   $0x0
8010712e:	6a 66                	push   $0x66
80107130:	e9 ef f5 ff ff       	jmp    80106724 <alltraps>

80107135 <vector103>:
80107135:	6a 00                	push   $0x0
80107137:	6a 67                	push   $0x67
80107139:	e9 e6 f5 ff ff       	jmp    80106724 <alltraps>

8010713e <vector104>:
8010713e:	6a 00                	push   $0x0
80107140:	6a 68                	push   $0x68
80107142:	e9 dd f5 ff ff       	jmp    80106724 <alltraps>

80107147 <vector105>:
80107147:	6a 00                	push   $0x0
80107149:	6a 69                	push   $0x69
8010714b:	e9 d4 f5 ff ff       	jmp    80106724 <alltraps>

80107150 <vector106>:
80107150:	6a 00                	push   $0x0
80107152:	6a 6a                	push   $0x6a
80107154:	e9 cb f5 ff ff       	jmp    80106724 <alltraps>

80107159 <vector107>:
80107159:	6a 00                	push   $0x0
8010715b:	6a 6b                	push   $0x6b
8010715d:	e9 c2 f5 ff ff       	jmp    80106724 <alltraps>

80107162 <vector108>:
80107162:	6a 00                	push   $0x0
80107164:	6a 6c                	push   $0x6c
80107166:	e9 b9 f5 ff ff       	jmp    80106724 <alltraps>

8010716b <vector109>:
8010716b:	6a 00                	push   $0x0
8010716d:	6a 6d                	push   $0x6d
8010716f:	e9 b0 f5 ff ff       	jmp    80106724 <alltraps>

80107174 <vector110>:
80107174:	6a 00                	push   $0x0
80107176:	6a 6e                	push   $0x6e
80107178:	e9 a7 f5 ff ff       	jmp    80106724 <alltraps>

8010717d <vector111>:
8010717d:	6a 00                	push   $0x0
8010717f:	6a 6f                	push   $0x6f
80107181:	e9 9e f5 ff ff       	jmp    80106724 <alltraps>

80107186 <vector112>:
80107186:	6a 00                	push   $0x0
80107188:	6a 70                	push   $0x70
8010718a:	e9 95 f5 ff ff       	jmp    80106724 <alltraps>

8010718f <vector113>:
8010718f:	6a 00                	push   $0x0
80107191:	6a 71                	push   $0x71
80107193:	e9 8c f5 ff ff       	jmp    80106724 <alltraps>

80107198 <vector114>:
80107198:	6a 00                	push   $0x0
8010719a:	6a 72                	push   $0x72
8010719c:	e9 83 f5 ff ff       	jmp    80106724 <alltraps>

801071a1 <vector115>:
801071a1:	6a 00                	push   $0x0
801071a3:	6a 73                	push   $0x73
801071a5:	e9 7a f5 ff ff       	jmp    80106724 <alltraps>

801071aa <vector116>:
801071aa:	6a 00                	push   $0x0
801071ac:	6a 74                	push   $0x74
801071ae:	e9 71 f5 ff ff       	jmp    80106724 <alltraps>

801071b3 <vector117>:
801071b3:	6a 00                	push   $0x0
801071b5:	6a 75                	push   $0x75
801071b7:	e9 68 f5 ff ff       	jmp    80106724 <alltraps>

801071bc <vector118>:
801071bc:	6a 00                	push   $0x0
801071be:	6a 76                	push   $0x76
801071c0:	e9 5f f5 ff ff       	jmp    80106724 <alltraps>

801071c5 <vector119>:
801071c5:	6a 00                	push   $0x0
801071c7:	6a 77                	push   $0x77
801071c9:	e9 56 f5 ff ff       	jmp    80106724 <alltraps>

801071ce <vector120>:
801071ce:	6a 00                	push   $0x0
801071d0:	6a 78                	push   $0x78
801071d2:	e9 4d f5 ff ff       	jmp    80106724 <alltraps>

801071d7 <vector121>:
801071d7:	6a 00                	push   $0x0
801071d9:	6a 79                	push   $0x79
801071db:	e9 44 f5 ff ff       	jmp    80106724 <alltraps>

801071e0 <vector122>:
801071e0:	6a 00                	push   $0x0
801071e2:	6a 7a                	push   $0x7a
801071e4:	e9 3b f5 ff ff       	jmp    80106724 <alltraps>

801071e9 <vector123>:
801071e9:	6a 00                	push   $0x0
801071eb:	6a 7b                	push   $0x7b
801071ed:	e9 32 f5 ff ff       	jmp    80106724 <alltraps>

801071f2 <vector124>:
801071f2:	6a 00                	push   $0x0
801071f4:	6a 7c                	push   $0x7c
801071f6:	e9 29 f5 ff ff       	jmp    80106724 <alltraps>

801071fb <vector125>:
801071fb:	6a 00                	push   $0x0
801071fd:	6a 7d                	push   $0x7d
801071ff:	e9 20 f5 ff ff       	jmp    80106724 <alltraps>

80107204 <vector126>:
80107204:	6a 00                	push   $0x0
80107206:	6a 7e                	push   $0x7e
80107208:	e9 17 f5 ff ff       	jmp    80106724 <alltraps>

8010720d <vector127>:
8010720d:	6a 00                	push   $0x0
8010720f:	6a 7f                	push   $0x7f
80107211:	e9 0e f5 ff ff       	jmp    80106724 <alltraps>

80107216 <vector128>:
80107216:	6a 00                	push   $0x0
80107218:	68 80 00 00 00       	push   $0x80
8010721d:	e9 02 f5 ff ff       	jmp    80106724 <alltraps>

80107222 <vector129>:
80107222:	6a 00                	push   $0x0
80107224:	68 81 00 00 00       	push   $0x81
80107229:	e9 f6 f4 ff ff       	jmp    80106724 <alltraps>

8010722e <vector130>:
8010722e:	6a 00                	push   $0x0
80107230:	68 82 00 00 00       	push   $0x82
80107235:	e9 ea f4 ff ff       	jmp    80106724 <alltraps>

8010723a <vector131>:
8010723a:	6a 00                	push   $0x0
8010723c:	68 83 00 00 00       	push   $0x83
80107241:	e9 de f4 ff ff       	jmp    80106724 <alltraps>

80107246 <vector132>:
80107246:	6a 00                	push   $0x0
80107248:	68 84 00 00 00       	push   $0x84
8010724d:	e9 d2 f4 ff ff       	jmp    80106724 <alltraps>

80107252 <vector133>:
80107252:	6a 00                	push   $0x0
80107254:	68 85 00 00 00       	push   $0x85
80107259:	e9 c6 f4 ff ff       	jmp    80106724 <alltraps>

8010725e <vector134>:
8010725e:	6a 00                	push   $0x0
80107260:	68 86 00 00 00       	push   $0x86
80107265:	e9 ba f4 ff ff       	jmp    80106724 <alltraps>

8010726a <vector135>:
8010726a:	6a 00                	push   $0x0
8010726c:	68 87 00 00 00       	push   $0x87
80107271:	e9 ae f4 ff ff       	jmp    80106724 <alltraps>

80107276 <vector136>:
80107276:	6a 00                	push   $0x0
80107278:	68 88 00 00 00       	push   $0x88
8010727d:	e9 a2 f4 ff ff       	jmp    80106724 <alltraps>

80107282 <vector137>:
80107282:	6a 00                	push   $0x0
80107284:	68 89 00 00 00       	push   $0x89
80107289:	e9 96 f4 ff ff       	jmp    80106724 <alltraps>

8010728e <vector138>:
8010728e:	6a 00                	push   $0x0
80107290:	68 8a 00 00 00       	push   $0x8a
80107295:	e9 8a f4 ff ff       	jmp    80106724 <alltraps>

8010729a <vector139>:
8010729a:	6a 00                	push   $0x0
8010729c:	68 8b 00 00 00       	push   $0x8b
801072a1:	e9 7e f4 ff ff       	jmp    80106724 <alltraps>

801072a6 <vector140>:
801072a6:	6a 00                	push   $0x0
801072a8:	68 8c 00 00 00       	push   $0x8c
801072ad:	e9 72 f4 ff ff       	jmp    80106724 <alltraps>

801072b2 <vector141>:
801072b2:	6a 00                	push   $0x0
801072b4:	68 8d 00 00 00       	push   $0x8d
801072b9:	e9 66 f4 ff ff       	jmp    80106724 <alltraps>

801072be <vector142>:
801072be:	6a 00                	push   $0x0
801072c0:	68 8e 00 00 00       	push   $0x8e
801072c5:	e9 5a f4 ff ff       	jmp    80106724 <alltraps>

801072ca <vector143>:
801072ca:	6a 00                	push   $0x0
801072cc:	68 8f 00 00 00       	push   $0x8f
801072d1:	e9 4e f4 ff ff       	jmp    80106724 <alltraps>

801072d6 <vector144>:
801072d6:	6a 00                	push   $0x0
801072d8:	68 90 00 00 00       	push   $0x90
801072dd:	e9 42 f4 ff ff       	jmp    80106724 <alltraps>

801072e2 <vector145>:
801072e2:	6a 00                	push   $0x0
801072e4:	68 91 00 00 00       	push   $0x91
801072e9:	e9 36 f4 ff ff       	jmp    80106724 <alltraps>

801072ee <vector146>:
801072ee:	6a 00                	push   $0x0
801072f0:	68 92 00 00 00       	push   $0x92
801072f5:	e9 2a f4 ff ff       	jmp    80106724 <alltraps>

801072fa <vector147>:
801072fa:	6a 00                	push   $0x0
801072fc:	68 93 00 00 00       	push   $0x93
80107301:	e9 1e f4 ff ff       	jmp    80106724 <alltraps>

80107306 <vector148>:
80107306:	6a 00                	push   $0x0
80107308:	68 94 00 00 00       	push   $0x94
8010730d:	e9 12 f4 ff ff       	jmp    80106724 <alltraps>

80107312 <vector149>:
80107312:	6a 00                	push   $0x0
80107314:	68 95 00 00 00       	push   $0x95
80107319:	e9 06 f4 ff ff       	jmp    80106724 <alltraps>

8010731e <vector150>:
8010731e:	6a 00                	push   $0x0
80107320:	68 96 00 00 00       	push   $0x96
80107325:	e9 fa f3 ff ff       	jmp    80106724 <alltraps>

8010732a <vector151>:
8010732a:	6a 00                	push   $0x0
8010732c:	68 97 00 00 00       	push   $0x97
80107331:	e9 ee f3 ff ff       	jmp    80106724 <alltraps>

80107336 <vector152>:
80107336:	6a 00                	push   $0x0
80107338:	68 98 00 00 00       	push   $0x98
8010733d:	e9 e2 f3 ff ff       	jmp    80106724 <alltraps>

80107342 <vector153>:
80107342:	6a 00                	push   $0x0
80107344:	68 99 00 00 00       	push   $0x99
80107349:	e9 d6 f3 ff ff       	jmp    80106724 <alltraps>

8010734e <vector154>:
8010734e:	6a 00                	push   $0x0
80107350:	68 9a 00 00 00       	push   $0x9a
80107355:	e9 ca f3 ff ff       	jmp    80106724 <alltraps>

8010735a <vector155>:
8010735a:	6a 00                	push   $0x0
8010735c:	68 9b 00 00 00       	push   $0x9b
80107361:	e9 be f3 ff ff       	jmp    80106724 <alltraps>

80107366 <vector156>:
80107366:	6a 00                	push   $0x0
80107368:	68 9c 00 00 00       	push   $0x9c
8010736d:	e9 b2 f3 ff ff       	jmp    80106724 <alltraps>

80107372 <vector157>:
80107372:	6a 00                	push   $0x0
80107374:	68 9d 00 00 00       	push   $0x9d
80107379:	e9 a6 f3 ff ff       	jmp    80106724 <alltraps>

8010737e <vector158>:
8010737e:	6a 00                	push   $0x0
80107380:	68 9e 00 00 00       	push   $0x9e
80107385:	e9 9a f3 ff ff       	jmp    80106724 <alltraps>

8010738a <vector159>:
8010738a:	6a 00                	push   $0x0
8010738c:	68 9f 00 00 00       	push   $0x9f
80107391:	e9 8e f3 ff ff       	jmp    80106724 <alltraps>

80107396 <vector160>:
80107396:	6a 00                	push   $0x0
80107398:	68 a0 00 00 00       	push   $0xa0
8010739d:	e9 82 f3 ff ff       	jmp    80106724 <alltraps>

801073a2 <vector161>:
801073a2:	6a 00                	push   $0x0
801073a4:	68 a1 00 00 00       	push   $0xa1
801073a9:	e9 76 f3 ff ff       	jmp    80106724 <alltraps>

801073ae <vector162>:
801073ae:	6a 00                	push   $0x0
801073b0:	68 a2 00 00 00       	push   $0xa2
801073b5:	e9 6a f3 ff ff       	jmp    80106724 <alltraps>

801073ba <vector163>:
801073ba:	6a 00                	push   $0x0
801073bc:	68 a3 00 00 00       	push   $0xa3
801073c1:	e9 5e f3 ff ff       	jmp    80106724 <alltraps>

801073c6 <vector164>:
801073c6:	6a 00                	push   $0x0
801073c8:	68 a4 00 00 00       	push   $0xa4
801073cd:	e9 52 f3 ff ff       	jmp    80106724 <alltraps>

801073d2 <vector165>:
801073d2:	6a 00                	push   $0x0
801073d4:	68 a5 00 00 00       	push   $0xa5
801073d9:	e9 46 f3 ff ff       	jmp    80106724 <alltraps>

801073de <vector166>:
801073de:	6a 00                	push   $0x0
801073e0:	68 a6 00 00 00       	push   $0xa6
801073e5:	e9 3a f3 ff ff       	jmp    80106724 <alltraps>

801073ea <vector167>:
801073ea:	6a 00                	push   $0x0
801073ec:	68 a7 00 00 00       	push   $0xa7
801073f1:	e9 2e f3 ff ff       	jmp    80106724 <alltraps>

801073f6 <vector168>:
801073f6:	6a 00                	push   $0x0
801073f8:	68 a8 00 00 00       	push   $0xa8
801073fd:	e9 22 f3 ff ff       	jmp    80106724 <alltraps>

80107402 <vector169>:
80107402:	6a 00                	push   $0x0
80107404:	68 a9 00 00 00       	push   $0xa9
80107409:	e9 16 f3 ff ff       	jmp    80106724 <alltraps>

8010740e <vector170>:
8010740e:	6a 00                	push   $0x0
80107410:	68 aa 00 00 00       	push   $0xaa
80107415:	e9 0a f3 ff ff       	jmp    80106724 <alltraps>

8010741a <vector171>:
8010741a:	6a 00                	push   $0x0
8010741c:	68 ab 00 00 00       	push   $0xab
80107421:	e9 fe f2 ff ff       	jmp    80106724 <alltraps>

80107426 <vector172>:
80107426:	6a 00                	push   $0x0
80107428:	68 ac 00 00 00       	push   $0xac
8010742d:	e9 f2 f2 ff ff       	jmp    80106724 <alltraps>

80107432 <vector173>:
80107432:	6a 00                	push   $0x0
80107434:	68 ad 00 00 00       	push   $0xad
80107439:	e9 e6 f2 ff ff       	jmp    80106724 <alltraps>

8010743e <vector174>:
8010743e:	6a 00                	push   $0x0
80107440:	68 ae 00 00 00       	push   $0xae
80107445:	e9 da f2 ff ff       	jmp    80106724 <alltraps>

8010744a <vector175>:
8010744a:	6a 00                	push   $0x0
8010744c:	68 af 00 00 00       	push   $0xaf
80107451:	e9 ce f2 ff ff       	jmp    80106724 <alltraps>

80107456 <vector176>:
80107456:	6a 00                	push   $0x0
80107458:	68 b0 00 00 00       	push   $0xb0
8010745d:	e9 c2 f2 ff ff       	jmp    80106724 <alltraps>

80107462 <vector177>:
80107462:	6a 00                	push   $0x0
80107464:	68 b1 00 00 00       	push   $0xb1
80107469:	e9 b6 f2 ff ff       	jmp    80106724 <alltraps>

8010746e <vector178>:
8010746e:	6a 00                	push   $0x0
80107470:	68 b2 00 00 00       	push   $0xb2
80107475:	e9 aa f2 ff ff       	jmp    80106724 <alltraps>

8010747a <vector179>:
8010747a:	6a 00                	push   $0x0
8010747c:	68 b3 00 00 00       	push   $0xb3
80107481:	e9 9e f2 ff ff       	jmp    80106724 <alltraps>

80107486 <vector180>:
80107486:	6a 00                	push   $0x0
80107488:	68 b4 00 00 00       	push   $0xb4
8010748d:	e9 92 f2 ff ff       	jmp    80106724 <alltraps>

80107492 <vector181>:
80107492:	6a 00                	push   $0x0
80107494:	68 b5 00 00 00       	push   $0xb5
80107499:	e9 86 f2 ff ff       	jmp    80106724 <alltraps>

8010749e <vector182>:
8010749e:	6a 00                	push   $0x0
801074a0:	68 b6 00 00 00       	push   $0xb6
801074a5:	e9 7a f2 ff ff       	jmp    80106724 <alltraps>

801074aa <vector183>:
801074aa:	6a 00                	push   $0x0
801074ac:	68 b7 00 00 00       	push   $0xb7
801074b1:	e9 6e f2 ff ff       	jmp    80106724 <alltraps>

801074b6 <vector184>:
801074b6:	6a 00                	push   $0x0
801074b8:	68 b8 00 00 00       	push   $0xb8
801074bd:	e9 62 f2 ff ff       	jmp    80106724 <alltraps>

801074c2 <vector185>:
801074c2:	6a 00                	push   $0x0
801074c4:	68 b9 00 00 00       	push   $0xb9
801074c9:	e9 56 f2 ff ff       	jmp    80106724 <alltraps>

801074ce <vector186>:
801074ce:	6a 00                	push   $0x0
801074d0:	68 ba 00 00 00       	push   $0xba
801074d5:	e9 4a f2 ff ff       	jmp    80106724 <alltraps>

801074da <vector187>:
801074da:	6a 00                	push   $0x0
801074dc:	68 bb 00 00 00       	push   $0xbb
801074e1:	e9 3e f2 ff ff       	jmp    80106724 <alltraps>

801074e6 <vector188>:
801074e6:	6a 00                	push   $0x0
801074e8:	68 bc 00 00 00       	push   $0xbc
801074ed:	e9 32 f2 ff ff       	jmp    80106724 <alltraps>

801074f2 <vector189>:
801074f2:	6a 00                	push   $0x0
801074f4:	68 bd 00 00 00       	push   $0xbd
801074f9:	e9 26 f2 ff ff       	jmp    80106724 <alltraps>

801074fe <vector190>:
801074fe:	6a 00                	push   $0x0
80107500:	68 be 00 00 00       	push   $0xbe
80107505:	e9 1a f2 ff ff       	jmp    80106724 <alltraps>

8010750a <vector191>:
8010750a:	6a 00                	push   $0x0
8010750c:	68 bf 00 00 00       	push   $0xbf
80107511:	e9 0e f2 ff ff       	jmp    80106724 <alltraps>

80107516 <vector192>:
80107516:	6a 00                	push   $0x0
80107518:	68 c0 00 00 00       	push   $0xc0
8010751d:	e9 02 f2 ff ff       	jmp    80106724 <alltraps>

80107522 <vector193>:
80107522:	6a 00                	push   $0x0
80107524:	68 c1 00 00 00       	push   $0xc1
80107529:	e9 f6 f1 ff ff       	jmp    80106724 <alltraps>

8010752e <vector194>:
8010752e:	6a 00                	push   $0x0
80107530:	68 c2 00 00 00       	push   $0xc2
80107535:	e9 ea f1 ff ff       	jmp    80106724 <alltraps>

8010753a <vector195>:
8010753a:	6a 00                	push   $0x0
8010753c:	68 c3 00 00 00       	push   $0xc3
80107541:	e9 de f1 ff ff       	jmp    80106724 <alltraps>

80107546 <vector196>:
80107546:	6a 00                	push   $0x0
80107548:	68 c4 00 00 00       	push   $0xc4
8010754d:	e9 d2 f1 ff ff       	jmp    80106724 <alltraps>

80107552 <vector197>:
80107552:	6a 00                	push   $0x0
80107554:	68 c5 00 00 00       	push   $0xc5
80107559:	e9 c6 f1 ff ff       	jmp    80106724 <alltraps>

8010755e <vector198>:
8010755e:	6a 00                	push   $0x0
80107560:	68 c6 00 00 00       	push   $0xc6
80107565:	e9 ba f1 ff ff       	jmp    80106724 <alltraps>

8010756a <vector199>:
8010756a:	6a 00                	push   $0x0
8010756c:	68 c7 00 00 00       	push   $0xc7
80107571:	e9 ae f1 ff ff       	jmp    80106724 <alltraps>

80107576 <vector200>:
80107576:	6a 00                	push   $0x0
80107578:	68 c8 00 00 00       	push   $0xc8
8010757d:	e9 a2 f1 ff ff       	jmp    80106724 <alltraps>

80107582 <vector201>:
80107582:	6a 00                	push   $0x0
80107584:	68 c9 00 00 00       	push   $0xc9
80107589:	e9 96 f1 ff ff       	jmp    80106724 <alltraps>

8010758e <vector202>:
8010758e:	6a 00                	push   $0x0
80107590:	68 ca 00 00 00       	push   $0xca
80107595:	e9 8a f1 ff ff       	jmp    80106724 <alltraps>

8010759a <vector203>:
8010759a:	6a 00                	push   $0x0
8010759c:	68 cb 00 00 00       	push   $0xcb
801075a1:	e9 7e f1 ff ff       	jmp    80106724 <alltraps>

801075a6 <vector204>:
801075a6:	6a 00                	push   $0x0
801075a8:	68 cc 00 00 00       	push   $0xcc
801075ad:	e9 72 f1 ff ff       	jmp    80106724 <alltraps>

801075b2 <vector205>:
801075b2:	6a 00                	push   $0x0
801075b4:	68 cd 00 00 00       	push   $0xcd
801075b9:	e9 66 f1 ff ff       	jmp    80106724 <alltraps>

801075be <vector206>:
801075be:	6a 00                	push   $0x0
801075c0:	68 ce 00 00 00       	push   $0xce
801075c5:	e9 5a f1 ff ff       	jmp    80106724 <alltraps>

801075ca <vector207>:
801075ca:	6a 00                	push   $0x0
801075cc:	68 cf 00 00 00       	push   $0xcf
801075d1:	e9 4e f1 ff ff       	jmp    80106724 <alltraps>

801075d6 <vector208>:
801075d6:	6a 00                	push   $0x0
801075d8:	68 d0 00 00 00       	push   $0xd0
801075dd:	e9 42 f1 ff ff       	jmp    80106724 <alltraps>

801075e2 <vector209>:
801075e2:	6a 00                	push   $0x0
801075e4:	68 d1 00 00 00       	push   $0xd1
801075e9:	e9 36 f1 ff ff       	jmp    80106724 <alltraps>

801075ee <vector210>:
801075ee:	6a 00                	push   $0x0
801075f0:	68 d2 00 00 00       	push   $0xd2
801075f5:	e9 2a f1 ff ff       	jmp    80106724 <alltraps>

801075fa <vector211>:
801075fa:	6a 00                	push   $0x0
801075fc:	68 d3 00 00 00       	push   $0xd3
80107601:	e9 1e f1 ff ff       	jmp    80106724 <alltraps>

80107606 <vector212>:
80107606:	6a 00                	push   $0x0
80107608:	68 d4 00 00 00       	push   $0xd4
8010760d:	e9 12 f1 ff ff       	jmp    80106724 <alltraps>

80107612 <vector213>:
80107612:	6a 00                	push   $0x0
80107614:	68 d5 00 00 00       	push   $0xd5
80107619:	e9 06 f1 ff ff       	jmp    80106724 <alltraps>

8010761e <vector214>:
8010761e:	6a 00                	push   $0x0
80107620:	68 d6 00 00 00       	push   $0xd6
80107625:	e9 fa f0 ff ff       	jmp    80106724 <alltraps>

8010762a <vector215>:
8010762a:	6a 00                	push   $0x0
8010762c:	68 d7 00 00 00       	push   $0xd7
80107631:	e9 ee f0 ff ff       	jmp    80106724 <alltraps>

80107636 <vector216>:
80107636:	6a 00                	push   $0x0
80107638:	68 d8 00 00 00       	push   $0xd8
8010763d:	e9 e2 f0 ff ff       	jmp    80106724 <alltraps>

80107642 <vector217>:
80107642:	6a 00                	push   $0x0
80107644:	68 d9 00 00 00       	push   $0xd9
80107649:	e9 d6 f0 ff ff       	jmp    80106724 <alltraps>

8010764e <vector218>:
8010764e:	6a 00                	push   $0x0
80107650:	68 da 00 00 00       	push   $0xda
80107655:	e9 ca f0 ff ff       	jmp    80106724 <alltraps>

8010765a <vector219>:
8010765a:	6a 00                	push   $0x0
8010765c:	68 db 00 00 00       	push   $0xdb
80107661:	e9 be f0 ff ff       	jmp    80106724 <alltraps>

80107666 <vector220>:
80107666:	6a 00                	push   $0x0
80107668:	68 dc 00 00 00       	push   $0xdc
8010766d:	e9 b2 f0 ff ff       	jmp    80106724 <alltraps>

80107672 <vector221>:
80107672:	6a 00                	push   $0x0
80107674:	68 dd 00 00 00       	push   $0xdd
80107679:	e9 a6 f0 ff ff       	jmp    80106724 <alltraps>

8010767e <vector222>:
8010767e:	6a 00                	push   $0x0
80107680:	68 de 00 00 00       	push   $0xde
80107685:	e9 9a f0 ff ff       	jmp    80106724 <alltraps>

8010768a <vector223>:
8010768a:	6a 00                	push   $0x0
8010768c:	68 df 00 00 00       	push   $0xdf
80107691:	e9 8e f0 ff ff       	jmp    80106724 <alltraps>

80107696 <vector224>:
80107696:	6a 00                	push   $0x0
80107698:	68 e0 00 00 00       	push   $0xe0
8010769d:	e9 82 f0 ff ff       	jmp    80106724 <alltraps>

801076a2 <vector225>:
801076a2:	6a 00                	push   $0x0
801076a4:	68 e1 00 00 00       	push   $0xe1
801076a9:	e9 76 f0 ff ff       	jmp    80106724 <alltraps>

801076ae <vector226>:
801076ae:	6a 00                	push   $0x0
801076b0:	68 e2 00 00 00       	push   $0xe2
801076b5:	e9 6a f0 ff ff       	jmp    80106724 <alltraps>

801076ba <vector227>:
801076ba:	6a 00                	push   $0x0
801076bc:	68 e3 00 00 00       	push   $0xe3
801076c1:	e9 5e f0 ff ff       	jmp    80106724 <alltraps>

801076c6 <vector228>:
801076c6:	6a 00                	push   $0x0
801076c8:	68 e4 00 00 00       	push   $0xe4
801076cd:	e9 52 f0 ff ff       	jmp    80106724 <alltraps>

801076d2 <vector229>:
801076d2:	6a 00                	push   $0x0
801076d4:	68 e5 00 00 00       	push   $0xe5
801076d9:	e9 46 f0 ff ff       	jmp    80106724 <alltraps>

801076de <vector230>:
801076de:	6a 00                	push   $0x0
801076e0:	68 e6 00 00 00       	push   $0xe6
801076e5:	e9 3a f0 ff ff       	jmp    80106724 <alltraps>

801076ea <vector231>:
801076ea:	6a 00                	push   $0x0
801076ec:	68 e7 00 00 00       	push   $0xe7
801076f1:	e9 2e f0 ff ff       	jmp    80106724 <alltraps>

801076f6 <vector232>:
801076f6:	6a 00                	push   $0x0
801076f8:	68 e8 00 00 00       	push   $0xe8
801076fd:	e9 22 f0 ff ff       	jmp    80106724 <alltraps>

80107702 <vector233>:
80107702:	6a 00                	push   $0x0
80107704:	68 e9 00 00 00       	push   $0xe9
80107709:	e9 16 f0 ff ff       	jmp    80106724 <alltraps>

8010770e <vector234>:
8010770e:	6a 00                	push   $0x0
80107710:	68 ea 00 00 00       	push   $0xea
80107715:	e9 0a f0 ff ff       	jmp    80106724 <alltraps>

8010771a <vector235>:
8010771a:	6a 00                	push   $0x0
8010771c:	68 eb 00 00 00       	push   $0xeb
80107721:	e9 fe ef ff ff       	jmp    80106724 <alltraps>

80107726 <vector236>:
80107726:	6a 00                	push   $0x0
80107728:	68 ec 00 00 00       	push   $0xec
8010772d:	e9 f2 ef ff ff       	jmp    80106724 <alltraps>

80107732 <vector237>:
80107732:	6a 00                	push   $0x0
80107734:	68 ed 00 00 00       	push   $0xed
80107739:	e9 e6 ef ff ff       	jmp    80106724 <alltraps>

8010773e <vector238>:
8010773e:	6a 00                	push   $0x0
80107740:	68 ee 00 00 00       	push   $0xee
80107745:	e9 da ef ff ff       	jmp    80106724 <alltraps>

8010774a <vector239>:
8010774a:	6a 00                	push   $0x0
8010774c:	68 ef 00 00 00       	push   $0xef
80107751:	e9 ce ef ff ff       	jmp    80106724 <alltraps>

80107756 <vector240>:
80107756:	6a 00                	push   $0x0
80107758:	68 f0 00 00 00       	push   $0xf0
8010775d:	e9 c2 ef ff ff       	jmp    80106724 <alltraps>

80107762 <vector241>:
80107762:	6a 00                	push   $0x0
80107764:	68 f1 00 00 00       	push   $0xf1
80107769:	e9 b6 ef ff ff       	jmp    80106724 <alltraps>

8010776e <vector242>:
8010776e:	6a 00                	push   $0x0
80107770:	68 f2 00 00 00       	push   $0xf2
80107775:	e9 aa ef ff ff       	jmp    80106724 <alltraps>

8010777a <vector243>:
8010777a:	6a 00                	push   $0x0
8010777c:	68 f3 00 00 00       	push   $0xf3
80107781:	e9 9e ef ff ff       	jmp    80106724 <alltraps>

80107786 <vector244>:
80107786:	6a 00                	push   $0x0
80107788:	68 f4 00 00 00       	push   $0xf4
8010778d:	e9 92 ef ff ff       	jmp    80106724 <alltraps>

80107792 <vector245>:
80107792:	6a 00                	push   $0x0
80107794:	68 f5 00 00 00       	push   $0xf5
80107799:	e9 86 ef ff ff       	jmp    80106724 <alltraps>

8010779e <vector246>:
8010779e:	6a 00                	push   $0x0
801077a0:	68 f6 00 00 00       	push   $0xf6
801077a5:	e9 7a ef ff ff       	jmp    80106724 <alltraps>

801077aa <vector247>:
801077aa:	6a 00                	push   $0x0
801077ac:	68 f7 00 00 00       	push   $0xf7
801077b1:	e9 6e ef ff ff       	jmp    80106724 <alltraps>

801077b6 <vector248>:
801077b6:	6a 00                	push   $0x0
801077b8:	68 f8 00 00 00       	push   $0xf8
801077bd:	e9 62 ef ff ff       	jmp    80106724 <alltraps>

801077c2 <vector249>:
801077c2:	6a 00                	push   $0x0
801077c4:	68 f9 00 00 00       	push   $0xf9
801077c9:	e9 56 ef ff ff       	jmp    80106724 <alltraps>

801077ce <vector250>:
801077ce:	6a 00                	push   $0x0
801077d0:	68 fa 00 00 00       	push   $0xfa
801077d5:	e9 4a ef ff ff       	jmp    80106724 <alltraps>

801077da <vector251>:
801077da:	6a 00                	push   $0x0
801077dc:	68 fb 00 00 00       	push   $0xfb
801077e1:	e9 3e ef ff ff       	jmp    80106724 <alltraps>

801077e6 <vector252>:
801077e6:	6a 00                	push   $0x0
801077e8:	68 fc 00 00 00       	push   $0xfc
801077ed:	e9 32 ef ff ff       	jmp    80106724 <alltraps>

801077f2 <vector253>:
801077f2:	6a 00                	push   $0x0
801077f4:	68 fd 00 00 00       	push   $0xfd
801077f9:	e9 26 ef ff ff       	jmp    80106724 <alltraps>

801077fe <vector254>:
801077fe:	6a 00                	push   $0x0
80107800:	68 fe 00 00 00       	push   $0xfe
80107805:	e9 1a ef ff ff       	jmp    80106724 <alltraps>

8010780a <vector255>:
8010780a:	6a 00                	push   $0x0
8010780c:	68 ff 00 00 00       	push   $0xff
80107811:	e9 0e ef ff ff       	jmp    80106724 <alltraps>
	...

80107818 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80107818:	55                   	push   %ebp
80107819:	89 e5                	mov    %esp,%ebp
8010781b:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
8010781e:	8b 45 0c             	mov    0xc(%ebp),%eax
80107821:	83 e8 01             	sub    $0x1,%eax
80107824:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107828:	8b 45 08             	mov    0x8(%ebp),%eax
8010782b:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010782f:	8b 45 08             	mov    0x8(%ebp),%eax
80107832:	c1 e8 10             	shr    $0x10,%eax
80107835:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107839:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010783c:	0f 01 10             	lgdtl  (%eax)
}
8010783f:	c9                   	leave  
80107840:	c3                   	ret    

80107841 <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
80107841:	55                   	push   %ebp
80107842:	89 e5                	mov    %esp,%ebp
80107844:	83 ec 04             	sub    $0x4,%esp
80107847:	8b 45 08             	mov    0x8(%ebp),%eax
8010784a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
8010784e:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107852:	0f 00 d8             	ltr    %ax
}
80107855:	c9                   	leave  
80107856:	c3                   	ret    

80107857 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80107857:	55                   	push   %ebp
80107858:	89 e5                	mov    %esp,%ebp
8010785a:	83 ec 04             	sub    $0x4,%esp
8010785d:	8b 45 08             	mov    0x8(%ebp),%eax
80107860:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80107864:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107868:	8e e8                	mov    %eax,%gs
}
8010786a:	c9                   	leave  
8010786b:	c3                   	ret    

8010786c <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
8010786c:	55                   	push   %ebp
8010786d:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010786f:	8b 45 08             	mov    0x8(%ebp),%eax
80107872:	0f 22 d8             	mov    %eax,%cr3
}
80107875:	5d                   	pop    %ebp
80107876:	c3                   	ret    

80107877 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80107877:	55                   	push   %ebp
80107878:	89 e5                	mov    %esp,%ebp
8010787a:	8b 45 08             	mov    0x8(%ebp),%eax
8010787d:	05 00 00 00 80       	add    $0x80000000,%eax
80107882:	5d                   	pop    %ebp
80107883:	c3                   	ret    

80107884 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80107884:	55                   	push   %ebp
80107885:	89 e5                	mov    %esp,%ebp
80107887:	8b 45 08             	mov    0x8(%ebp),%eax
8010788a:	05 00 00 00 80       	add    $0x80000000,%eax
8010788f:	5d                   	pop    %ebp
80107890:	c3                   	ret    

80107891 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107891:	55                   	push   %ebp
80107892:	89 e5                	mov    %esp,%ebp
80107894:	53                   	push   %ebx
80107895:	83 ec 24             	sub    $0x24,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107898:	e8 bf b5 ff ff       	call   80102e5c <cpunum>
8010789d:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801078a3:	05 40 f9 10 80       	add    $0x8010f940,%eax
801078a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801078ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078ae:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801078b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078b7:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801078bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078c0:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801078c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078c7:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801078cb:	83 e2 f0             	and    $0xfffffff0,%edx
801078ce:	83 ca 0a             	or     $0xa,%edx
801078d1:	88 50 7d             	mov    %dl,0x7d(%eax)
801078d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078d7:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801078db:	83 ca 10             	or     $0x10,%edx
801078de:	88 50 7d             	mov    %dl,0x7d(%eax)
801078e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078e4:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801078e8:	83 e2 9f             	and    $0xffffff9f,%edx
801078eb:	88 50 7d             	mov    %dl,0x7d(%eax)
801078ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078f1:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801078f5:	83 ca 80             	or     $0xffffff80,%edx
801078f8:	88 50 7d             	mov    %dl,0x7d(%eax)
801078fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078fe:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107902:	83 ca 0f             	or     $0xf,%edx
80107905:	88 50 7e             	mov    %dl,0x7e(%eax)
80107908:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010790b:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010790f:	83 e2 ef             	and    $0xffffffef,%edx
80107912:	88 50 7e             	mov    %dl,0x7e(%eax)
80107915:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107918:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010791c:	83 e2 df             	and    $0xffffffdf,%edx
8010791f:	88 50 7e             	mov    %dl,0x7e(%eax)
80107922:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107925:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107929:	83 ca 40             	or     $0x40,%edx
8010792c:	88 50 7e             	mov    %dl,0x7e(%eax)
8010792f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107932:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107936:	83 ca 80             	or     $0xffffff80,%edx
80107939:	88 50 7e             	mov    %dl,0x7e(%eax)
8010793c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010793f:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107943:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107946:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
8010794d:	ff ff 
8010794f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107952:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107959:	00 00 
8010795b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010795e:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107965:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107968:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010796f:	83 e2 f0             	and    $0xfffffff0,%edx
80107972:	83 ca 02             	or     $0x2,%edx
80107975:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010797b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010797e:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107985:	83 ca 10             	or     $0x10,%edx
80107988:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010798e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107991:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107998:	83 e2 9f             	and    $0xffffff9f,%edx
8010799b:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801079a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079a4:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801079ab:	83 ca 80             	or     $0xffffff80,%edx
801079ae:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801079b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079b7:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801079be:	83 ca 0f             	or     $0xf,%edx
801079c1:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801079c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ca:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801079d1:	83 e2 ef             	and    $0xffffffef,%edx
801079d4:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801079da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079dd:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801079e4:	83 e2 df             	and    $0xffffffdf,%edx
801079e7:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801079ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079f0:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801079f7:	83 ca 40             	or     $0x40,%edx
801079fa:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107a00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a03:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107a0a:	83 ca 80             	or     $0xffffff80,%edx
80107a0d:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107a13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a16:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107a1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a20:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107a27:	ff ff 
80107a29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a2c:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107a33:	00 00 
80107a35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a38:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107a3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a42:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107a49:	83 e2 f0             	and    $0xfffffff0,%edx
80107a4c:	83 ca 0a             	or     $0xa,%edx
80107a4f:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a58:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107a5f:	83 ca 10             	or     $0x10,%edx
80107a62:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107a68:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a6b:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107a72:	83 ca 60             	or     $0x60,%edx
80107a75:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107a7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a7e:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107a85:	83 ca 80             	or     $0xffffff80,%edx
80107a88:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107a8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a91:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a98:	83 ca 0f             	or     $0xf,%edx
80107a9b:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aa4:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107aab:	83 e2 ef             	and    $0xffffffef,%edx
80107aae:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ab7:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107abe:	83 e2 df             	and    $0xffffffdf,%edx
80107ac1:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107ac7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aca:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107ad1:	83 ca 40             	or     $0x40,%edx
80107ad4:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107add:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107ae4:	83 ca 80             	or     $0xffffff80,%edx
80107ae7:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107aed:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107af0:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107afa:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107b01:	ff ff 
80107b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b06:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107b0d:	00 00 
80107b0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b12:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107b19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b1c:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107b23:	83 e2 f0             	and    $0xfffffff0,%edx
80107b26:	83 ca 02             	or     $0x2,%edx
80107b29:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107b2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b32:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107b39:	83 ca 10             	or     $0x10,%edx
80107b3c:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107b42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b45:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107b4c:	83 ca 60             	or     $0x60,%edx
80107b4f:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b58:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107b5f:	83 ca 80             	or     $0xffffff80,%edx
80107b62:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107b68:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b6b:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b72:	83 ca 0f             	or     $0xf,%edx
80107b75:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b7e:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b85:	83 e2 ef             	and    $0xffffffef,%edx
80107b88:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b91:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b98:	83 e2 df             	and    $0xffffffdf,%edx
80107b9b:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107ba1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ba4:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107bab:	83 ca 40             	or     $0x40,%edx
80107bae:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107bb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb7:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107bbe:	83 ca 80             	or     $0xffffff80,%edx
80107bc1:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107bc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bca:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107bd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd4:	05 b4 00 00 00       	add    $0xb4,%eax
80107bd9:	89 c3                	mov    %eax,%ebx
80107bdb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bde:	05 b4 00 00 00       	add    $0xb4,%eax
80107be3:	c1 e8 10             	shr    $0x10,%eax
80107be6:	89 c1                	mov    %eax,%ecx
80107be8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107beb:	05 b4 00 00 00       	add    $0xb4,%eax
80107bf0:	c1 e8 18             	shr    $0x18,%eax
80107bf3:	89 c2                	mov    %eax,%edx
80107bf5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bf8:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107bff:	00 00 
80107c01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c04:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107c0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c0e:	88 88 8c 00 00 00    	mov    %cl,0x8c(%eax)
80107c14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c17:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107c1e:	83 e1 f0             	and    $0xfffffff0,%ecx
80107c21:	83 c9 02             	or     $0x2,%ecx
80107c24:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107c2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c2d:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107c34:	83 c9 10             	or     $0x10,%ecx
80107c37:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107c3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c40:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107c47:	83 e1 9f             	and    $0xffffff9f,%ecx
80107c4a:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107c50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c53:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107c5a:	83 c9 80             	or     $0xffffff80,%ecx
80107c5d:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107c63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c66:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107c6d:	83 e1 f0             	and    $0xfffffff0,%ecx
80107c70:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107c76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c79:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107c80:	83 e1 ef             	and    $0xffffffef,%ecx
80107c83:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107c89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c8c:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107c93:	83 e1 df             	and    $0xffffffdf,%ecx
80107c96:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107c9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c9f:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107ca6:	83 c9 40             	or     $0x40,%ecx
80107ca9:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107caf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cb2:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107cb9:	83 c9 80             	or     $0xffffff80,%ecx
80107cbc:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107cc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cc5:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107ccb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cce:	83 c0 70             	add    $0x70,%eax
80107cd1:	c7 44 24 04 38 00 00 	movl   $0x38,0x4(%esp)
80107cd8:	00 
80107cd9:	89 04 24             	mov    %eax,(%esp)
80107cdc:	e8 37 fb ff ff       	call   80107818 <lgdt>
  loadgs(SEG_KCPU << 3);
80107ce1:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
80107ce8:	e8 6a fb ff ff       	call   80107857 <loadgs>
  
  // Initialize cpu-local storage.
  cpu = c;
80107ced:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cf0:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107cf6:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107cfd:	00 00 00 00 
}
80107d01:	83 c4 24             	add    $0x24,%esp
80107d04:	5b                   	pop    %ebx
80107d05:	5d                   	pop    %ebp
80107d06:	c3                   	ret    

80107d07 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107d07:	55                   	push   %ebp
80107d08:	89 e5                	mov    %esp,%ebp
80107d0a:	83 ec 28             	sub    $0x28,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107d0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d10:	c1 e8 16             	shr    $0x16,%eax
80107d13:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107d1a:	8b 45 08             	mov    0x8(%ebp),%eax
80107d1d:	01 d0                	add    %edx,%eax
80107d1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107d22:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d25:	8b 00                	mov    (%eax),%eax
80107d27:	83 e0 01             	and    $0x1,%eax
80107d2a:	85 c0                	test   %eax,%eax
80107d2c:	74 17                	je     80107d45 <walkpgdir+0x3e>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107d2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d31:	8b 00                	mov    (%eax),%eax
80107d33:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d38:	89 04 24             	mov    %eax,(%esp)
80107d3b:	e8 44 fb ff ff       	call   80107884 <p2v>
80107d40:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107d43:	eb 4b                	jmp    80107d90 <walkpgdir+0x89>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107d45:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107d49:	74 0e                	je     80107d59 <walkpgdir+0x52>
80107d4b:	e8 93 ad ff ff       	call   80102ae3 <kalloc>
80107d50:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107d53:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107d57:	75 07                	jne    80107d60 <walkpgdir+0x59>
      return 0;
80107d59:	b8 00 00 00 00       	mov    $0x0,%eax
80107d5e:	eb 47                	jmp    80107da7 <walkpgdir+0xa0>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107d60:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107d67:	00 
80107d68:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107d6f:	00 
80107d70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d73:	89 04 24             	mov    %eax,(%esp)
80107d76:	e8 db d4 ff ff       	call   80105256 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107d7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d7e:	89 04 24             	mov    %eax,(%esp)
80107d81:	e8 f1 fa ff ff       	call   80107877 <v2p>
80107d86:	83 c8 07             	or     $0x7,%eax
80107d89:	89 c2                	mov    %eax,%edx
80107d8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d8e:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107d90:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d93:	c1 e8 0c             	shr    $0xc,%eax
80107d96:	25 ff 03 00 00       	and    $0x3ff,%eax
80107d9b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107da2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107da5:	01 d0                	add    %edx,%eax
}
80107da7:	c9                   	leave  
80107da8:	c3                   	ret    

80107da9 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107da9:	55                   	push   %ebp
80107daa:	89 e5                	mov    %esp,%ebp
80107dac:	83 ec 28             	sub    $0x28,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107daf:	8b 45 0c             	mov    0xc(%ebp),%eax
80107db2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107db7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107dba:	8b 55 0c             	mov    0xc(%ebp),%edx
80107dbd:	8b 45 10             	mov    0x10(%ebp),%eax
80107dc0:	01 d0                	add    %edx,%eax
80107dc2:	83 e8 01             	sub    $0x1,%eax
80107dc5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107dca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107dcd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
80107dd4:	00 
80107dd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dd8:	89 44 24 04          	mov    %eax,0x4(%esp)
80107ddc:	8b 45 08             	mov    0x8(%ebp),%eax
80107ddf:	89 04 24             	mov    %eax,(%esp)
80107de2:	e8 20 ff ff ff       	call   80107d07 <walkpgdir>
80107de7:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107dea:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107dee:	75 07                	jne    80107df7 <mappages+0x4e>
      return -1;
80107df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107df5:	eb 48                	jmp    80107e3f <mappages+0x96>
    if(*pte & PTE_P)
80107df7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107dfa:	8b 00                	mov    (%eax),%eax
80107dfc:	83 e0 01             	and    $0x1,%eax
80107dff:	85 c0                	test   %eax,%eax
80107e01:	74 0c                	je     80107e0f <mappages+0x66>
      panic("remap");
80107e03:	c7 04 24 60 8c 10 80 	movl   $0x80108c60,(%esp)
80107e0a:	e8 2b 87 ff ff       	call   8010053a <panic>
    *pte = pa | perm | PTE_P;
80107e0f:	8b 45 18             	mov    0x18(%ebp),%eax
80107e12:	0b 45 14             	or     0x14(%ebp),%eax
80107e15:	83 c8 01             	or     $0x1,%eax
80107e18:	89 c2                	mov    %eax,%edx
80107e1a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107e1d:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107e1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e22:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107e25:	75 08                	jne    80107e2f <mappages+0x86>
      break;
80107e27:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107e28:	b8 00 00 00 00       	mov    $0x0,%eax
80107e2d:	eb 10                	jmp    80107e3f <mappages+0x96>
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
80107e2f:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107e36:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107e3d:	eb 8e                	jmp    80107dcd <mappages+0x24>
  return 0;
}
80107e3f:	c9                   	leave  
80107e40:	c3                   	ret    

80107e41 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107e41:	55                   	push   %ebp
80107e42:	89 e5                	mov    %esp,%ebp
80107e44:	53                   	push   %ebx
80107e45:	83 ec 34             	sub    $0x34,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107e48:	e8 96 ac ff ff       	call   80102ae3 <kalloc>
80107e4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107e50:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107e54:	75 0a                	jne    80107e60 <setupkvm+0x1f>
    return 0;
80107e56:	b8 00 00 00 00       	mov    $0x0,%eax
80107e5b:	e9 98 00 00 00       	jmp    80107ef8 <setupkvm+0xb7>
  memset(pgdir, 0, PGSIZE);
80107e60:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107e67:	00 
80107e68:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107e6f:	00 
80107e70:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e73:	89 04 24             	mov    %eax,(%esp)
80107e76:	e8 db d3 ff ff       	call   80105256 <memset>
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107e7b:	c7 04 24 00 00 00 0e 	movl   $0xe000000,(%esp)
80107e82:	e8 fd f9 ff ff       	call   80107884 <p2v>
80107e87:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107e8c:	76 0c                	jbe    80107e9a <setupkvm+0x59>
    panic("PHYSTOP too high");
80107e8e:	c7 04 24 66 8c 10 80 	movl   $0x80108c66,(%esp)
80107e95:	e8 a0 86 ff ff       	call   8010053a <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107e9a:	c7 45 f4 c0 b4 10 80 	movl   $0x8010b4c0,-0xc(%ebp)
80107ea1:	eb 49                	jmp    80107eec <setupkvm+0xab>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107ea3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ea6:	8b 48 0c             	mov    0xc(%eax),%ecx
80107ea9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107eac:	8b 50 04             	mov    0x4(%eax),%edx
80107eaf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107eb2:	8b 58 08             	mov    0x8(%eax),%ebx
80107eb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107eb8:	8b 40 04             	mov    0x4(%eax),%eax
80107ebb:	29 c3                	sub    %eax,%ebx
80107ebd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ec0:	8b 00                	mov    (%eax),%eax
80107ec2:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80107ec6:	89 54 24 0c          	mov    %edx,0xc(%esp)
80107eca:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80107ece:	89 44 24 04          	mov    %eax,0x4(%esp)
80107ed2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ed5:	89 04 24             	mov    %eax,(%esp)
80107ed8:	e8 cc fe ff ff       	call   80107da9 <mappages>
80107edd:	85 c0                	test   %eax,%eax
80107edf:	79 07                	jns    80107ee8 <setupkvm+0xa7>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107ee1:	b8 00 00 00 00       	mov    $0x0,%eax
80107ee6:	eb 10                	jmp    80107ef8 <setupkvm+0xb7>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107ee8:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107eec:	81 7d f4 00 b5 10 80 	cmpl   $0x8010b500,-0xc(%ebp)
80107ef3:	72 ae                	jb     80107ea3 <setupkvm+0x62>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107ef5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107ef8:	83 c4 34             	add    $0x34,%esp
80107efb:	5b                   	pop    %ebx
80107efc:	5d                   	pop    %ebp
80107efd:	c3                   	ret    

80107efe <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107efe:	55                   	push   %ebp
80107eff:	89 e5                	mov    %esp,%ebp
80107f01:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107f04:	e8 38 ff ff ff       	call   80107e41 <setupkvm>
80107f09:	a3 18 2a 11 80       	mov    %eax,0x80112a18
  switchkvm();
80107f0e:	e8 02 00 00 00       	call   80107f15 <switchkvm>
}
80107f13:	c9                   	leave  
80107f14:	c3                   	ret    

80107f15 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107f15:	55                   	push   %ebp
80107f16:	89 e5                	mov    %esp,%ebp
80107f18:	83 ec 04             	sub    $0x4,%esp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107f1b:	a1 18 2a 11 80       	mov    0x80112a18,%eax
80107f20:	89 04 24             	mov    %eax,(%esp)
80107f23:	e8 4f f9 ff ff       	call   80107877 <v2p>
80107f28:	89 04 24             	mov    %eax,(%esp)
80107f2b:	e8 3c f9 ff ff       	call   8010786c <lcr3>
}
80107f30:	c9                   	leave  
80107f31:	c3                   	ret    

80107f32 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107f32:	55                   	push   %ebp
80107f33:	89 e5                	mov    %esp,%ebp
80107f35:	53                   	push   %ebx
80107f36:	83 ec 14             	sub    $0x14,%esp
  pushcli();
80107f39:	e8 15 d2 ff ff       	call   80105153 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107f3e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f44:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107f4b:	83 c2 08             	add    $0x8,%edx
80107f4e:	89 d3                	mov    %edx,%ebx
80107f50:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107f57:	83 c2 08             	add    $0x8,%edx
80107f5a:	c1 ea 10             	shr    $0x10,%edx
80107f5d:	89 d1                	mov    %edx,%ecx
80107f5f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107f66:	83 c2 08             	add    $0x8,%edx
80107f69:	c1 ea 18             	shr    $0x18,%edx
80107f6c:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107f73:	67 00 
80107f75:	66 89 98 a2 00 00 00 	mov    %bx,0xa2(%eax)
80107f7c:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
80107f82:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107f89:	83 e1 f0             	and    $0xfffffff0,%ecx
80107f8c:	83 c9 09             	or     $0x9,%ecx
80107f8f:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107f95:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107f9c:	83 c9 10             	or     $0x10,%ecx
80107f9f:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107fa5:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107fac:	83 e1 9f             	and    $0xffffff9f,%ecx
80107faf:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107fb5:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107fbc:	83 c9 80             	or     $0xffffff80,%ecx
80107fbf:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107fc5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107fcc:	83 e1 f0             	and    $0xfffffff0,%ecx
80107fcf:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107fd5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107fdc:	83 e1 ef             	and    $0xffffffef,%ecx
80107fdf:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107fe5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107fec:	83 e1 df             	and    $0xffffffdf,%ecx
80107fef:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107ff5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107ffc:	83 c9 40             	or     $0x40,%ecx
80107fff:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108005:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
8010800c:	83 e1 7f             	and    $0x7f,%ecx
8010800f:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108015:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
8010801b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108021:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80108028:	83 e2 ef             	and    $0xffffffef,%edx
8010802b:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80108031:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108037:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
8010803d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108043:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010804a:	8b 52 08             	mov    0x8(%edx),%edx
8010804d:	81 c2 00 10 00 00    	add    $0x1000,%edx
80108053:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80108056:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
8010805d:	e8 df f7 ff ff       	call   80107841 <ltr>
  if(p->pgdir == 0)
80108062:	8b 45 08             	mov    0x8(%ebp),%eax
80108065:	8b 40 04             	mov    0x4(%eax),%eax
80108068:	85 c0                	test   %eax,%eax
8010806a:	75 0c                	jne    80108078 <switchuvm+0x146>
    panic("switchuvm: no pgdir");
8010806c:	c7 04 24 77 8c 10 80 	movl   $0x80108c77,(%esp)
80108073:	e8 c2 84 ff ff       	call   8010053a <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80108078:	8b 45 08             	mov    0x8(%ebp),%eax
8010807b:	8b 40 04             	mov    0x4(%eax),%eax
8010807e:	89 04 24             	mov    %eax,(%esp)
80108081:	e8 f1 f7 ff ff       	call   80107877 <v2p>
80108086:	89 04 24             	mov    %eax,(%esp)
80108089:	e8 de f7 ff ff       	call   8010786c <lcr3>
  popcli();
8010808e:	e8 04 d1 ff ff       	call   80105197 <popcli>
}
80108093:	83 c4 14             	add    $0x14,%esp
80108096:	5b                   	pop    %ebx
80108097:	5d                   	pop    %ebp
80108098:	c3                   	ret    

80108099 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80108099:	55                   	push   %ebp
8010809a:	89 e5                	mov    %esp,%ebp
8010809c:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  
  if(sz >= PGSIZE)
8010809f:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
801080a6:	76 0c                	jbe    801080b4 <inituvm+0x1b>
    panic("inituvm: more than a page");
801080a8:	c7 04 24 8b 8c 10 80 	movl   $0x80108c8b,(%esp)
801080af:	e8 86 84 ff ff       	call   8010053a <panic>
  mem = kalloc();
801080b4:	e8 2a aa ff ff       	call   80102ae3 <kalloc>
801080b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
801080bc:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801080c3:	00 
801080c4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801080cb:	00 
801080cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080cf:	89 04 24             	mov    %eax,(%esp)
801080d2:	e8 7f d1 ff ff       	call   80105256 <memset>
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
801080d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080da:	89 04 24             	mov    %eax,(%esp)
801080dd:	e8 95 f7 ff ff       	call   80107877 <v2p>
801080e2:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
801080e9:	00 
801080ea:	89 44 24 0c          	mov    %eax,0xc(%esp)
801080ee:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801080f5:	00 
801080f6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801080fd:	00 
801080fe:	8b 45 08             	mov    0x8(%ebp),%eax
80108101:	89 04 24             	mov    %eax,(%esp)
80108104:	e8 a0 fc ff ff       	call   80107da9 <mappages>
  memmove(mem, init, sz);
80108109:	8b 45 10             	mov    0x10(%ebp),%eax
8010810c:	89 44 24 08          	mov    %eax,0x8(%esp)
80108110:	8b 45 0c             	mov    0xc(%ebp),%eax
80108113:	89 44 24 04          	mov    %eax,0x4(%esp)
80108117:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010811a:	89 04 24             	mov    %eax,(%esp)
8010811d:	e8 03 d2 ff ff       	call   80105325 <memmove>
}
80108122:	c9                   	leave  
80108123:	c3                   	ret    

80108124 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80108124:	55                   	push   %ebp
80108125:	89 e5                	mov    %esp,%ebp
80108127:	53                   	push   %ebx
80108128:	83 ec 24             	sub    $0x24,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
8010812b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010812e:	25 ff 0f 00 00       	and    $0xfff,%eax
80108133:	85 c0                	test   %eax,%eax
80108135:	74 0c                	je     80108143 <loaduvm+0x1f>
    panic("loaduvm: addr must be page aligned");
80108137:	c7 04 24 a8 8c 10 80 	movl   $0x80108ca8,(%esp)
8010813e:	e8 f7 83 ff ff       	call   8010053a <panic>
  for(i = 0; i < sz; i += PGSIZE){
80108143:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010814a:	e9 a9 00 00 00       	jmp    801081f8 <loaduvm+0xd4>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010814f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108152:	8b 55 0c             	mov    0xc(%ebp),%edx
80108155:	01 d0                	add    %edx,%eax
80108157:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010815e:	00 
8010815f:	89 44 24 04          	mov    %eax,0x4(%esp)
80108163:	8b 45 08             	mov    0x8(%ebp),%eax
80108166:	89 04 24             	mov    %eax,(%esp)
80108169:	e8 99 fb ff ff       	call   80107d07 <walkpgdir>
8010816e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108171:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108175:	75 0c                	jne    80108183 <loaduvm+0x5f>
      panic("loaduvm: address should exist");
80108177:	c7 04 24 cb 8c 10 80 	movl   $0x80108ccb,(%esp)
8010817e:	e8 b7 83 ff ff       	call   8010053a <panic>
    pa = PTE_ADDR(*pte);
80108183:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108186:	8b 00                	mov    (%eax),%eax
80108188:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010818d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80108190:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108193:	8b 55 18             	mov    0x18(%ebp),%edx
80108196:	29 c2                	sub    %eax,%edx
80108198:	89 d0                	mov    %edx,%eax
8010819a:	3d ff 0f 00 00       	cmp    $0xfff,%eax
8010819f:	77 0f                	ja     801081b0 <loaduvm+0x8c>
      n = sz - i;
801081a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081a4:	8b 55 18             	mov    0x18(%ebp),%edx
801081a7:	29 c2                	sub    %eax,%edx
801081a9:	89 d0                	mov    %edx,%eax
801081ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
801081ae:	eb 07                	jmp    801081b7 <loaduvm+0x93>
    else
      n = PGSIZE;
801081b0:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
801081b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081ba:	8b 55 14             	mov    0x14(%ebp),%edx
801081bd:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
801081c0:	8b 45 e8             	mov    -0x18(%ebp),%eax
801081c3:	89 04 24             	mov    %eax,(%esp)
801081c6:	e8 b9 f6 ff ff       	call   80107884 <p2v>
801081cb:	8b 55 f0             	mov    -0x10(%ebp),%edx
801081ce:	89 54 24 0c          	mov    %edx,0xc(%esp)
801081d2:	89 5c 24 08          	mov    %ebx,0x8(%esp)
801081d6:	89 44 24 04          	mov    %eax,0x4(%esp)
801081da:	8b 45 10             	mov    0x10(%ebp),%eax
801081dd:	89 04 24             	mov    %eax,(%esp)
801081e0:	e8 7e 9b ff ff       	call   80101d63 <readi>
801081e5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801081e8:	74 07                	je     801081f1 <loaduvm+0xcd>
      return -1;
801081ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801081ef:	eb 18                	jmp    80108209 <loaduvm+0xe5>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801081f1:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801081f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081fb:	3b 45 18             	cmp    0x18(%ebp),%eax
801081fe:	0f 82 4b ff ff ff    	jb     8010814f <loaduvm+0x2b>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80108204:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108209:	83 c4 24             	add    $0x24,%esp
8010820c:	5b                   	pop    %ebx
8010820d:	5d                   	pop    %ebp
8010820e:	c3                   	ret    

8010820f <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010820f:	55                   	push   %ebp
80108210:	89 e5                	mov    %esp,%ebp
80108212:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80108215:	8b 45 10             	mov    0x10(%ebp),%eax
80108218:	85 c0                	test   %eax,%eax
8010821a:	79 0a                	jns    80108226 <allocuvm+0x17>
    return 0;
8010821c:	b8 00 00 00 00       	mov    $0x0,%eax
80108221:	e9 c1 00 00 00       	jmp    801082e7 <allocuvm+0xd8>
  if(newsz < oldsz)
80108226:	8b 45 10             	mov    0x10(%ebp),%eax
80108229:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010822c:	73 08                	jae    80108236 <allocuvm+0x27>
    return oldsz;
8010822e:	8b 45 0c             	mov    0xc(%ebp),%eax
80108231:	e9 b1 00 00 00       	jmp    801082e7 <allocuvm+0xd8>

  a = PGROUNDUP(oldsz);
80108236:	8b 45 0c             	mov    0xc(%ebp),%eax
80108239:	05 ff 0f 00 00       	add    $0xfff,%eax
8010823e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108243:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
80108246:	e9 8d 00 00 00       	jmp    801082d8 <allocuvm+0xc9>
    mem = kalloc();
8010824b:	e8 93 a8 ff ff       	call   80102ae3 <kalloc>
80108250:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80108253:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108257:	75 2c                	jne    80108285 <allocuvm+0x76>
      cprintf("allocuvm out of memory\n");
80108259:	c7 04 24 e9 8c 10 80 	movl   $0x80108ce9,(%esp)
80108260:	e8 3b 81 ff ff       	call   801003a0 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80108265:	8b 45 0c             	mov    0xc(%ebp),%eax
80108268:	89 44 24 08          	mov    %eax,0x8(%esp)
8010826c:	8b 45 10             	mov    0x10(%ebp),%eax
8010826f:	89 44 24 04          	mov    %eax,0x4(%esp)
80108273:	8b 45 08             	mov    0x8(%ebp),%eax
80108276:	89 04 24             	mov    %eax,(%esp)
80108279:	e8 6b 00 00 00       	call   801082e9 <deallocuvm>
      return 0;
8010827e:	b8 00 00 00 00       	mov    $0x0,%eax
80108283:	eb 62                	jmp    801082e7 <allocuvm+0xd8>
    }
    memset(mem, 0, PGSIZE);
80108285:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010828c:	00 
8010828d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80108294:	00 
80108295:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108298:	89 04 24             	mov    %eax,(%esp)
8010829b:	e8 b6 cf ff ff       	call   80105256 <memset>
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
801082a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801082a3:	89 04 24             	mov    %eax,(%esp)
801082a6:	e8 cc f5 ff ff       	call   80107877 <v2p>
801082ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
801082ae:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
801082b5:	00 
801082b6:	89 44 24 0c          	mov    %eax,0xc(%esp)
801082ba:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801082c1:	00 
801082c2:	89 54 24 04          	mov    %edx,0x4(%esp)
801082c6:	8b 45 08             	mov    0x8(%ebp),%eax
801082c9:	89 04 24             	mov    %eax,(%esp)
801082cc:	e8 d8 fa ff ff       	call   80107da9 <mappages>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801082d1:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801082d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082db:	3b 45 10             	cmp    0x10(%ebp),%eax
801082de:	0f 82 67 ff ff ff    	jb     8010824b <allocuvm+0x3c>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
801082e4:	8b 45 10             	mov    0x10(%ebp),%eax
}
801082e7:	c9                   	leave  
801082e8:	c3                   	ret    

801082e9 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801082e9:	55                   	push   %ebp
801082ea:	89 e5                	mov    %esp,%ebp
801082ec:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801082ef:	8b 45 10             	mov    0x10(%ebp),%eax
801082f2:	3b 45 0c             	cmp    0xc(%ebp),%eax
801082f5:	72 08                	jb     801082ff <deallocuvm+0x16>
    return oldsz;
801082f7:	8b 45 0c             	mov    0xc(%ebp),%eax
801082fa:	e9 a4 00 00 00       	jmp    801083a3 <deallocuvm+0xba>

  a = PGROUNDUP(newsz);
801082ff:	8b 45 10             	mov    0x10(%ebp),%eax
80108302:	05 ff 0f 00 00       	add    $0xfff,%eax
80108307:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010830c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010830f:	e9 80 00 00 00       	jmp    80108394 <deallocuvm+0xab>
    pte = walkpgdir(pgdir, (char*)a, 0);
80108314:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108317:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010831e:	00 
8010831f:	89 44 24 04          	mov    %eax,0x4(%esp)
80108323:	8b 45 08             	mov    0x8(%ebp),%eax
80108326:	89 04 24             	mov    %eax,(%esp)
80108329:	e8 d9 f9 ff ff       	call   80107d07 <walkpgdir>
8010832e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80108331:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108335:	75 09                	jne    80108340 <deallocuvm+0x57>
      a += (NPTENTRIES - 1) * PGSIZE;
80108337:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
8010833e:	eb 4d                	jmp    8010838d <deallocuvm+0xa4>
    else if((*pte & PTE_P) != 0){
80108340:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108343:	8b 00                	mov    (%eax),%eax
80108345:	83 e0 01             	and    $0x1,%eax
80108348:	85 c0                	test   %eax,%eax
8010834a:	74 41                	je     8010838d <deallocuvm+0xa4>
      pa = PTE_ADDR(*pte);
8010834c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010834f:	8b 00                	mov    (%eax),%eax
80108351:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108356:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
80108359:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010835d:	75 0c                	jne    8010836b <deallocuvm+0x82>
        panic("kfree");
8010835f:	c7 04 24 01 8d 10 80 	movl   $0x80108d01,(%esp)
80108366:	e8 cf 81 ff ff       	call   8010053a <panic>
      char *v = p2v(pa);
8010836b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010836e:	89 04 24             	mov    %eax,(%esp)
80108371:	e8 0e f5 ff ff       	call   80107884 <p2v>
80108376:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
80108379:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010837c:	89 04 24             	mov    %eax,(%esp)
8010837f:	e8 c6 a6 ff ff       	call   80102a4a <kfree>
      *pte = 0;
80108384:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108387:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010838d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108394:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108397:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010839a:	0f 82 74 ff ff ff    	jb     80108314 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
801083a0:	8b 45 10             	mov    0x10(%ebp),%eax
}
801083a3:	c9                   	leave  
801083a4:	c3                   	ret    

801083a5 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801083a5:	55                   	push   %ebp
801083a6:	89 e5                	mov    %esp,%ebp
801083a8:	83 ec 28             	sub    $0x28,%esp
  uint i;

  if(pgdir == 0)
801083ab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801083af:	75 0c                	jne    801083bd <freevm+0x18>
    panic("freevm: no pgdir");
801083b1:	c7 04 24 07 8d 10 80 	movl   $0x80108d07,(%esp)
801083b8:	e8 7d 81 ff ff       	call   8010053a <panic>
  deallocuvm(pgdir, KERNBASE, 0);
801083bd:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801083c4:	00 
801083c5:	c7 44 24 04 00 00 00 	movl   $0x80000000,0x4(%esp)
801083cc:	80 
801083cd:	8b 45 08             	mov    0x8(%ebp),%eax
801083d0:	89 04 24             	mov    %eax,(%esp)
801083d3:	e8 11 ff ff ff       	call   801082e9 <deallocuvm>
  for(i = 0; i < NPDENTRIES; i++){
801083d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801083df:	eb 48                	jmp    80108429 <freevm+0x84>
    if(pgdir[i] & PTE_P){
801083e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801083eb:	8b 45 08             	mov    0x8(%ebp),%eax
801083ee:	01 d0                	add    %edx,%eax
801083f0:	8b 00                	mov    (%eax),%eax
801083f2:	83 e0 01             	and    $0x1,%eax
801083f5:	85 c0                	test   %eax,%eax
801083f7:	74 2c                	je     80108425 <freevm+0x80>
      char * v = p2v(PTE_ADDR(pgdir[i]));
801083f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083fc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108403:	8b 45 08             	mov    0x8(%ebp),%eax
80108406:	01 d0                	add    %edx,%eax
80108408:	8b 00                	mov    (%eax),%eax
8010840a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010840f:	89 04 24             	mov    %eax,(%esp)
80108412:	e8 6d f4 ff ff       	call   80107884 <p2v>
80108417:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
8010841a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010841d:	89 04 24             	mov    %eax,(%esp)
80108420:	e8 25 a6 ff ff       	call   80102a4a <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108425:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108429:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80108430:	76 af                	jbe    801083e1 <freevm+0x3c>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80108432:	8b 45 08             	mov    0x8(%ebp),%eax
80108435:	89 04 24             	mov    %eax,(%esp)
80108438:	e8 0d a6 ff ff       	call   80102a4a <kfree>
}
8010843d:	c9                   	leave  
8010843e:	c3                   	ret    

8010843f <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
8010843f:	55                   	push   %ebp
80108440:	89 e5                	mov    %esp,%ebp
80108442:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108445:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010844c:	00 
8010844d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108450:	89 44 24 04          	mov    %eax,0x4(%esp)
80108454:	8b 45 08             	mov    0x8(%ebp),%eax
80108457:	89 04 24             	mov    %eax,(%esp)
8010845a:	e8 a8 f8 ff ff       	call   80107d07 <walkpgdir>
8010845f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
80108462:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108466:	75 0c                	jne    80108474 <clearpteu+0x35>
    panic("clearpteu");
80108468:	c7 04 24 18 8d 10 80 	movl   $0x80108d18,(%esp)
8010846f:	e8 c6 80 ff ff       	call   8010053a <panic>
  *pte &= ~PTE_U;
80108474:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108477:	8b 00                	mov    (%eax),%eax
80108479:	83 e0 fb             	and    $0xfffffffb,%eax
8010847c:	89 c2                	mov    %eax,%edx
8010847e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108481:	89 10                	mov    %edx,(%eax)
}
80108483:	c9                   	leave  
80108484:	c3                   	ret    

80108485 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108485:	55                   	push   %ebp
80108486:	89 e5                	mov    %esp,%ebp
80108488:	53                   	push   %ebx
80108489:	83 ec 44             	sub    $0x44,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
8010848c:	e8 b0 f9 ff ff       	call   80107e41 <setupkvm>
80108491:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108494:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108498:	75 0a                	jne    801084a4 <copyuvm+0x1f>
    return 0;
8010849a:	b8 00 00 00 00       	mov    $0x0,%eax
8010849f:	e9 fd 00 00 00       	jmp    801085a1 <copyuvm+0x11c>
  for(i = PGSIZE; i < sz; i += PGSIZE){
801084a4:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
801084ab:	e9 d0 00 00 00       	jmp    80108580 <copyuvm+0xfb>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801084b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084b3:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801084ba:	00 
801084bb:	89 44 24 04          	mov    %eax,0x4(%esp)
801084bf:	8b 45 08             	mov    0x8(%ebp),%eax
801084c2:	89 04 24             	mov    %eax,(%esp)
801084c5:	e8 3d f8 ff ff       	call   80107d07 <walkpgdir>
801084ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
801084cd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801084d1:	75 0c                	jne    801084df <copyuvm+0x5a>
      panic("copyuvm: pte should exist");
801084d3:	c7 04 24 22 8d 10 80 	movl   $0x80108d22,(%esp)
801084da:	e8 5b 80 ff ff       	call   8010053a <panic>
    if(!(*pte & PTE_P))
801084df:	8b 45 ec             	mov    -0x14(%ebp),%eax
801084e2:	8b 00                	mov    (%eax),%eax
801084e4:	83 e0 01             	and    $0x1,%eax
801084e7:	85 c0                	test   %eax,%eax
801084e9:	75 0c                	jne    801084f7 <copyuvm+0x72>
      panic("copyuvm: page not present");
801084eb:	c7 04 24 3c 8d 10 80 	movl   $0x80108d3c,(%esp)
801084f2:	e8 43 80 ff ff       	call   8010053a <panic>
    pa = PTE_ADDR(*pte);
801084f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801084fa:	8b 00                	mov    (%eax),%eax
801084fc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108501:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
80108504:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108507:	8b 00                	mov    (%eax),%eax
80108509:	25 ff 0f 00 00       	and    $0xfff,%eax
8010850e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80108511:	e8 cd a5 ff ff       	call   80102ae3 <kalloc>
80108516:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108519:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010851d:	75 02                	jne    80108521 <copyuvm+0x9c>
      goto bad;
8010851f:	eb 70                	jmp    80108591 <copyuvm+0x10c>
    memmove(mem, (char*)p2v(pa), PGSIZE);
80108521:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108524:	89 04 24             	mov    %eax,(%esp)
80108527:	e8 58 f3 ff ff       	call   80107884 <p2v>
8010852c:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108533:	00 
80108534:	89 44 24 04          	mov    %eax,0x4(%esp)
80108538:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010853b:	89 04 24             	mov    %eax,(%esp)
8010853e:	e8 e2 cd ff ff       	call   80105325 <memmove>
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
80108543:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80108546:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108549:	89 04 24             	mov    %eax,(%esp)
8010854c:	e8 26 f3 ff ff       	call   80107877 <v2p>
80108551:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108554:	89 5c 24 10          	mov    %ebx,0x10(%esp)
80108558:	89 44 24 0c          	mov    %eax,0xc(%esp)
8010855c:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108563:	00 
80108564:	89 54 24 04          	mov    %edx,0x4(%esp)
80108568:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010856b:	89 04 24             	mov    %eax,(%esp)
8010856e:	e8 36 f8 ff ff       	call   80107da9 <mappages>
80108573:	85 c0                	test   %eax,%eax
80108575:	79 02                	jns    80108579 <copyuvm+0xf4>
      goto bad;
80108577:	eb 18                	jmp    80108591 <copyuvm+0x10c>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = PGSIZE; i < sz; i += PGSIZE){
80108579:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108580:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108583:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108586:	0f 82 24 ff ff ff    	jb     801084b0 <copyuvm+0x2b>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
  }
  return d;
8010858c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010858f:	eb 10                	jmp    801085a1 <copyuvm+0x11c>

bad:
  freevm(d);
80108591:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108594:	89 04 24             	mov    %eax,(%esp)
80108597:	e8 09 fe ff ff       	call   801083a5 <freevm>
  return 0;
8010859c:	b8 00 00 00 00       	mov    $0x0,%eax
}
801085a1:	83 c4 44             	add    $0x44,%esp
801085a4:	5b                   	pop    %ebx
801085a5:	5d                   	pop    %ebp
801085a6:	c3                   	ret    

801085a7 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801085a7:	55                   	push   %ebp
801085a8:	89 e5                	mov    %esp,%ebp
801085aa:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801085ad:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801085b4:	00 
801085b5:	8b 45 0c             	mov    0xc(%ebp),%eax
801085b8:	89 44 24 04          	mov    %eax,0x4(%esp)
801085bc:	8b 45 08             	mov    0x8(%ebp),%eax
801085bf:	89 04 24             	mov    %eax,(%esp)
801085c2:	e8 40 f7 ff ff       	call   80107d07 <walkpgdir>
801085c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
801085ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085cd:	8b 00                	mov    (%eax),%eax
801085cf:	83 e0 01             	and    $0x1,%eax
801085d2:	85 c0                	test   %eax,%eax
801085d4:	75 07                	jne    801085dd <uva2ka+0x36>
    return 0;
801085d6:	b8 00 00 00 00       	mov    $0x0,%eax
801085db:	eb 25                	jmp    80108602 <uva2ka+0x5b>
  if((*pte & PTE_U) == 0)
801085dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085e0:	8b 00                	mov    (%eax),%eax
801085e2:	83 e0 04             	and    $0x4,%eax
801085e5:	85 c0                	test   %eax,%eax
801085e7:	75 07                	jne    801085f0 <uva2ka+0x49>
    return 0;
801085e9:	b8 00 00 00 00       	mov    $0x0,%eax
801085ee:	eb 12                	jmp    80108602 <uva2ka+0x5b>
  return (char*)p2v(PTE_ADDR(*pte));
801085f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085f3:	8b 00                	mov    (%eax),%eax
801085f5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801085fa:	89 04 24             	mov    %eax,(%esp)
801085fd:	e8 82 f2 ff ff       	call   80107884 <p2v>
}
80108602:	c9                   	leave  
80108603:	c3                   	ret    

80108604 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108604:	55                   	push   %ebp
80108605:	89 e5                	mov    %esp,%ebp
80108607:	83 ec 28             	sub    $0x28,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
8010860a:	8b 45 10             	mov    0x10(%ebp),%eax
8010860d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
80108610:	e9 87 00 00 00       	jmp    8010869c <copyout+0x98>
    va0 = (uint)PGROUNDDOWN(va);
80108615:	8b 45 0c             	mov    0xc(%ebp),%eax
80108618:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010861d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108620:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108623:	89 44 24 04          	mov    %eax,0x4(%esp)
80108627:	8b 45 08             	mov    0x8(%ebp),%eax
8010862a:	89 04 24             	mov    %eax,(%esp)
8010862d:	e8 75 ff ff ff       	call   801085a7 <uva2ka>
80108632:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
80108635:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80108639:	75 07                	jne    80108642 <copyout+0x3e>
      return -1;
8010863b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108640:	eb 69                	jmp    801086ab <copyout+0xa7>
    n = PGSIZE - (va - va0);
80108642:	8b 45 0c             	mov    0xc(%ebp),%eax
80108645:	8b 55 ec             	mov    -0x14(%ebp),%edx
80108648:	29 c2                	sub    %eax,%edx
8010864a:	89 d0                	mov    %edx,%eax
8010864c:	05 00 10 00 00       	add    $0x1000,%eax
80108651:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
80108654:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108657:	3b 45 14             	cmp    0x14(%ebp),%eax
8010865a:	76 06                	jbe    80108662 <copyout+0x5e>
      n = len;
8010865c:	8b 45 14             	mov    0x14(%ebp),%eax
8010865f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
80108662:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108665:	8b 55 0c             	mov    0xc(%ebp),%edx
80108668:	29 c2                	sub    %eax,%edx
8010866a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010866d:	01 c2                	add    %eax,%edx
8010866f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108672:	89 44 24 08          	mov    %eax,0x8(%esp)
80108676:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108679:	89 44 24 04          	mov    %eax,0x4(%esp)
8010867d:	89 14 24             	mov    %edx,(%esp)
80108680:	e8 a0 cc ff ff       	call   80105325 <memmove>
    len -= n;
80108685:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108688:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
8010868b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010868e:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80108691:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108694:	05 00 10 00 00       	add    $0x1000,%eax
80108699:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010869c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801086a0:	0f 85 6f ff ff ff    	jne    80108615 <copyout+0x11>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801086a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
801086ab:	c9                   	leave  
801086ac:	c3                   	ret    
