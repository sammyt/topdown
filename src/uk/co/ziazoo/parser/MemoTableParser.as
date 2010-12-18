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

    public function parse(parserState:IParserState):Result
    {
      var memo:IMemoTable = parserState.memo;

      var index:int = parserState.index;
      var id:String = parser.id;

      if (memo.hasResult(id, index))
      {
        return memo.getResult(id, index);
      }

      var result:Result = parser.parse(parserState);
      memo.saveResult(id, index, result);
      return result;
    }

    public function extractor(extractor:Object):IParser
    {
      return parser.extractor(extractor);
    }

    public function get id():String
    {
      return parser.id;
    }

    public function set id(value:String):void
    {
      parser.id = value;
    }
  }
}
