/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 18/12/2010
 * Time: 15:36
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class MemoTableParser implements IParser
  {
    private var parser:IParser;

    public function MemoTableParser(parser:IParser)
    {
      this.parser = parser;
    }

    public function parseState(state:IParserState):Result
    {
      var memo:IMemoTable = state.memo;

      var index:int = state.index;
      var id:String = parser.id;

      if (memo.hasResult(id, index))
      {
        return memo.getResult(id, index);
      }

      var result:Result = parser.parseState(state);
      memo.saveResult(id, index, result);
      return result;
    }

    public function setParseAction(extractor:Object):IParser
    {
      return parser.setParseAction(extractor);
    }

    public function get id():String
    {
      return parser.id;
    }

    public function set id(value:String):void
    {
      parser.id = value;
    }

    public function parse(input:String):Result
    {
      return parser.parse(input);
    }
  }
}
