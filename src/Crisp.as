package
{
  import flash.display.Sprite;

  import ziazoo.combinators.IParser;
  import ziazoo.combinators.IResult;
  import ziazoo.combinators.ParserBuilder;
  import ziazoo.combinators.ParserState;
  import ziazoo.combinators.RegExParser;

  public class Crisp extends Sprite
  {
    public function Crisp()
    {
      parseJson();

      // newApi();
    }

    /*
     Issues:
     4) no means for AST creation
     5) no error handling
        - when zeroOrMore
        - when full string not passed
        
     */

    private function newApi():void
    {
      var b:ParserBuilder = new ParserBuilder();

      var value:IParser = b.either(
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
            b.either("*", "/"),
            value
            )
          )
        );

      var sum:IParser = b.sequence(
        product,
        b.zeroOrMore(
          b.sequence(
            b.either("+", "-"),
            product
            )
          )
        );

      var expr:IParser = b.satisfyFuture("expr", sum);

      var ps:ParserState = new ParserState("1+2*3-4+1+/2*3-(4/1+2*3)-4*1+2*3-4");
      var result:IResult = expr.parse(ps);
      trace(result);
      // trace(ps.index);
    }

    public function parseJson():void
    {
      var b:ParserBuilder = new ParserBuilder();

      var stringLiteral:RegExParser = b.re(/^"(?:[^"\\]|\\.)*"/);
      var number:RegExParser = b.re(/^-?\d+/);

      var nil:IParser = b.terminal("null");
      var yes:IParser = b.terminal("true");
      var no:IParser = b.terminal("false");
      var nan:IParser = b.terminal("NaN");

      var value:IParser = b.chose(
        b.future("object"),
        b.future("array"),
        stringLiteral,
        number,
        nil,
        yes,
        no,
        nan
        );

      var object:IParser = b.sequence(
        "{",
        b.oneOrMore(
          b.repSep(
            b.future("member"),
            ","
            )
          ),
        "}"
        );
      b.satisfyFuture("object", object);

      var array:IParser = b.sequence(
        "[",
        b.oneOrMore(
          b.repSep(
            value,
            ","
            )
          ),
        "]"
        );
      b.satisfyFuture("array", array);

      var member:IParser = b.sequence(
        stringLiteral,
        ":",
        value
        );
      b.satisfyFuture("member", member);


      var str:String = '{"dooo":[4,[444,{"goo":NaN}]],"isIt":true,"woo":"a","dooo":[4,600],"gobble":{"ahh":true}}';
      var state:ParserState = new ParserState(str);
      var result:IResult = value.parse(state);
      trace(result, state, state.index, str.length, state.index == str.length);
    }
  }
}
