/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 11/12/2010
 * Time: 12:29
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  import org.flexunit.asserts.assertEquals;
  import org.flexunit.asserts.assertNotNull;
  import org.flexunit.asserts.assertTrue;

  import uk.co.ziazoo.parser.numeric.Operation;

  public class ParserTests
  {
    public function ParserTests()
    {
    }

    [Test]
    public function parserNumericExpr():void
    {
      var b:IParserBuilder = new MemoTableBuilder(new ParserBuilder());

      var value:IParser = b.chose(
        b.oneOrMore(b.range("0", "9")),
        b.sequence(
          "(",
          b.future("expr"),
          ")")
        );

      var product:IParser = b.sequence(
        value,
        b.zeroOrMore(
          b.sequence(
            b.chose("*", "/"),
            value
            )
          )
        );

      var sum:IParser = b.sequence(
        product,
        b.zeroOrMore(
          b.sequence(
            b.chose("+", "-"),
            product
            )
          )
        );

      var expr:IParser = b.satisfyFuture("expr", sum);
      var input:String = "1+2+3-(4+1/5/6/(7*7))+2*3-(4/1+2*3)-4*1+2*3-4";

      var result:Object = expr.parse(input);

      assertNotNull(result);
    }

    [Test]
    public function helloWorld():void
    {
      var b:IParserBuilder = new ParserBuilder();
      var p:IParser = b.sequence("hello", "all", "you", "chaps");
      var r:Result = p.parse("hello all you chaps");
      assertNotNull(r);
      assertTrue(r.instance is Array);
      assertEquals(4, r.instance.length);
    }

    [Test]
    public function createBasicAST():void
    {
      var b:IParserBuilder = new MemoTableBuilder(new ParserBuilder());
      var e:BindAction = new BindAction();

      var num:IParser = b.range("0", "9");

      var plus:IParser = b.sequence(e.bind(num, "left"), "+", e.bind(num, "right"));
      plus.setParseAction(e);


      e.action = function(args:Object):Object
      {
        return new Operation("+", args.left, args.right);
      };

      var r:Result = plus.parse("1 + 5");

      assertNotNull(r);
      assertNotNull(r.instance);
      assertTrue(r.instance is Operation);

      assertEquals(6, r.instance.execute());
    }


    [Test]
    public function createFullNumericAST():void
    {
      var b:IParserBuilder = new MemoTableBuilder(new ParserBuilder());

      var number:IParser = b.range("0", "9");
      var p:BindAction = new BindAction();
      var s:BindAction = new BindAction();


      var value:IParser = b.chose(
        b.oneOrMore(number),
        b.sequence(
          "(",
          b.future("expr"),
          ")")
        );

      var product:IParser = b.sequence(
        p.bind(value, "left"),
        b.zeroOrMore(
          b.sequence(
            p.bind(b.chose("*", "/"), "op"),
            p.bind(value, "right")
            )
          )
        );

      var sum:IParser = b.sequence(
        s.bind(product, "left"),
        b.zeroOrMore(
          b.sequence(
            s.bind(b.chose("+", "-"), "op"),
            s.bind(product, "right")
            )
          )
        );

      s.action = p.action = function(args:Object):Object
      {
        if (args.op && args.right)
        {
          return new Operation(args.op, args.left, args.right).execute();
        }
        return args.left;
      };


      var expr:IParser = b.satisfyFuture("expr", sum);
      product.setParseAction(p);
      sum.setParseAction(s);

      var r1:Result = expr.parse("5*2");

      assertNotNull(r1);
      assertNotNull(r1.instance);
      assertEquals(10, r1.instance);


      var r2:Result = expr.parse("5*2-7");

      assertNotNull(r2);
      assertNotNull(r2.instance);
      assertEquals(3, r2.instance);


      var r3:Result = expr.parse("5*2-7+8");

      assertNotNull(r3);
      assertNotNull(r3.instance);
      assertEquals(11, r3.instance);

    }
  }
}