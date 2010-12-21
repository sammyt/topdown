/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:37
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class SequenceParser extends AbstractParser implements IParseAction
  {
    private var parsers:Array;
    private var list:Array;

    public function SequenceParser(parsers:Array)
    {
      this.parsers = parsers;
    }

    override public function parseState(state:IParserState):Result
    {
      for each(var parser:IParser in getParsers())
      {
        var result:Result = parser.parseState(state);

        if (!result.success)
        {
          return result;
        }
      }
      return new Result(true, true, action());
    }

    private function getParsers():Array
    {
      if (hasParseAction)
      {
        return parsers;
      }

      list = [];
      var result:Array = [];

      for each(var parser:IParser in parsers)
      {
        result.push(new InstanceListParser(parser, list));
      }

      return result;
    }

    public function extract():Object
    {
      var tmp:Array = list;
      list = [];
      return tmp;
    }

    override protected function get parseAction():IParseAction
    {
      return super.parseAction || this;
    }
  }
}
