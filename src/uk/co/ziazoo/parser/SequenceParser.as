/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:37
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class SequenceParser extends AbstractParser
  {
    private var parsers:Array;

    public function SequenceParser(parsers:Array)
    {
      this.parsers = parsers;
    }

    override public function parseState(state:IParserState):Result
    {
      var list:Array = [];

      for each(var parser:IParser in parsers)
      {
        if (!hasParseAction)
        {
          parser = new InstanceListParser(parser, list);
        }

        var result:Result = parser.parseState(state);

        if (!result.success)
        {
          return result;
        }
      }

      if (hasParseAction)
      {
        return new Result(true, true, action());
      }
      return new Result(true, true, list.length == 1 ? list[0] : list);
    }
  }
}
